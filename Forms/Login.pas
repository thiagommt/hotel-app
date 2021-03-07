unit Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  System.ImageList, FMX.ImgList, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.Ani, System.JSON, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, Data.DB,
  Datasnap.DBClient, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.DBScope, Lib.Notificacao,
  REST.Authenticator.Basic, Principal, System.DateUtils, Lib.FormatValues;

type

  TFrmLogin = class(TForm)
    ImageList: TImageList;
    layout_login: TLayout;
    Layout1: TLayout;
    edt_cpf: TEdit;
    Layout3: TLayout;
    edt_senha: TEdit;
    btn_password: TSpeedButton;
    Layout4: TLayout;
    img_login_logo: TImage;
    StyleBook1: TStyleBook;
    btn_acessar: TButton;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    FloatAnimation1: TFloatAnimation;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTClient: TRESTClient;
    procedure btn_passwordClick(Sender: TObject);
    procedure btn_acessarClick(Sender: TObject);
    procedure edt_cpfTyping(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FJSONString: String;
    FNomeUsuario: String;
    FEmailUsuario: String;
    function EfetuaLogin(CPF: String; Senha: String): Boolean;
    function ProcessLogin: Boolean;
    property JSONString: String read FJSONString write FJSONString;
    // procedure MountPrevisao(URL: String);
    // function SetItensPrevDashboard(ArrayJS: TJSONArray): TItensPrevDashboard;
    { Private declarations }
  public
    property NomeUsuario: String read FNomeUsuario write FNomeUsuario;
    property EmailUsuario: String read FEmailUsuario write FEmailUsuario;
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

function TFrmLogin.ProcessLogin(): Boolean;
var
  JSONObj: TJSONObject;
begin
  Result := False;

  if FrmLogin.RESTRequest.Response.JSONValue = nil then
  begin
    ShowMessage('Erro ao validar login - Invalid JSON!');
    Exit;
  end;

  try
    JSONString := FrmLogin.RESTRequest.Response.JSONValue.ToString;
    JSONObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSONString),
      0) as TJSONObject;

    NomeUsuario := JSONObj.GetValue('nomeusuario').Value;
    EmailUsuario := JSONObj.GetValue('email').Value;

    Result := True;
  finally
    JSONObj.DisposeOf;
  end;
end;

procedure TFrmLogin.btn_passwordClick(Sender: TObject);
begin
  if edt_senha.Password = True then
  begin
    edt_senha.Password := False;
    btn_password.ImageIndex := 0;
  end
  else
  begin
    edt_senha.Password := True;
    btn_password.ImageIndex := 1;
  end;
end;

procedure TFrmLogin.btn_acessarClick(Sender: TObject);
var
  Logado: Boolean;
begin
  Logado := False;
  TLoading.Show(FrmLogin, '');

  TThread.CreateAnonymousThread(
    procedure
    begin
      if EfetuaLogin(edt_cpf.Text, edt_senha.Text) then
        Logado := True;

      TThread.Synchronize(nil,
        procedure()
        begin
          if Logado then
          begin
            TLoading.Hide;

            if not Assigned(FrmPrincipal) then
              Application.CreateForm(TFrmPrincipal, FrmPrincipal);

            Application.MainForm := FrmPrincipal;

            FrmPrincipal.Nome := NomeUsuario;
            FrmPrincipal.Senha := edt_senha.Text;
            FrmPrincipal.StringJS := JSONString;

            FrmPrincipal.Show;
          end
          else
            TLoading.ToastMessage(FrmLogin, 'Dados inválidos. Verifique!',
              TAlignLayout.Bottom, $FFF52A2A, $FFF4F3F3, 4);
        end);

    end).Start;
end;

procedure TFrmLogin.edt_cpfTyping(Sender: TObject);
begin
  { Função abaixo faz com que o CPF
    fique com sua formatação padrão com
    pontos e traços na tela de login. }

  // Formatar(edt_cpf, TFormato.CPF);
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

function TFrmLogin.EfetuaLogin(CPF: String; Senha: String): Boolean;
begin
  Result := False;

  try
    RESTRequest.Params.Clear;
    RESTRequest.Params.AddItem('cpf', CPF);
    RESTRequest.Params.AddItem('senha', Senha);
    RESTRequest.Execute;

    Result := ProcessLogin;
  except
    on Ex: Exception do
    begin
      TLoading.Hide;
      Exit;
    end;
  end;
end;

end.

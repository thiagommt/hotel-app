unit Reserva;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.StrUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Edit, FMX.Effects, FMX.Objects, FMX.Layouts, FMX.StdCtrls,
  FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.ScrollBox, REST.Types, REST.Client, REST.Authenticator.Basic,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.DBScope, Data.DB, Datasnap.DBClient;

type
  TFrmReserva = class(TForm)
    ToolBar: TToolBar;
    Label1: TLabel;
    btn_voltar: TSpeedButton;
    btn_nova_reserva: TSpeedButton;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout5: TLayout;
    Label5: TLabel;
    edt_nome: TEdit;
    Layout6: TLayout;
    Label6: TLabel;
    btn_pesquisa_reserva: TSpeedButton;
    StyleBook1: TStyleBook;
    lv_reservas: TListView;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    HTTPBasicAuthenticator: THTTPBasicAuthenticator;
    ReservaCDS: TClientDataSet;
    ReservaCDSnome: TStringField;
    ReservaCDSdataentrada: TStringField;
    ReservaCDSdatasaida: TStringField;
    ReservaCDStipo: TStringField;
    ReservaCDSvalor: TStringField;
    ReservaCDSemail: TStringField;
    ReservaCDStelefone: TStringField;
    BindSourceDB: TBindSourceDB;
    BindingsList: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    AniIndicator: TAniIndicator;
    procedure btn_voltarClick(Sender: TObject);
    procedure btn_pesquisa_reservaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_nova_reservaClick(Sender: TObject);
  private
    procedure PesquisaReservas(Nome, NomeUser, Senha, BaseUrl: String);
    procedure MountReserva(Dados: TJSONObject);
    procedure ClearDataSet(pDataSet: TClientDataSet);
    function FormatDateJSON(DateJS: String): String;
    // function FormatDateJSON(DateJS: String): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReserva: TFrmReserva;

implementation

{$R *.fmx}

uses Lib.Notificacao, Principal, NovaReserva;

procedure TFrmReserva.btn_nova_reservaClick(Sender: TObject);
begin
  if not Assigned(FrmNovaReserva) then
    Application.CreateForm(TFrmNovaReserva, FrmNovaReserva);

  FrmNovaReserva.BaseUrlNova := FrmPrincipal.BaseUrl;
  FrmNovaReserva.NomeUser := FrmPrincipal.Nome;
  FrmNovaReserva.SenhaUser := FrmPrincipal.Senha;

  FrmNovaReserva.Show;
  Close;
end;

procedure TFrmReserva.btn_pesquisa_reservaClick(Sender: TObject);
begin
  if Trim(edt_nome.Text) = '' then
  begin
    TLoading.ToastMessage(FrmReserva,
      'Informe um nome para realizar a pesquisa.', TAlignLayout.Bottom,
      $FFFE7827, $FFF4F3F3, 3);
  end
  else
  begin
    ClearDataSet(ReservaCDS);
    PesquisaReservas(edt_nome.Text, FrmPrincipal.Nome, FrmPrincipal.Senha,
      FrmPrincipal.BaseUrl);
  end;

end;

procedure TFrmReserva.btn_voltarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmReserva.FormCreate(Sender: TObject);
begin
  ReservaCDS.Close;
  ReservaCDS.CreateDataSet;
  ReservaCDS.Open;

  lv_reservas.Enabled := True;
  AniIndicator.Visible := False;
end;

procedure TFrmReserva.ClearDataSet(pDataSet: TClientDataSet);
begin
  pDataSet.DisableControls;
  pDataSet.First;
  while not pDataSet.eof do
  begin
    pDataSet.Delete;
  end;
  pDataSet.EnableControls;
end;

procedure TFrmReserva.PesquisaReservas(Nome: String; NomeUser: String;
  Senha: String; BaseUrl: String);
var
  JSON: String;
  ObjectoReservaJS: TJSONObject;
begin
  RESTClient.BaseUrl := BaseUrl;
  RESTRequest.Resource := 'customservice/reservasearch?';
  RESTRequest.Params.AddItem('nome', Nome);
  HTTPBasicAuthenticator.Username := NomeUser;
  HTTPBasicAuthenticator.Password := Senha;

  try
    RESTRequest.Execute;
    JSON := RESTRequest.Response.JSONValue.ToString;
    ObjectoReservaJS := TJSONObject.ParseJSONValue
      (TEncoding.UTF8.GetBytes(JSON), 0) as TJSONObject;
    MountReserva(ObjectoReservaJS);
  except
    on E: Exception do
      TLoading.ToastMessage(FrmReserva,
        'Erro ao realizar pesquisa. Verifique os parâmetros!',
        TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
  end;

end;

procedure TFrmReserva.MountReserva(Dados: TJSONObject);
var
  ReservaJA: TJSONArray;
  ReservaJV: TJSONValue;
  ReservaJS: TJSONObject;
  Nome, DataSaida, DataEntrada, Tipo, Telefone, Email, Valor: String;
begin
  if Dados.TryGetValue('value', ReservaJA) then
  begin
    if ReservaJA.Count > 0 then
    begin
      ReservaCDS.First;
      for ReservaJV in ReservaJA do
      begin
        ReservaJS := ReservaJV as TJSONObject;
        ReservaJS.TryGetValue('nome', Nome);
        ReservaJS.TryGetValue('dataentrada', DataEntrada);
        ReservaJS.TryGetValue('datasaida', DataSaida);
        ReservaJS.TryGetValue('tipo', Tipo);
        ReservaJS.TryGetValue('valortotal', Valor);
        ReservaJS.TryGetValue('telefone', Telefone);
        ReservaJS.TryGetValue('email', Email);
        ReservaCDS.Append;
        if Nome <> '' then
          ReservaCDSnome.AsString := Nome
        else
          ReservaCDSnome.AsString := 'Nome não informado';

        if DataSaida <> '' then
          ReservaCDSdatasaida.AsString := FormatDateJSON(DataSaida)
        else
          ReservaCDSdatasaida.AsString := 'Sem Saída.';

        if DataEntrada <> '' then
          ReservaCDSdataentrada.AsString := FormatDateJSON(DataEntrada)
        else
          ReservaCDSdataentrada.AsString := 'Sem Entrada';

        if Telefone <> '' then
          ReservaCDStelefone.AsString := Telefone
        else
          ReservaCDStelefone.AsString := 'Sem Telefone';

        if Email <> '' then
          ReservaCDSemail.AsString := Email
        else
          ReservaCDSemail.AsString := 'Sem E-mail';

        if Valor <> '' then
          ReservaCDSvalor.AsString := Valor
        else
          ReservaCDSvalor.AsString := 'R$ 0,00';

        if Tipo <> '' then
          ReservaCDStipo.AsString := Tipo
        else
          ReservaCDStipo.AsString := 'Sem Tipo';
        ReservaCDS.Post;
      end;
      ReservaCDS.First;
    end
    else
    begin
      TLoading.ToastMessage(FrmReserva, 'Nenhuma reserva encontrada.',
        TAlignLayout.Bottom, $FFF52A2A, $FFF4F3F3, 3);
      Exit;
    end;
  end;
end;

function TFrmReserva.FormatDateJSON(DateJS: String): String;
begin
  Result := LeftStr(DateJS, 10);
end;

end.

unit NovaReserva;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Effects, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, REST.Types, REST.Client, REST.Authenticator.Basic,
  Data.Bind.Components, Data.Bind.ObjectScope, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.DBScope, Data.DB, Datasnap.DBClient, System.JSON,
  FMX.TabControl, System.Actions, FMX.ActnList, Lib.FormatValues,
  FMX.DateTimeCtrls, FMX.EditBox, FMX.SpinBox, DateUtils;

type
  TFrmNovaReserva = class(TForm)
    ToolBar: TToolBar;
    lb_nova_reserva: TLabel;
    rect_dados_nova_reserva: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout3: TLayout;
    Label3: TLabel;
    edt_email: TEdit;
    Layout4: TLayout;
    Label4: TLabel;
    edt_telefone: TEdit;
    Layout5: TLayout;
    Label5: TLabel;
    edt_nome: TEdit;
    Layout6: TLayout;
    Label6: TLabel;
    lv_acomodacoes: TListView;
    Line5: TLine;
    btn_voltar: TSpeedButton;
    btn_limpar: TSpeedButton;
    StyleBook1: TStyleBook;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    HTTPBasicAuthenticator: THTTPBasicAuthenticator;
    AcomodacoesCDS: TClientDataSet;
    AcomodacoesCDSid: TIntegerField;
    AcomodacoesCDScodigo: TStringField;
    AcomodacoesCDSdescricao: TStringField;
    BindSourceDB: TBindSourceDB;
    BindingsList: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    TabControl: TTabControl;
    TabNovaReserva: TTabItem;
    TabConfirmaReserva: TTabItem;
    ActionList: TActionList;
    ActNovaReserva: TChangeTabAction;
    ActConfirmaReserva: TChangeTabAction;
    rect_confirma_reserva: TRectangle;
    ShadowEffect2: TShadowEffect;
    btn_confirma_reserva: TButton;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Label1: TLabel;
    lb_solicitante_nome: TLabel;
    Label7: TLabel;
    lb_a_c_f: TLabel;
    Label9: TLabel;
    lb_email_telefone: TLabel;
    Label11: TLabel;
    lb_vl_total_reserva: TLabel;
    btn_proxima: TSpeedButton;
    Layout10: TLayout;
    Label2: TLabel;
    lb_acomodacao_uh: TLabel;
    TabAcomodacao: TTabItem;
    Rectangle1: TRectangle;
    ShadowEffect3: TShadowEffect;
    Layout11: TLayout;
    Label8: TLabel;
    Layout12: TLayout;
    Layout13: TLayout;
    Label12: TLabel;
    dt_entrada: TDateEdit;
    Layout14: TLayout;
    Layout15: TLayout;
    dt_saida: TDateEdit;
    Label13: TLabel;
    Layout16: TLayout;
    Label10: TLabel;
    Layout17: TLayout;
    Label14: TLabel;
    sb_adultos: TSpinBox;
    sb_criancas: TSpinBox;
    Layout18: TLayout;
    Label15: TLabel;
    sb_free: TSpinBox;
    lv_tp_acomodacao: TListView;
    Layout19: TLayout;
    Layout20: TLayout;
    Label16: TLabel;
    Layout21: TLayout;
    Label17: TLabel;
    Layout22: TLayout;
    Label18: TLabel;
    lb_num_diarias: TLabel;
    lb_vl_diaria: TLabel;
    lb_vl_total: TLabel;
    ActAcomodacao: TChangeTabAction;
    Layout23: TLayout;
    lb_hospede: TLabel;
    Line1: TLine;
    btn_add_hosp: TSpeedButton;
    lv_hospedes: TListView;
    edt_hospede: TEdit;
    btn_exclui_hosp: TSpeedButton;
    Text1: TText;
    TextAcomodacao: TText;
    btn_pesquisa_tp_acmd: TSpeedButton;
    Layout24: TLayout;
    TipoAcmdCDS: TClientDataSet;
    TipoAcmdCDSdescricao: TStringField;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    btn_pesquisa_acmd: TSpeedButton;
    TipoAcmdCDSdiaria: TStringField;
    TipoAcmdCDSquantidadeDisp: TStringField;
    Layout25: TLayout;
    Label19: TLabel;
    lb_diarias_s_e: TLabel;
    Line2: TLine;
    procedure btn_voltarClick(Sender: TObject);
    procedure btn_limparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_proximaClick(Sender: TObject);
    procedure lv_acomodacoesItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure btn_confirma_reservaClick(Sender: TObject);
    procedure edt_telefoneTyping(Sender: TObject);
    procedure btn_add_hospClick(Sender: TObject);
    procedure lv_hospedesItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure btn_exclui_hospClick(Sender: TObject);
    procedure lv_hospedesExit(Sender: TObject);
    procedure btn_pesquisa_tp_acmdClick(Sender: TObject);
    procedure dt_saidaClosePicker(Sender: TObject);
    procedure btn_pesquisa_acmdClick(Sender: TObject);
    procedure lv_tp_acomodacaoItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
  private
    FBaseUrlNova: String;
    FNomeUser: String;
    FSenhaUser: String;
    FCodigoAcomodacao: String;
    FDescricaoAcomodacao: String;
    FIndexHospede: Integer;
    procedure EfetuaReserva(Nome, Email, Telefone: String);
    procedure PesquisaAcomodacoes(BaseUrl: String);
    procedure MountListAcomodacao(Dados: TJSONObject);
    procedure ValidateCampos;
    procedure InsertHospedeList(Hospede: String);
    procedure SetHospDelete(IndexHosp: Integer);
    procedure MountListTpAcmd(BaseUrl, DataEntrada, DataSaida: String);
    procedure MountTpAcmd(Dados: TJSONObject);
    procedure ClearDataSet(pDataSet: TClientDataSet);
    procedure CalculaDiaria(ValorDiaria: String);
    property CodigoAcomodacao: String read FCodigoAcomodacao
      write FCodigoAcomodacao;
    property DescricaoAcomodacao: String read FDescricaoAcomodacao
      write FDescricaoAcomodacao;
    property IndexHospede: Integer read FIndexHospede write FIndexHospede;
    procedure ValidateDatas;
    { Private declarations }
  public
    property BaseUrlNova: String read FBaseUrlNova write FBaseUrlNova;
    property NomeUser: String read FNomeUser write FNomeUser;
    property SenhaUser: String read FSenhaUser write FSenhaUser;
    { Public declarations }
  end;

var
  FrmNovaReserva: TFrmNovaReserva;

implementation

{$R *.fmx}

uses Lib.Notificacao, Principal;

procedure TFrmNovaReserva.btn_pesquisa_acmdClick(Sender: TObject);
begin
  TLoading.Show(FrmNovaReserva, 'Pesquisando Acomodações...');

  TThread.CreateAnonymousThread(
    procedure
    begin
      PesquisaAcomodacoes(BaseUrlNova);

      TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;
        end);
    end).Start;
end;

procedure TFrmNovaReserva.btn_pesquisa_tp_acmdClick(Sender: TObject);
var
  DataI, DataF: String;
begin
  ValidateDatas;

  DataI := dt_entrada.Text;
  DataF := dt_saida.Text;

  TLoading.Show(FrmNovaReserva, '');

  TThread.CreateAnonymousThread(
    procedure
    begin
      MountListTpAcmd(BaseUrlNova, DataI, DataF);

      TThread.Synchronize(nil,
        procedure()
        begin
          TLoading.Hide;
          TextAcomodacao.Visible := False;
        end);

    end).Start;
end;

procedure TFrmNovaReserva.MountListTpAcmd(BaseUrl: String; DataEntrada: String;
DataSaida: String);
var
  JSON: String;
  ObjectTpAcmdJS: TJSONObject;
begin
  RESTClient.BaseUrl := BaseUrl;
  RESTRequest.Resource := 'customservice/disponibilidade?';
  RESTRequest.Params.AddItem('datai', DataEntrada);
  RESTRequest.Params.AddItem('dataf', DataSaida);
  HTTPBasicAuthenticator.Username := NomeUser;
  HTTPBasicAuthenticator.Password := SenhaUser;

  try
    RESTRequest.Execute;
    JSON := RESTRequest.Response.JSONValue.ToString;
    ObjectTpAcmdJS := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON),
      0) as TJSONObject;

    MountTpAcmd(ObjectTpAcmdJS);
  except
    on E: Exception do
      TLoading.ToastMessage(FrmNovaReserva,
        'Erro ao consultar os tipos de acomodações. Contate ao suporte!',
        TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
  end;
end;

procedure TFrmNovaReserva.MountTpAcmd(Dados: TJSONObject);
var
  TpAcomodacaoJA: TJSONArray;
  TpAcomodacaoJV: TJSONValue;
  TpAcomodacaoJS: TJSONObject;
  Descricao: String;
  Diaria: String;
  QuantidadeDisp: String;
begin
  if Dados.TryGetValue('value', TpAcomodacaoJA) then
  begin
    TipoAcmdCDS.First;
    for TpAcomodacaoJV in TpAcomodacaoJA do
    begin
      TpAcomodacaoJS := TpAcomodacaoJV as TJSONObject;
      TpAcomodacaoJS.TryGetValue('quantidade', QuantidadeDisp);
      TpAcomodacaoJS.TryGetValue('diaria', Diaria);
      TpAcomodacaoJS.TryGetValue('descricao', Descricao);
      TipoAcmdCDS.Append;
      TipoAcmdCDSdescricao.AsString := Descricao;
      TipoAcmdCDSdiaria.AsString := 'R$ ' + Diaria;
      TipoAcmdCDSquantidadeDisp.AsString := QuantidadeDisp + ' Disponíveis';
      TipoAcmdCDS.Post;
    end;
    TipoAcmdCDS.First;
  end;
end;

procedure TFrmNovaReserva.MountListAcomodacao(Dados: TJSONObject);
var
  AcomodacaoJA: TJSONArray;
  AcomodacaoJV: TJSONValue;
  AcomodacaoJS: TJSONObject;
  Id: Integer;
  Codigo: String;
  Descricao: String;
begin
  if Dados.TryGetValue('value', AcomodacaoJA) then
  begin
    AcomodacoesCDS.First;
    for AcomodacaoJV in AcomodacaoJA do
    begin
      AcomodacaoJS := AcomodacaoJV as TJSONObject;
      AcomodacaoJS.TryGetValue('$id', Id);
      AcomodacaoJS.TryGetValue('codigo', Codigo);
      AcomodacaoJS.TryGetValue('descricao', Descricao);
      AcomodacoesCDS.Append;
      AcomodacoesCDSid.AsInteger := Id;
      AcomodacoesCDScodigo.AsString := Codigo;
      AcomodacoesCDSdescricao.AsString := Descricao;
      AcomodacoesCDS.Post;
    end;
    AcomodacoesCDS.First;
  end;
end;

procedure TFrmNovaReserva.btn_proximaClick(Sender: TObject);
begin
  if TabControl.ActiveTab = TabNovaReserva then
    ActAcomodacao.ExecuteTarget(Self)
  else if TabControl.ActiveTab = TabAcomodacao then
  begin
    ValidateCampos;
    lb_solicitante_nome.Text := FrmPrincipal.Nome + ' | ' + edt_nome.Text;
    lb_email_telefone.Text := edt_email.Text + ' | ' + edt_telefone.Text;
    lb_acomodacao_uh.Text := CodigoAcomodacao + ' - ' + DescricaoAcomodacao;
    lb_diarias_s_e.Text := lb_num_diarias.Text + ' | ' + dt_entrada.Text + ' - '
      + dt_saida.Text;
    lb_a_c_f.Text := 'Adultos: ' + sb_adultos.Text + ' | Crianças: ' + sb_criancas.Text + '| Free: ' + sb_free.Text;
    lb_vl_total_reserva.Text := lb_vl_total.Text;
    ActConfirmaReserva.ExecuteTarget(Self);
    btn_limpar.Visible := False;
    btn_proxima.Visible := False;
  end;
end;

procedure TFrmNovaReserva.btn_voltarClick(Sender: TObject);
begin
  if TabControl.ActiveTab = TabNovaReserva then
  begin
    Close;
    ClearDataSet(AcomodacoesCDS);
    ClearDataSet(TipoAcmdCDS);
  end
  else if TabControl.ActiveTab = TabAcomodacao then
  begin
    ActNovaReserva.ExecuteTarget(Self);
    btn_limpar.Visible := True;
    btn_proxima.Visible := True;
  end
  else if TabControl.ActiveTab = TabConfirmaReserva then
    ActAcomodacao.ExecuteTarget(Self);
end;

procedure TFrmNovaReserva.ValidateCampos;
begin
  if Trim(edt_nome.Text) = '' then
  begin
    TLoading.ToastMessage(FrmNovaReserva, 'Informe um Nome para Reserva',
      TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
    Abort;
  end;

  if Trim(edt_email.Text) = '' then
  begin
    TLoading.ToastMessage(FrmNovaReserva, 'Informe um E-mail para Reserva',
      TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
    Abort;
  end;

  if Trim(edt_telefone.Text) = '' then
  begin
    TLoading.ToastMessage(FrmNovaReserva, 'Informe um Telefone para Reserva',
      TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
    Abort;
  end;

  if (CodigoAcomodacao = '') or (DescricaoAcomodacao = '') then
  begin
    TLoading.ToastMessage(FrmNovaReserva,
      'Acomodação inválida ou não selecionada', TAlignLayout.Bottom, $FFFE7827,
      $FFF4F3F3, 3);
    Abort;
  end;

  if Pos('@', edt_email.Text) = 0 then
  begin
    TLoading.ToastMessage(FrmNovaReserva, 'Informar E-mail válido',
      TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
    Abort;
  end;

  if (sb_adultos.Text = '') and (sb_criancas.Text = '') and
    (sb_free.Text = '') then
  begin
    TLoading.ToastMessage(FrmNovaReserva,
      'Quantidade de pessoas para reserva deve ser maior que 0',
      TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
    Abort;
  end;

  ValidateDatas;
end;

procedure TFrmNovaReserva.edt_telefoneTyping(Sender: TObject);
begin
  Formatar(edt_telefone, TFormato.Celular);
end;

procedure TFrmNovaReserva.btn_add_hospClick(Sender: TObject);
begin
  if lb_hospede.Visible = True then
  begin
    lb_hospede.Visible := False;
    edt_hospede.Visible := True;
    btn_add_hosp.StyleLookup := 'donetoolbutton';
  end
  else
  begin
    if Trim(edt_hospede.Text) = '' then
    begin
      Abort;
      TLoading.ToastMessage(FrmNovaReserva, 'Informe o nome do Hóspede',
        TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
    end
    else
      InsertHospedeList(edt_hospede.Text);

    lb_hospede.Visible := True;
    edt_hospede.Visible := False;
    btn_add_hosp.StyleLookup := 'additembutton';
  end;
end;

procedure TFrmNovaReserva.btn_confirma_reservaClick(Sender: TObject);
begin
  EfetuaReserva(edt_nome.Text, edt_email.Text, edt_telefone.Text);
end;

procedure TFrmNovaReserva.btn_exclui_hospClick(Sender: TObject);
begin
  SetHospDelete(IndexHospede);
end;

procedure TFrmNovaReserva.ClearDataSet(pDataSet: TClientDataSet);
begin
  pDataSet.DisableControls;
  pDataSet.First;
  while not pDataSet.eof do
  begin
    pDataSet.Delete;
  end;
  pDataSet.EnableControls;
end;

procedure TFrmNovaReserva.dt_saidaClosePicker(Sender: TObject);
var
  DataI, DataF: TDateTime;
begin
  if (dt_saida.Text <> '') and (dt_entrada.Text <> '') then
  begin
    DataI := StrToDate(dt_entrada.Text);
    DataF := StrToDate(dt_saida.Text);
    lb_num_diarias.Text := IntToStr(DaysBetween(DataF, DataI));
  end;
end;

procedure TFrmNovaReserva.ValidateDatas;
begin
  if (dt_entrada.Text = '') or (dt_saida.Text = '__/__/____') then
  begin
    TLoading.ToastMessage(FrmNovaReserva,
      'Informe as datas de entrada e saída corretamente', TAlignLayout.Bottom,
      4294866983, 4294243315, 3);
    Abort;
  end;

  if dt_saida.Date < dt_entrada.Date then
  begin
    TLoading.ToastMessage(FrmNovaReserva,
      'Data Saída não pode ser menor que Data Entrada', TAlignLayout.Bottom,
      4294866983, 4294243315, 3);
    Abort;
  end;
end;

procedure TFrmNovaReserva.btn_limparClick(Sender: TObject);
begin
  edt_email.Text := '';
  edt_telefone.Text := '';
  edt_nome.Text := '';
  lv_hospedes.Items.Clear;
  lv_tp_acomodacao.Items.Clear;
  lv_acomodacoes.Items.Clear;
  TextAcomodacao.Visible := True;

  TLoading.ToastMessage(FrmNovaReserva, 'Campos de cadastro limpos',
    TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
end;

procedure TFrmNovaReserva.InsertHospedeList(Hospede: String);
var
  Item: TListViewItem;
begin
  lv_hospedes.BeginUpdate;
  Item := lv_hospedes.Items.Add;
  Item.Data['Nome'] := Hospede;
  lv_hospedes.EndUpdate;

  edt_hospede.Text := '';
end;

procedure TFrmNovaReserva.EfetuaReserva(Nome: String; Email: String;
Telefone: String);
begin
  TLoading.Show(FrmNovaReserva, 'Realizando Reserva...');
  TThread.CreateAnonymousThread(
    procedure
    begin
      // MoutJSONReserva(Nome, ); // FAZ RESERVA NO BACKEND

      TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;
          Close;
          TLoading.ToastMessage(FrmPrincipal, 'Reserva Realizada',
            TAlignLayout.Bottom, $FF47C813, $FFF4F3F3, 3);
        end);
    end).Start;
end;

procedure TFrmNovaReserva.FormCreate(Sender: TObject);
begin
  AcomodacoesCDS.Close;
  AcomodacoesCDS.CreateDataSet;
  AcomodacoesCDS.Open;

  TipoAcmdCDS.Close;
  TipoAcmdCDS.CreateDataSet;
  TipoAcmdCDS.Open;

  lv_hospedes.DeleteButtonText := 'Excluir';
end;

procedure TFrmNovaReserva.FormShow(Sender: TObject);
begin
  TabControl.ActiveTab := TabNovaReserva;
end;

procedure TFrmNovaReserva.lv_acomodacoesItemClickEx(const Sender: TObject;
ItemIndex: Integer; const LocalClickPos: TPointF;
const ItemObject: TListItemDrawable);
begin
  CodigoAcomodacao := AcomodacoesCDScodigo.AsString;
  DescricaoAcomodacao := AcomodacoesCDSdescricao.AsString;
end;

procedure TFrmNovaReserva.lv_hospedesExit(Sender: TObject);
begin
  btn_exclui_hosp.Visible := False;
end;

procedure TFrmNovaReserva.lv_hospedesItemClickEx(const Sender: TObject;
ItemIndex: Integer; const LocalClickPos: TPointF;
const ItemObject: TListItemDrawable);
begin
  if lb_hospede.Visible = True then
  begin
    btn_exclui_hosp.Visible := True;
    IndexHospede := ItemIndex;
  end;
end;

procedure TFrmNovaReserva.lv_tp_acomodacaoItemClickEx(const Sender: TObject;
ItemIndex: Integer; const LocalClickPos: TPointF;
const ItemObject: TListItemDrawable);
begin
  if TipoAcmdCDSquantidadeDisp.AsString = '0' then
  begin
    TLoading.ToastMessage(FrmNovaReserva,
      'Não há disponibilidade nesse tipo de acomodação', TAlignLayout.Bottom,
      $FFFE7827, $FFF4F3F3, 3);
    Abort;
  end;
  lb_vl_diaria.Text := '100,00'; // TipoAcmdCDSdiaria.AsString;
  CalculaDiaria(lb_vl_diaria.Text);
end;

procedure TFrmNovaReserva.SetHospDelete(IndexHosp: Integer);
begin
  lv_hospedes.Items.Delete(IndexHosp);
  btn_exclui_hosp.Visible := False;
end;

procedure TFrmNovaReserva.CalculaDiaria(ValorDiaria: String);
var
  Diaria: Double;
  TotalPessoas: Integer;
begin
  Diaria := StrToFloat(ValorDiaria);
  TotalPessoas := StrToInt(sb_adultos.Text) + StrToInt(sb_criancas.Text);

  if TotalPessoas = 0 then
  begin
    TLoading.ToastMessage(FrmNovaReserva,
      'Preencha o número de pessoas para reserva', TAlignLayout.Bottom,
      $FFFE7827, $FFF4F3F3, 3);
    Abort;
  end;

  Diaria := (Diaria * TotalPessoas);
  lb_vl_total.Text := FloatToStr(Diaria);
end;

procedure TFrmNovaReserva.PesquisaAcomodacoes(BaseUrl: String);
var
  JSON: String;
  ObjectAcomodacaoJS: TJSONObject;
begin
  RESTClient.BaseUrl := BaseUrl;
  RESTRequest.Resource := 'tipouh';
  HTTPBasicAuthenticator.Username := NomeUser;
  HTTPBasicAuthenticator.Password := SenhaUser;

  try
    RESTRequest.Execute;
    JSON := RESTRequest.Response.JSONValue.ToString;
    ObjectAcomodacaoJS := TJSONObject.ParseJSONValue
      (TEncoding.UTF8.GetBytes(JSON), 0) as TJSONObject;

    MountListAcomodacao(ObjectAcomodacaoJS);
  except
    on E: Exception do
      TLoading.ToastMessage(FrmNovaReserva,
        'Erro ao consultar acomodações. Contate ao suporte!',
        TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
  end;
end;

end.

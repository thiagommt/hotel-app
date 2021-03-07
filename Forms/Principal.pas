unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Ani, FMX.Controls.Presentation, FMX.Layouts,
  System.ImageList, FMX.ImgList, FMX.DateTimeCtrls, FMXTee.Engine,
  FMXTee.Series, FMXTee.Procs, FMXTee.Chart, FMX.Effects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  Lib.Notificacao, REST.Authenticator.Basic, System.JSON, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.DB, Datasnap.DBClient, Data.Bind.Components,
  Data.Bind.DBScope, REST.Types, REST.Client, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.ObjectScope, FMX.ListBox,
  FMX.MultiView;

type
  TItensDashboard = Record
    UHs: String;
    Adulto: String;
    Crianca: String;
    Free: String;
    Total: Integer;
  end;

  TItensPrevDashboard = Record
    Data: String;
    Ocupada: String;
    Livre: String;
    Interditada: String;
    Total: Integer;
  end;

  TFrmPrincipal = class(TForm)
    layout_principal: TLayout;
    ToolBar: TToolBar;
    Label1: TLabel;
    Circle: TCircle;
    ImageList: TImageList;
    layout_dados: TLayout;
    layout_infos_numero: TLayout;
    layout_infos_grafico: TLayout;
    layout_hospedes_casa: TLayout;
    layout_previsao_final_dia: TLayout;
    layout_saidas_previstas: TLayout;
    layout_entradas_previstas: TLayout;
    Rectangle2: TRectangle;
    Layout1: TLayout;
    Label5: TLabel;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Label6: TLabel;
    Rectangle3: TRectangle;
    Layout3: TLayout;
    Label7: TLabel;
    Rectangle4: TRectangle;
    Layout4: TLayout;
    Label8: TLabel;
    rect_disponibilidade: TRectangle;
    Layout5: TLayout;
    Label10: TLabel;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Label11: TLabel;
    Layout9: TLayout;
    Layout10: TLayout;
    dt_base: TDateEdit;
    rect_ocupados: TRectangle;
    rect_livres: TRectangle;
    rect_interditados: TRectangle;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    chart_disponibilidade: TChart;
    Series1: TBarSeries;
    Layout11: TLayout;
    Label30: TLabel;
    lbl_hospedes_casa: TLabel;
    Layout12: TLayout;
    lbl_entradas_previstas: TLabel;
    Layout13: TLayout;
    lbl_previsao_final_dia: TLabel;
    Layout14: TLayout;
    lbl_saidas_previstas: TLabel;
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    Line4: TLine;
    Label15: TLabel;
    lb_message_data_base: TLabel;
    Label17: TLabel;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    Line5: TLine;
    Line6: TLine;
    Line7: TLine;
    Line8: TLine;
    Line9: TLine;
    Layout16: TLayout;
    Layout17: TLayout;
    Layout18: TLayout;
    Label19: TLabel;
    lb_total_hospedes_casa: TLabel;
    Layout19: TLayout;
    btn_info_hosp_casa: TSpeedButton;
    Layout20: TLayout;
    Layout21: TLayout;
    Label21: TLabel;
    Layout22: TLayout;
    lb_total_entradas_prev: TLabel;
    Layout23: TLayout;
    btn_info_entradas_prev: TSpeedButton;
    Layout24: TLayout;
    Layout25: TLayout;
    Label22: TLabel;
    Layout26: TLayout;
    lb_total_prev_final_dia: TLabel;
    Layout27: TLayout;
    btn_info_prev_final_dia: TSpeedButton;
    Layout28: TLayout;
    Layout29: TLayout;
    Label24: TLabel;
    Layout30: TLayout;
    lb_total_saidas_prev: TLabel;
    Layout31: TLayout;
    btn_info_saida_prev: TSpeedButton;
    layout_infos: TLayout;
    rect_informacao: TRectangle;
    Layout32: TLayout;
    lb_informacao: TLabel;
    Line10: TLine;
    btn_fecha_informacao: TSpeedButton;
    layout_saida_hosp_entrada: TLayout;
    layout_uhs: TLayout;
    layout_adultos: TLayout;
    layout_free: TLayout;
    layout_criancas: TLayout;
    layout_total: TLayout;
    Label23: TLabel;
    lb_adultos_info: TLabel;
    Rectangle5: TRectangle;
    lb_criancas_info: TLabel;
    Rectangle6: TRectangle;
    Label27: TLabel;
    lb_uhs_info: TLabel;
    Rectangle7: TRectangle;
    Label29: TLabel;
    lb_free_info: TLabel;
    Rectangle8: TRectangle;
    Label32: TLabel;
    lb_total_info: TLabel;
    Rectangle9: TRectangle;
    Label34: TLabel;
    StyleBook1: TStyleBook;
    layout_menu: TLayout;
    rect_fundo: TRectangle;
    rect_select_hotel: TRectangle;
    lv_hotel: TListView;
    Layout34: TLayout;
    Label35: TLabel;
    Line11: TLine;
    ConsultaBS: TBindSourceDB;
    BindingsList1: TBindingsList;
    ConsultaCDS: TClientDataSet;
    ConsultaCDSnome: TStringField;
    ConsultaCDSbaseurl: TStringField;
    LinkListControlToField1: TLinkListControlToField;
    RESTClient: TRESTClient;
    RESTResponse: TRESTResponse;
    RESTRequest: TRESTRequest;
    MultiViewMain: TMultiView;
    rect_fundo_listbox: TRectangle;
    list_menu: TListBox;
    lbi_reservas: TListBoxItem;
    lbi_infos: TListBoxItem;
    lbi_troca_conta_hotel: TListBoxItem;
    lbi_sair: TListBoxItem;
    layout_superior: TLayout;
    rect_usuario: TRectangle;
    ShadowEffectMultView: TShadowEffect;
    lb_nome_hotel: TLabel;
    btn_menu: TButton;
    Circle2: TCircle;
    lbi_nova_reserva: TListBoxItem;
    btn_select_hotel: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure rect_nova_reservaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rect_nova_reservaMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btn_info_hosp_casaClick(Sender: TObject);
    procedure btn_info_saida_prevClick(Sender: TObject);
    procedure btn_info_entradas_prevClick(Sender: TObject);
    procedure btn_info_prev_final_diaClick(Sender: TObject);
    procedure btn_fecha_informacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lv_hotelItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure list_menuItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure MultiViewMainShown(Sender: TObject);
    procedure MultiViewMainHidden(Sender: TObject);
    procedure dt_baseClosePicker(Sender: TObject);
    procedure lbl_previsao_final_diaClick(Sender: TObject);
    procedure btn_select_hotelClick(Sender: TObject);
  private
    FBaseUrl: String;
    FUhsHospedes: String;
    FAdultosHospedes: String;
    FCriancasHospedes: String;
    FFreeHospedes: String;
    FTotalHospedes: Integer;
    FUhsEntradas: String;
    FAdultosEntradas: String;
    FCriancasEntradas: String;
    FFreeEntradas: String;
    FTotalEntradas: Integer;
    FUhsSaidas: String;
    FAdultosSaidas: String;
    FCriancasSaidas: String;
    FFreeSaidas: String;
    FTotalSaidas: Integer;
    FSenha: String;
    FStringJS: String;
    FNomeHotel: String;
    FNome: String;
    FEmail: String;
    FHotelSelected: Boolean;

    procedure SetPropertiesForm;
    procedure EscondeSelecaoHotel;
    procedure OpenNovaReserva;
    procedure OpenInfos;
    procedure MountPrevisao(DataBase: String);
    procedure OpenLogin;
    procedure ClearDataSet(pDataSet: TClientDataSet);

    // Hóspedes
    property UhsHospedes: String read FUhsHospedes write FUhsHospedes;
    property AdultosHospedes: String read FAdultosHospedes
      write FAdultosHospedes;
    property CriancasHospedes: String read FCriancasHospedes
      write FCriancasHospedes;
    property FreeHospedes: String read FFreeHospedes write FFreeHospedes;
    property TotalHospedes: Integer read FTotalHospedes write FTotalHospedes;
    // Entradas
    property UhsEntradas: String read FUhsEntradas write FUhsEntradas;
    property AdultosEntradas: String read FAdultosEntradas
      write FAdultosEntradas;
    property CriancasEntradas: String read FCriancasEntradas
      write FCriancasEntradas;
    property FreeEntradas: String read FFreeEntradas write FFreeEntradas;
    property TotalEntradas: Integer read FTotalEntradas write FTotalEntradas;
    // Saídas
    property UhsSaidas: String read FUhsSaidas write FUhsSaidas;
    property AdultosSaidas: String read FAdultosSaidas write FAdultosSaidas;
    property CriancasSaidas: String read FCriancasSaidas write FCriancasSaidas;
    property FreeSaidas: String read FFreeSaidas write FFreeSaidas;
    property TotalSaidas: Integer read FTotalSaidas write FTotalSaidas;
    property HotelSelected: Boolean read FHotelSelected write FHotelSelected;

    procedure ExibirInformacao(InfoSelecionada: String);
    procedure EscondeInformacao;
    procedure MountListHotel(Dados: TJSONObject);
    procedure MountMenu(URL: String);
    procedure GetValuesDashboard(JSONObj: TJSONObject);
    function SetItensDashboard(ObjetoJS: TJSONObject): TItensDashboard;
    procedure ExibirSelecaoHotel;
    procedure OpenReserva;
    { Private declarations }
  public
    // User
    property Nome: String read FNome write FNome;
    property Email: String read FEmail write FEmail;
    property Senha: String read FSenha write FSenha;
    property StringJS: String read FStringJS write FStringJS;
    // Hotel
    property BaseUrl: String read FBaseUrl write FBaseUrl;
    property NomeHotel: String read FNomeHotel write FNomeHotel;
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses NovaReserva, Login, Reserva;

procedure TFrmPrincipal.btn_fecha_informacaoClick(Sender: TObject);
begin
  EscondeInformacao;
end;

procedure TFrmPrincipal.btn_info_entradas_prevClick(Sender: TObject);
begin
  ExibirInformacao('Entradas Previstas');
end;

procedure TFrmPrincipal.btn_info_hosp_casaClick(Sender: TObject);
begin
  ExibirInformacao('Hospedes na Casa');
end;

procedure TFrmPrincipal.btn_info_prev_final_diaClick(Sender: TObject);
begin
  // ExibirInformacao('Previsão Final do Dia');
end;

procedure TFrmPrincipal.btn_info_saida_prevClick(Sender: TObject);
begin
  ExibirInformacao('Saídas Previstas');
end;

procedure TFrmPrincipal.btn_select_hotelClick(Sender: TObject);
begin
  if HotelSelected = True then
  begin
    EscondeSelecaoHotel;
    lb_nome_hotel.Text := ConsultaCDSnome.AsString;
    if lv_hotel.ItemCount > 1 then
      lbi_troca_conta_hotel.Visible := True;
    SetPropertiesForm;
  end
  else
    TLoading.ToastMessage(FrmPrincipal, 'Selecione um Hotel na lista',
      TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
end;

procedure TFrmPrincipal.dt_baseClosePicker(Sender: TObject);
begin
  if dt_base.Text <> '' then
  begin
    lb_message_data_base.Visible := False;
    MountPrevisao(dt_base.Text);
  end
  else
  begin
    TLoading.ToastMessage(FrmPrincipal,
      'Informe uma data base para realizar consulta final do dia',
      TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
    lb_message_data_base.Visible := True;
  end;
end;

procedure TFrmPrincipal.MountPrevisao(DataBase: String);
var
  HTTPAuth: THTTPBasicAuthenticator;
  JSON: String;
  ObjetoDashPrevJS: TJSONObject;
begin
  // Requisição Dashboard - Previsão Final do Dia...
  HTTPAuth := THTTPBasicAuthenticator.Create(self);
  RESTClient.BaseUrl := BaseUrl;
  RESTRequest.Resource := 'customservice/previsaoocupacao?';
  RESTRequest.Params.AddItem('database', DataBase);
  HTTPAuth.Username := Nome;
  HTTPAuth.Password := Senha;

  try
    RESTRequest.Execute;
    JSON := RESTRequest.Response.JSONValue.ToString;
    ObjetoDashPrevJS := TJSONObject.ParseJSONValue
      (TEncoding.UTF8.GetBytes(JSON), 0) as TJSONObject;
    GetValuesDashboard(ObjetoDashPrevJS);
  except
    on e: Exception do
      TLoading.ToastMessage(FrmPrincipal,
        'Erro ao realizar previsão. Contate o suporte!', TAlignLayout.Bottom,
        $FFFE7827, $FFF4F3F3, 3);
  end;

end;

procedure TFrmPrincipal.OpenNovaReserva;
begin
  MultiViewMain.HideMaster;
  if not Assigned(FrmNovaReserva) then
    Application.CreateForm(TFrmNovaReserva, FrmNovaReserva);

  FrmNovaReserva.BaseUrlNova := BaseUrl;
  FrmNovaReserva.NomeUser := Nome;
  FrmNovaReserva.SenhaUser := Senha;

  FrmNovaReserva.Show;
end;

procedure TFrmPrincipal.OpenInfos;
begin
  MultiViewMain.HideMaster;
end;

procedure TFrmPrincipal.OpenLogin;
begin
  MultiViewMain.HideMaster;
  if not Assigned(FrmLogin) then
    Application.CreateForm(TFrmLogin, FrmLogin);
  FrmLogin.edt_cpf.Text := '';
  FrmLogin.edt_senha.Text := '';
  ClearDataSet(ConsultaCDS);
  Application.MainForm := FrmLogin;

  FrmLogin.Show;
  Close;
end;

procedure TFrmPrincipal.ClearDataSet(pDataSet: TClientDataSet);
begin
  pDataSet.DisableControls;
  pDataSet.First;
  while not pDataSet.eof do
  begin
    pDataSet.Delete;
  end;
  pDataSet.EnableControls;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  ConsultaCDS.Close;
  ConsultaCDS.CreateDataSet;
  ConsultaCDS.Open;

  dt_base.IsEmpty := True;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  ShadowEffectMultView.Enabled := False;

  try
    MountListHotel(TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(StringJS),
      0) as TJSONObject);
  finally
//    ExibirSelecaoHotel;
  end;

end;

function TFrmPrincipal.SetItensDashboard(ObjetoJS: TJSONObject)
  : TItensDashboard;
begin
  Result.UHs := ObjetoJS.GetValue('uhs').Value;
  Result.Adulto := ObjetoJS.GetValue('adultos').Value;
  Result.Crianca := ObjetoJS.GetValue('criancas').Value;
  Result.Free := ObjetoJS.GetValue('free').Value;;
  Result.Total := (StrToInt(Result.UHs) + StrToInt(Result.Adulto) +
    StrToInt(Result.Crianca) + StrToInt(Result.Free));
end;

procedure TFrmPrincipal.ExibirSelecaoHotel;
begin
  with FrmPrincipal do
  begin
    rect_select_hotel.Visible := True;
    rect_select_hotel.Width := layout_menu.Width;
    rect_select_hotel.Position.Y := layout_menu.Height + 20;

    layout_menu.Visible := True;

    rect_fundo.Opacity := 0;
    rect_fundo.AnimateFloat('Opacity', 0.4, 0.2);

    rect_select_hotel.AnimateFloat('Position.Y', 0, 0.5, TAnimationType.InOut,
      TInterpolationType.Circular);

  end;
end;

procedure TFrmPrincipal.OpenReserva;
begin
  MultiViewMain.HideMaster;
  if not Assigned(FrmReserva) then
    Application.CreateForm(TFrmReserva, FrmReserva);
  FrmReserva.Show;
end;

procedure TFrmPrincipal.SetPropertiesForm;
begin
  lbl_hospedes_casa.Text := UhsHospedes;
  lb_total_hospedes_casa.Text := IntToStr(TotalHospedes);
  lbl_entradas_previstas.Text := UhsEntradas;
  lb_total_entradas_prev.Text := IntToStr(TotalEntradas);
  lbl_saidas_previstas.Text := UhsSaidas;
  lb_total_saidas_prev.Text := IntToStr(TotalSaidas);
end;

procedure TFrmPrincipal.GetValuesDashboard(JSONObj: TJSONObject);
var
  HospedesJS, EntradasPrevJS, SaidasPrevJS: TJSONObject;
  PrevOcupacaoJA: TJSONArray;
begin
  // Popular props para preencher form...
  if JSONObj.TryGetValue('hospedesnacasa', HospedesJS) then
  begin
    UhsHospedes := SetItensDashboard(HospedesJS).UHs;
    AdultosHospedes := SetItensDashboard(HospedesJS).Adulto;
    CriancasHospedes := SetItensDashboard(HospedesJS).Crianca;
    FreeHospedes := SetItensDashboard(HospedesJS).Free;
    TotalHospedes := SetItensDashboard(HospedesJS).Total;
  end;

  if JSONObj.TryGetValue('entradasprevistas', EntradasPrevJS) then
  begin
    UhsEntradas := SetItensDashboard(EntradasPrevJS).UHs;
    AdultosEntradas := SetItensDashboard(EntradasPrevJS).Adulto;
    CriancasEntradas := SetItensDashboard(EntradasPrevJS).Crianca;
    FreeEntradas := SetItensDashboard(EntradasPrevJS).Free;
    TotalEntradas := SetItensDashboard(EntradasPrevJS).Total;
  end;

  if JSONObj.TryGetValue('saidasprevistas', SaidasPrevJS) then
  begin
    UhsSaidas := SetItensDashboard(SaidasPrevJS).UHs;
    AdultosSaidas := SetItensDashboard(SaidasPrevJS).Adulto;
    CriancasSaidas := SetItensDashboard(SaidasPrevJS).Crianca;
    FreeSaidas := SetItensDashboard(SaidasPrevJS).Free;
    TotalSaidas := SetItensDashboard(SaidasPrevJS).Total;
  end;

  if JSONObj.TryGetValue('value', PrevOcupacaoJA) then
  begin
    lbl_previsao_final_dia.Text := IntToStr(PrevOcupacaoJA.Count);
  end;
end;

procedure TFrmPrincipal.MountMenu(URL: String);
var
  HTTPAuth: THTTPBasicAuthenticator;
  JSON: String;
  ObjetoDashJS: TJSONObject;
begin
  // Requisição Dashboard - Hóspedes, Saídas e Entradas...
  HTTPAuth := THTTPBasicAuthenticator.Create(self);
  RESTClient.BaseUrl := BaseUrl;
  RESTClient.Authenticator := HTTPAuth;
  RESTRequest.Resource := 'customservice/dashboard';
  HTTPAuth.Username := Nome;
  HTTPAuth.Password := Senha;

  try
    RESTRequest.Execute;
    JSON := RESTRequest.Response.JSONValue.ToString;
    ObjetoDashJS := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJSONObject;
    GetValuesDashboard(ObjetoDashJS);
  except
    on Ex: Exception do
      TLoading.ToastMessage(FrmPrincipal, 'Erro ao carregar dados do Hotel!',
        TAlignLayout.Bottom, $FFF52A2A, $FFF4F3F3, 4);
  end;
end;

procedure TFrmPrincipal.MultiViewMainHidden(Sender: TObject);
begin
  ShadowEffectMultView.Enabled := False;
  Circle.Visible := True;
end;

procedure TFrmPrincipal.MultiViewMainShown(Sender: TObject);
begin
  ShadowEffectMultView.Enabled := True;
  Circle.Visible := False;
end;

procedure TFrmPrincipal.MountListHotel(Dados: TJSONObject);
var
  HotelJA: TJSONArray;
  HotelJV: TJSONValue;
  HotelJS: TJSONObject;
  Hotel: String;
  URL: String;
begin
  if Dados.TryGetValue('hoteis', HotelJA) then
  begin
    ConsultaCDS.First;
    for HotelJV in HotelJA do
    begin
      HotelJS := HotelJV as TJSONObject;
      HotelJS.TryGetValue('nome', Hotel);
      HotelJS.TryGetValue('baseuri', URL);
      ConsultaCDS.Append;
      ConsultaCDSnome.AsString := Hotel;
      ConsultaCDSbaseurl.AsString := URL;
      ConsultaCDS.Post;
    end;
    ConsultaCDS.First;
  end;
  NomeHotel := Hotel;
  BaseUrl := URL;
end;

procedure TFrmPrincipal.lbl_previsao_final_diaClick(Sender: TObject);
begin
  if lbl_previsao_final_dia.Text = '-' then
    TLoading.ToastMessage(FrmPrincipal,
      'Sem previsão final, selecione uma data base para obter os dados.',
      TAlignLayout.Bottom, $FFFE7827, $FFF4F3F3, 3);
end;

procedure TFrmPrincipal.list_menuItemClick(

  const Sender: TCustomListBox;

  const Item: TListBoxItem);
begin
  if UpperCase(Item.Name) = UpperCase('lbi_reservas') then
  begin
    OpenReserva;
  end
  else if UpperCase(Item.Name) = UpperCase('lbi_nova_reserva') then
  begin
    OpenNovaReserva;
  end
  else if UpperCase(Item.Name) = UpperCase('lbi_infos') then
  begin
    OpenInfos;
  end
  else if UpperCase(Item.Name) = UpperCase('lbi_troca_conta_hotel') then
  begin
    MultiViewMain.HideMaster;
    ExibirSelecaoHotel;
  end
  else if UpperCase(Item.Name) = UpperCase('lbi_sair') then
  begin
    OpenLogin;
  end
end;

procedure TFrmPrincipal.lv_hotelItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  // Carrega as informações e prepara Menu...
  HotelSelected := False;
  try
    BaseUrl := ConsultaCDSbaseurl.AsString;
    MountMenu(BaseUrl);
    HotelSelected := True;
  except
    on Ex: Exception do
      ShowMessage('Erro ao solicitar informações ao Serviço: ' + Ex.Message);
  end;
end;

procedure TFrmPrincipal.rect_nova_reservaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TRectangle(Sender).Opacity := 0.8;
end;

procedure TFrmPrincipal.rect_nova_reservaMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TRectangle(Sender).Opacity := 1;
end;

procedure TFrmPrincipal.ExibirInformacao(InfoSelecionada: String);
begin
  with FrmPrincipal do
  begin
    lb_informacao.Text := InfoSelecionada;

    if InfoSelecionada = 'Entradas Previstas' then
    begin
      lb_uhs_info.Text := UhsEntradas;
      lb_adultos_info.Text := AdultosEntradas;
      lb_criancas_info.Text := CriancasEntradas;
      lb_free_info.Text := FreeEntradas;
      lb_total_info.Text :=
        IntToStr((StrToInt(UhsEntradas) + StrToInt(AdultosEntradas) +
        StrToInt(CriancasEntradas) + StrToInt(FreeEntradas)));
    end
    else if InfoSelecionada = 'Saídas Previstas' then
    begin
      lb_uhs_info.Text := UhsSaidas;
      lb_adultos_info.Text := AdultosSaidas;
      lb_criancas_info.Text := CriancasSaidas;
      lb_free_info.Text := FreeSaidas;
      lb_total_info.Text :=
        IntToStr((StrToInt(UhsSaidas) + StrToInt(AdultosSaidas) +
        StrToInt(CriancasSaidas) + StrToInt(FreeSaidas)));
    end
    else if InfoSelecionada = 'Hospedes na Casa' then
    begin
      lb_uhs_info.Text := UhsHospedes;
      lb_adultos_info.Text := AdultosHospedes;
      lb_criancas_info.Text := CriancasHospedes;
      lb_free_info.Text := FreeHospedes;
      lb_total_info.Text :=
        IntToStr((StrToInt(UhsHospedes) + StrToInt(AdultosHospedes) +
        StrToInt(CriancasHospedes) + StrToInt(FreeHospedes)));
    end
    else if InfoSelecionada = 'Previsão Final do Dia' then
    begin
      lb_uhs_info.Text := UhsEntradas;
      lb_adultos_info.Text := AdultosEntradas;
      lb_criancas_info.Text := CriancasEntradas;
      lb_free_info.Text := FreeEntradas;
      lb_total_info.Text :=
        IntToStr((StrToInt(UhsEntradas) + StrToInt(AdultosEntradas) +
        StrToInt(CriancasEntradas) + StrToInt(FreeEntradas)));
    end;

    rect_informacao.Width := layout_menu.Width;
    rect_informacao.Position.Y := layout_menu.Height + 20;

    layout_infos.Visible := True;

    rect_informacao.AnimateFloat('Position.Y', 0, 0.5, TAnimationType.InOut,
      TInterpolationType.Circular);
  end;
end;

procedure TFrmPrincipal.EscondeInformacao;
begin
  with FrmPrincipal do
  begin
    rect_informacao.AnimateFloat('Position.Y', layout_menu.Height + 20, 0.5,
      TAnimationType.InOut, TInterpolationType.Circular);

    TThread.CreateAnonymousThread(
      procedure
      begin
        Sleep(800);
        layout_infos.Visible := False;
      end).Start;
  end;
end;

procedure TFrmPrincipal.EscondeSelecaoHotel;
begin
  with FrmPrincipal do
  begin
    rect_select_hotel.AnimateFloat('Position.Y', layout_menu.Height + 20, 0.5,
      TAnimationType.InOut, TInterpolationType.Circular);

    TThread.CreateAnonymousThread(
      procedure
      begin
        Sleep(800);
        layout_menu.Visible := False;
      end).Start;
  end;
end;

end.

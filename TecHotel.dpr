program TecHotel;

uses
  System.StartUpCopy,
  FMX.Forms,
  Login in 'Forms\Login.pas' {FrmLogin},
  Principal in 'Forms\Principal.pas' {FrmPrincipal},
  NovaReserva in 'Forms\NovaReserva.pas' {FrmNovaReserva},
  Lib.FormatValues in 'Lib\Lib.FormatValues.pas',
  Reserva in 'Forms\Reserva.pas' {FrmReserva},
  Lib.Notificacao in 'Lib\Lib.Notificacao.pas',
  Splash in 'Forms\Splash.pas' {FrmSplash};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.Run;
end.

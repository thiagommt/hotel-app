unit Splash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Layouts;

type
  TFrmSplash = class(TForm)
    img_logo_splash: TImage;
    FloatAnimation: TFloatAnimation;
    ScaledLayout: TScaledLayout;
    procedure FormShow(Sender: TObject);
    procedure FloatAnimationFinish(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;

implementation

{$R *.fmx}

uses Login;

procedure TFrmSplash.FloatAnimationFinish(Sender: TObject);
begin
  if not Assigned(FrmLogin) then
    Application.CreateForm(TFrmLogin, FrmLogin);

  Application.MainForm := FrmLogin;
  FrmLogin.Show;
  Close;
end;

procedure TFrmSplash.FormShow(Sender: TObject);
begin
  FloatAnimation.Enabled := true;
  FloatAnimation.Start;
end;

end.

unit Lib.RequestApi;

interface

uses
  Web.HTTPApp, System.JSON, System.Generics.Collections,
  System.Classes, System.Rtti, System.Character, FireDAC.DApt,
  REST.Types, REST.Client, System.SysUtils;

type
  TRequestApi = class
  private
    function GetCurrentDate: String;
    function GetAuthorizationToken: String;
  public
    class var FInstance: TRequestApi;
    class var FRestClient: TRestClient;
    class var FRestRequest: TRestRequest;
    class var FRestResponse: TRestResponse;

    class function GetInstance: TRequestApi;
    function ConsumirServico(Servico: String; BaseUrl: String;
      Metodo: TRestRequestMethod; Body: String = ''; ParamsGet: String = '')
      : TJSONValue;
    function ConsumirServicoHotel(Servico: String; BaseUrl: String;
      Metodo: TRestRequestMethod; Body: String = ''; ParamsGet: String = '')
      : TJSONValue;

    class property RestClient: TRestClient read FRestClient write FRestClient;
    class property RestRequest: TRestRequest read FRestRequest
      write FRestRequest;
    class property RestResponse: TRestResponse read FRestResponse
      write FRestResponse;

  end;

implementation

{ TRequestApi }

uses System.StrUtils, FMX.Dialogs;

class function TRequestApi.GetInstance: TRequestApi;
begin
  if FInstance = nil Then
  begin
    FInstance := TRequestApi.Create();
    RestClient := TRestClient.Create('');
    RestRequest := TRestRequest.Create(nil);
    RestResponse := TRestResponse.Create(nil);
    RestRequest.Response := RestResponse;
    RestRequest.Client := RestClient;
    RestRequest.Timeout := 30000;
  end;
  Result := FInstance;
end;

function TRequestApi.ConsumirServico(BaseUrl: String;
  Metodo: TRestRequestMethod; ParamsGet: String = '')
  : TJSONValue;
begin
  Result := ConsumirServicoHotel(BaseUrl, Metodo,
    ParamsGet)
end;

function TRequestApi.ConsumirServicoHotel(BaseUrl: String;
  Metodo: TRestRequestMethod; ParamsGet: String = ''): TJSONValue;
var
  lMessageJS: TJSONObject;
  ResultJS: TJSONObject;
begin
  RestRequest.Params.Clear;
  RestRequest.ClearBody;
  if Metodo <> rmGet then
    RestClient.BaseUrl := BaseUrl
  else
    RestClient.BaseUrl := BaseUrl + ParamsGet;
  RestRequest.Method := Metodo;

  RestRequest.Timeout := 10000;

  try
    RestRequest.Execute;
    Result := RestResponse.JSONValue;
  except
    on e: exception do
    begin
      ResultJS := TJSONObject.Create;
      lMessageJS := TJSONObject.Create;
      lMessageJS.AddPair('Kind', 'Error');
      lMessageJS.AddPair('Code', 'LIB-E205');
      lMessageJS.AddPair('Message', 'Servidor Off-Line');
      lMessageJS.AddPair('Detail', 'Entre em contato com o suporte');
      lMessageJS.AddPair('MessageDev', '');
      lMessageJS.AddPair('DetailDev', '');
      ResultJS.AddPair('Message', lMessageJS);
      Result := ResultJS AS TJSONValue;
    end;
  end;

end;

end.

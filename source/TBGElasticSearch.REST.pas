unit TBGElasticSearch.REST;

interface

uses
  REST.JSON, REST.Client, REST.Types, TBGElasticSearch.Search.Interfaces;

type


  iRest = interface
    ['{D8750745-6FDB-47D0-9C60-E092D70F5D7B}']
    function BaseURL (aValue : String) : iRest;
    function Get : iRest;
    function Post : iRest;
    function Put : iRest;
    function Execute : iRest;
    function Content : String;
    function AddParameter (aParam : String; aValue : String ) : iRest;
    function AddHeader (aHeader : String; aValue : String) : iRest;
    function HeaderParamDoNotEncode ( aParam : String ) : iRest;
    function AddBody ( aValue : String; aContentType : TRESTContentType ) : iRest;
  end;

  TTBGRest = class(TInterfacedObject, iREST)
    private
      FRESTClient: TRESTClient;
      FRESTRequest: TRESTRequest;
      FRESTResponse: TRESTResponse;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iREST;
      function BaseURL (aValue : String) : iREST;
      function Get : iREST;
      function Post : iREST;
      function Put : iRest;
      function Execute : iREST;
      function Content : String;
      function AddParameter (aParam : String; aValue : String ) : iREST;
      function AddHeader (aHeader : String; aValue : String) : iREST;
      function HeaderParamDoNotEncode ( aParam : String ) : iREST;
      function AddBody ( aValue : String; aContentType : TRESTContentType ) : iREST;
  end;

implementation

uses
  System.SysUtils;

{ TModelComponentesREST }

function TTBGRest.AddBody( aValue : String; aContentType : TRESTContentType ) : iREST;
begin
  Result := Self;
  FRESTRequest.AddBody(aValue, aContentType);
end;

function TTBGRest.AddHeader(aHeader,
  aValue: String): iREST;
begin
  Result := Self;
  FRESTRequest.Params.AddHeader(aHeader, aValue);
end;

function TTBGRest.AddParameter(aParam,
  aValue: String): iREST;
begin
  Result := Self;
  FRESTRequest.AddParameter(aParam, aValue);
end;

function TTBGRest.BaseURL(aValue: String): iREST;
begin
  Result := Self;
  FRESTClient.BaseURL := aValue;
end;

function TTBGRest.Content: String;
begin
  Result := FRESTResponse.Content;
end;

constructor TTBGRest.Create;
begin
  FRESTClient := TRESTClient.Create('');
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTResponse := TRESTResponse.Create(nil);
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
end;

destructor TTBGRest.Destroy;
begin
  FreeAndNil(FRESTClient);
  FreeAndNil(FRESTRequest);
  FreeAndNil(FRESTResponse);
  inherited;
end;

function TTBGRest.Execute: iREST;
begin
  Result := Self;
  FRESTRequest.Execute;
end;

function TTBGRest.Get: iREST;
begin
  Result := Self;
  FRESTRequest.Method := rmGet;
end;

function TTBGRest.HeaderParamDoNotEncode(
  aParam: String): iREST;
begin
  REsult := Self;
  FRESTRequest.Params.ParameterByName(aParam).Options := [poDoNotEncode];
end;

class function TTBGRest.New: iREST;
begin
    Result := Self.Create;
end;

function TTBGRest.Post: iREST;
begin
  Result := Self;
  FRESTRequest.Method := rmPOST;
end;

function TTBGRest.Put: iRest;
begin
  Result := Self;
  FRESTRequest.Method := rmPUT;
end;

end.

unit TBGElasticSearch;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  Data.DB, TBGElasticSearch.Index.Interfaces;

type
  TTBGElasticSearch = class(TInterfacedObject, iTBGElasticSearch)
    private
      //FSearch : iElasticSearch;
      FHost : String;
      FPort : Integer;
      FIndex : String;
      FType : String;
      FBaseURL : String;
      FDataSet : TDataSet;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iTBGElasticSearch;
      function Host (aHost : String ) : iTBGElasticSearch; overload;
      function Host : String; overload;
      function Port (aPort : Integer) : iTBGElasticSearch; overload;
      function Port : Integer; overload;
      function Index (aIndex : String ) : iTBGElasticSearch; overload;
      function Index : String; overload;
      function _Type (aType : String ) : iTBGElasticSearch; overload;
      function _Type : String; overload;
      function BaseURL (aBaseURL : String) : iTBGElasticSearch; overload;
      function BaseURL : String; overload;
      function DataSet ( aDataSet : TDataSet ) : iTBGElasticSearch; overload;
      function DataSet : TDataSet; overload;
      function _search : iElasticSearch;
      function _index : iElasticIndex;
  end;

implementation

uses
  TBGElasticSearch.Search, System.SysUtils, TBGElasticSearch.Index;

{ TTBGElasticSearch }

function TTBGElasticSearch.BaseURL: String;
begin
  Result :=
    Self.Host + ':'
    + IntToStr(Self.Port)
    + '/' + Self.Index
    + '/' + Self._Type;
end;

function TTBGElasticSearch.BaseURL(aBaseURL: String): iTBGElasticSearch;
begin
  Result := Self;
  FBaseURL := aBaseURL;
end;

constructor TTBGElasticSearch.Create;
begin
  //FSearch := TTBGEleasticSearchSearch.New(Self);
end;

function TTBGElasticSearch.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TTBGElasticSearch.DataSet(aDataSet: TDataSet): iTBGElasticSearch;
begin
  Result := Self;
  FDataSet := aDataSet;
end;

destructor TTBGElasticSearch.Destroy;
begin

  inherited;
end;

function TTBGElasticSearch.Host: String;
begin
  Result := FHost;
end;

function TTBGElasticSearch.Host(aHost: String): iTBGElasticSearch;
begin
  Result := Self;
  FHost := aHost;
end;

function TTBGElasticSearch.Index(aIndex: String): iTBGElasticSearch;
begin
  Result := Self;
  FIndex := aIndex;
end;

function TTBGElasticSearch.Index: String;
begin
  Result := FIndex;
end;

class function TTBGElasticSearch.New: iTBGElasticSearch;
begin
    Result := Self.Create;
end;

function TTBGElasticSearch.Port(aPort: Integer): iTBGElasticSearch;
begin
  Result := Self;
  FPort := aPort;
end;

function TTBGElasticSearch.Port: Integer;
begin
  Result := FPort;
end;

function TTBGElasticSearch._index: iElasticIndex;
begin
  Result := TTBGElasticSearchIndex.New(Self);
end;

function TTBGElasticSearch._search: iElasticSearch;
begin
  Result := TTBGEleasticSearchSearch.New(Self);
end;

function TTBGElasticSearch._Type: String;
begin
  Result := FType;
end;

function TTBGElasticSearch._Type(aType: String): iTBGElasticSearch;
begin
  Result := Self;
  FType := aType;
end;

end.

unit TBGElasticSearch.Search;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.JSON,
  TBGElasticSearch.REST,
  REST.Types;

type
  TTBGEleasticSearchSearch = class(TInterfacedObject, iElasticSearch)
    private
      [weak]
      FParent : iTBGElasticSearch;
      FQuery : iElasticQuery;
      FFilter :  iElasticFilter;
      FJSONQuery : TJsonObject;
      FResult : String;
      FBaseURL : String;
      FFrom : Integer;
      FSize : Integer;
    function JSONSearch: TJsonObject;
    public
      constructor Create(Parent : iTBGElasticSearch);
      destructor Destroy; override;
      class function New(Parent : iTBGElasticSearch) : iElasticSearch;
      function From (aFrom : Integer ) : iElasticSearch;
      function Size (aSize : Integer ) : iElasticSearch;
      function Query : iElasticQuery;
      function asJsonObject : TJsonObject;
      function Execute : iElasticSearch;
      function AsString : String;
      function &End : iTBGElasticSearch;
  end;

implementation

uses
  TBGElasticSearch.Query, System.SysUtils, TBGElasticSearch.JsonUtils,
  TBGElasticSearch.Query.Filter, TBGElasticSearch.Filter;

const
  BASE_POSFIX = '/_search';

{ TTBGEleasticSearchSearch }

function TTBGEleasticSearchSearch.&End: iTBGElasticSearch;
begin
  Result := FParent;
end;

function TTBGEleasticSearchSearch.asJsonObject: TJsonObject;
begin
  Result := FJSONQuery;
end;

function TTBGEleasticSearchSearch.AsString: String;
begin
  Result := FResult;
end;

constructor TTBGEleasticSearchSearch.Create(Parent : iTBGElasticSearch);
begin
  FParent := Parent;
  FJSONQuery := TJsonObject.Create;
  FQuery := TTBGElasticQuery.New(Self);
end;

destructor TTBGEleasticSearchSearch.Destroy;
begin
  FJSONQuery.Free;
  inherited;
end;

function TTBGEleasticSearchSearch.Execute: iElasticSearch;
begin
  Result := Self;

  FResult :=
    TTBGRest
      .New
      .BaseURL(FParent.BaseURL + BASE_POSFIX)
      .Post
      .AddBody(FJSONQuery.ToJSON, ctAPPLICATION_JSON)
      .Execute
      .Content;

  if Assigned(FParent.DataSet) then
    TTBGElasticSearchJsonUtils._SourceToDataSet(FResult, FParent.DataSet);

end;

function TTBGEleasticSearchSearch.From(aFrom: Integer): iElasticSearch;
begin
  Result := Self;
  FFrom := aFrom;
  FJSONQuery.AddPair('from', TJSONNumber.Create(aFrom));
end;

function TTBGEleasticSearchSearch.JSONSearch: TJsonObject;
begin
  Result := FJSONQuery;
end;

class function TTBGEleasticSearchSearch.New(Parent : iTBGElasticSearch) : iElasticSearch;
begin
    Result := Self.Create(Parent);
end;

function TTBGEleasticSearchSearch.Query: iElasticQuery;
begin
  Result := FQuery;
end;

function TTBGEleasticSearchSearch.Size(aSize: Integer): iElasticSearch;
begin
  Result := Self;
  FSize := aSize;
  FJSONQuery.AddPair('size', TJSONNumber.Create(aSize));
end;

end.

unit TBGElasticSearch.Index;

interface

uses
  TBGElasticSearch.Index.Interfaces,
  TBGElasticSearch.Search.Interfaces;

type
  TTBGElasticSearchIndex = class(TInterfacedObject, iElasticIndex)
    private
      [weak]
      FParent : iTBGElasticSearch;
      FIndexName : String;
      FSettings : String;
      FResult : String;
    public
      constructor Create(Parent : iTBGElasticSearch);
      destructor Destroy; override;
      class function New(Parent : iTBGElasticSearch) : iElasticIndex;
      function IndexName( aValue : String ) :  iElasticIndex;
      function Settings ( aValue : String ) :  iElasticIndex;
      function Execute : iElasticIndex;
  end;

implementation

uses
  TBGElasticSearch.REST, System.SysUtils, REST.Types,
  TBGElasticSearch.JsonUtils;

{ TTBGElasticSearchIndex }

constructor TTBGElasticSearchIndex.Create(Parent : iTBGElasticSearch);
begin
  FParent := Parent;
end;

destructor TTBGElasticSearchIndex.Destroy;
begin

  inherited;
end;

function TTBGElasticSearchIndex.Execute: iElasticIndex;
var
  FBaseURL : String;
begin
  Result := Self;
  FBaseURL := FParent.Host + ':' + IntToStr(FParent.Port) + '/' + FIndexName;

  FResult :=
    TTBGRest
      .New
      .BaseURL(FParent.BaseURL + '/' + FIndexName)
      .Put
      .AddBody(FSettings, ctAPPLICATION_JSON)
      .Execute
      .Content;

  if Assigned(FParent.DataSet) then
    TTBGElasticSearchJsonUtils.JsonToDataSet(FResult, FParent.DataSet);

end;

function TTBGElasticSearchIndex.IndexName(aValue: String): iElasticIndex;
begin
  Result := Self;
  FIndexName := aValue;
end;

class function TTBGElasticSearchIndex.New(Parent : iTBGElasticSearch) : iElasticIndex;
begin
    Result := Self.Create(Parent);
end;

function TTBGElasticSearchIndex.Settings(aValue: String): iElasticIndex;
begin
  Result := Self;
  FSettings := aValue;
end;

end.

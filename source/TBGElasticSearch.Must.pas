unit TBGElasticSearch.Must;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.JSON;

type
  TTBGElasticSearchMust = class(TInterfacedObject, iElasticMust)
    private
      [weak]
      FParent : iElasticBool;
      FMatch : iElasticMatch<iElasticMust>;
      FJSONQuery : TJsonArray;
    public
      constructor Create(Parent : iElasticBool);
      destructor Destroy; override;
      class function New(Parent : iElasticBool) : iElasticMust;
      function Match : iElasticMatch<iElasticMust>;
      function asJsonArray : TJsonArray;
      function &End : iElasticBool;
  end;

implementation

uses
  System.SysUtils,
  TBGElasticSearch.Match;

{ TTBGElasticSearchMust }

function TTBGElasticSearchMust.&End: iElasticBool;
begin
  Result := FParent;
  FParent.asJsonObject.AddPair('must', FJSONQuery);
end;

function TTBGElasticSearchMust.asJsonArray: TJsonArray;
begin
  Result := FJSONQuery;
end;

constructor TTBGElasticSearchMust.Create(Parent : iElasticBool);
begin
  FParent := Parent;
  FJSONQuery := TJsonArray.Create;
  FMatch := TTBGElasticSearchMatch<iElasticMust>.New(FJSONQuery, Self);
end;

destructor TTBGElasticSearchMust.Destroy;
begin
  inherited;
end;

function TTBGElasticSearchMust.Match: iElasticMatch<iElasticMust>;
begin
  Result := FMatch;
end;

class function TTBGElasticSearchMust.New(Parent : iElasticBool) : iElasticMust;
begin
    Result := Self.Create(Parent);
end;

end.

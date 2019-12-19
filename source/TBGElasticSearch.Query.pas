unit TBGElasticSearch.Query;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.JSON;

type
  TTBGElasticQuery = class(TInterfacedObject, iElasticQuery)
    private
      [weak]
      FParent : iElasticSearch;
      FBool : iElasticBool;
      FTerm : iElasticTerm<iElasticQuery>;
      FRange : iElasticRange<iElasticQuery>;
      FJSONQuery : TJsonObject;
      FJsonArrayTerm : TJsonArray;
    public
      constructor Create(Parent : iElasticSearch);
      destructor Destroy; override;
      class function New(Parent : iElasticSearch) : iElasticQuery;
      function Bool : iElasticBool;
      function Term : iElasticTerm<iElasticQuery>;
      function Range : iElasticRange<iElasticQuery>;
      function asJsonObject : TJsonObject;
      function &End : iElasticSearch;
  end;

implementation

uses
  System.SysUtils,
  TBGElasticSearch.Match, TBGElasticSearch.Bool, TBGElasticSearch.Term,
  TBGElasticSearch.Range;

{ TTBGElasticQuery }

function TTBGElasticQuery.&End: iElasticSearch;
var
  FTeste: string;
  FBool : Boolean;
begin
  Result := FParent;
  FParent.asJsonObject.AddPair('query', FJSONQuery);
end;

function TTBGElasticQuery.asJsonObject: TJsonObject;
begin
  Result := FJSONQuery;
end;

constructor TTBGElasticQuery.Create(Parent : iElasticSearch);
begin
  FParent := Parent;
  FJSONQuery := TJsonObject.Create;
end;

destructor TTBGElasticQuery.Destroy;
begin
  inherited;
end;

function TTBGElasticQuery.Bool: iElasticBool;
begin
  if not Assigned(FBool) then
    FBool := TTBGElasticSearchBool.New(Self);

  Result := FBool;
end;

class function TTBGElasticQuery.New(Parent : iElasticSearch) : iElasticQuery;
begin
    Result := Self.Create(Parent);
end;

function TTBGElasticQuery.Range: iElasticRange<iElasticQuery>;
begin
  if not assigned(FRange) then
    FRange := TTBGElasticSearchRange<iElasticQuery>.New(FJsonQuery, Self);

  Result := FRange;
end;

function TTBGElasticQuery.Term: iElasticTerm<iElasticQuery>;
begin
  if not assigned(FTerm) then
  begin
    FJsonArrayTerm := TJsonArray.Create;
    FTerm := TTBGElasticSearchTerm<iElasticQuery>.New(FJsonArrayTerm, Self);
  end;

  Result := FTerm;
end;

end.

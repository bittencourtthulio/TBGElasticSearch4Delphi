unit TBGElasticSearch.Query.Filter;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.JSON;

type
  TTBGElasticSearchQueryFilter = class(TInterfacedObject, iElasticQueryFilter)
    private
      [weak]
      FParent : iElasticBool;
      FTerm : iElasticTerm<iElasticQueryFilter>;
      FRange : iElasticRange<iElasticQueryFilter>;
      FJSONArray : TJsonArray;
    public
      constructor Create(Parent : iElasticBool);
      destructor Destroy; override;
      class function New(Parent : iElasticBool) : iElasticQueryFilter;
      function Term : iElasticTerm<iElasticQueryFilter>;
      function Range : iElasticRange<iElasticQueryFilter>;
      function asJsonArray : TJsonArray;
      function &End : iElasticBool;
  end;

implementation

uses
  System.SysUtils,
  TBGElasticSearch.Match, TBGElasticSearch.Term, TBGElasticSearch.Range;

{ TTBGElasticSearchFilter }

function TTBGElasticSearchQueryFilter.&End: iElasticBool;
begin
  Result := FParent;
  FParent.asJsonObject.AddPair('filter', FJSONArray);
end;

function TTBGElasticSearchQueryFilter.asJsonArray: TJsonArray;
begin
  Result := FJSONArray;
end;

constructor TTBGElasticSearchQueryFilter.Create(Parent : iElasticBool);
begin
  FParent := Parent;
  FJSONArray := TJsonArray.Create;
end;

destructor TTBGElasticSearchQueryFilter.Destroy;
begin
  inherited;
end;

function TTBGElasticSearchQueryFilter.Term: iElasticTerm<iElasticQueryFilter>;
begin
  if not Assigned(FTerm) then
    FTerm := TTBGElasticSearchTerm<iElasticQueryFilter>.New(FJSONArray, Self);

  Result := FTerm;
end;

class function TTBGElasticSearchQueryFilter.New(Parent : iElasticBool) : iElasticQueryFilter;
begin
    Result := Self.Create(Parent);
end;

function TTBGElasticSearchQueryFilter.Range: iElasticRange<iElasticQueryFilter>;
begin
  if not Assigned(FRange) then
    FRange := TTBGElasticSearchRange<iElasticQueryFilter>.New(FJSONArray, Self);

  Result := FRange;
end;

end.

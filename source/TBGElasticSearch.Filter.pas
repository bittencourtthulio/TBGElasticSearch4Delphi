unit TBGElasticSearch.Filter;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.JSON;

type
  TTBGElasticSearchFilter = class(TInterfacedObject, iElasticFilter)
    private
      [weak]
      FParent : iElasticSearch;
      FTerm : iElasticTerm<iElasticFilter>;
      FRange : iElasticRange<iElasticFilter>;
      FJSONArray : TJsonArray;
    public
      constructor Create(Parent : iElasticSearch);
      destructor Destroy; override;
      class function New(Parent : iElasticSearch) : iElasticFilter;
      function Term : iElasticTerm<iElasticFilter>;
      function Range : iElasticRange<iElasticFilter>;
      function asJsonArray : TJsonArray;
      function &End : iElasticSearch;
  end;

implementation

uses
  System.SysUtils,
  TBGElasticSearch.Match, TBGElasticSearch.Term, TBGElasticSearch.Range;

{ TTBGElasticSearchFilter }

function TTBGElasticSearchFilter.&End: iElasticSearch;
begin
  Result := FParent;
  FParent.asJsonObject.AddPair('filter', FJSONArray);
end;

function TTBGElasticSearchFilter.asJsonArray: TJsonArray;
begin
  Result := FJSONArray;
end;

constructor TTBGElasticSearchFilter.Create(Parent : iElasticSearch);
begin
  FParent := Parent;
  FJSONArray := TJsonArray.Create;

end;

destructor TTBGElasticSearchFilter.Destroy;
begin
  inherited;
end;

function TTBGElasticSearchFilter.Term: iElasticTerm<iElasticFilter>;
begin
  if not Assigned(FTerm) then
    FTerm := TTBGElasticSearchTerm<iElasticFilter>.New(FJSONArray, Self);

  Result := FTerm;
end;

class function TTBGElasticSearchFilter.New(Parent : iElasticSearch) : iElasticFilter;
begin
    Result := Self.Create(Parent);
end;

function TTBGElasticSearchFilter.Range: iElasticRange<iElasticFilter>;
begin
  if not Assigned(FRange) then
    FRange := TTBGElasticSearchRange<iElasticFilter>.New(FJSONArray, Self);

  Result := FRange;
end;

end.

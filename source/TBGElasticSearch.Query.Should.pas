unit TBGElasticSearch.Query.Should;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.JSON;

type
  TTBGElasticSearchQueryShould = class(TInterfacedObject, iElasticBoolShould)
    private
      [weak]
      FParent : iElasticBool;
      FTerm : iElasticTerm<iElasticBoolShould>;
      FMatch : iElasticMatch<iElasticBoolShould>;
      FJSONArray : TJsonArray;
    public
      constructor Create(Parent : iElasticBool);
      destructor Destroy; override;
      class function New(Parent : iElasticBool) : iElasticBoolShould;
      function Term : iElasticTerm<iElasticBoolShould>;
      function Match : iElasticMatch<iElasticBoolShould>;
      function asJsonArray : TJsonArray;
      function &End : iElasticBool;
  end;

implementation

uses
  System.SysUtils,
  TBGElasticSearch.Match, TBGElasticSearch.Term;

{ TTBGElasticSearchFilter }

function TTBGElasticSearchQueryShould.&End: iElasticBool;
begin
  Result := FParent;
  //FJSONArray.AddElement(FJSONTerm);
  FParent.asJsonObject.AddPair('should', FJSONArray);
end;

function TTBGElasticSearchQueryShould.Match: iElasticMatch<iElasticBoolShould>;
begin
  if not assigned(FMatch) then
    FMatch := TTBGElasticSearchMatch<iElasticBoolShould>.New(FJSONArray, Self);

  Result := FMatch;
end;

function TTBGElasticSearchQueryShould.asJsonArray: TJsonArray;
begin
  Result := FJSONArray;
end;

constructor TTBGElasticSearchQueryShould.Create(Parent : iElasticBool);
begin
  FParent := Parent;
  FJSONArray := TJsonArray.Create;
end;

destructor TTBGElasticSearchQueryShould.Destroy;
begin
  inherited;
end;

function TTBGElasticSearchQueryShould.Term: iElasticTerm<iElasticBoolShould>;
begin
  if not assigned(FTerm) then
    FTerm := TTBGElasticSearchTerm<iElasticBoolShould>.New(FJSONArray, Self);

  Result := FTerm;
end;

class function TTBGElasticSearchQueryShould.New(Parent : iElasticBool) : iElasticBoolShould;
begin
    Result := Self.Create(Parent);
end;

end.

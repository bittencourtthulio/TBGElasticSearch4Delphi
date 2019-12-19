unit TBGElasticSearch.Bool;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.JSON;

type
  TTBGElasticSearchBool = class(TInterfacedObject, iElasticBool)
    private
      [weak]
      FParent : iElasticQuery;
      FMust : iElasticMust;
      FFilter : iElasticQueryFilter;
      FShould : iElasticBoolShould;
      FJSONQuery : TJsonObject;
      Fminimum_should_match : Integer;
      Fboost : Currency;
      FMustNot : iElasticBoolMustNot;
    public
      constructor Create(Parent : iElasticQuery);
      destructor Destroy; override;
      class function New(Parent : iElasticQuery) : iElasticBool;
      function minimum_should_match ( Value : Integer ) : iElasticBool;
      function boost ( Value : Currency ) : iElasticBool;
      function Must : iElasticMust;
      function Must_not : iElasticBoolMustNot;
      function Filter : iElasticQueryFilter;
      function Should : iElasticBoolShould;
      function asJsonObject : TJsonObject;
      function &End : iElasticQuery;
  end;

implementation

uses
  System.SysUtils,
  TBGElasticSearch.Match, TBGElasticSearch.Must, TBGElasticSearch.Query.Filter,
  TBGElasticSearch.Query.Should, TBGElasticSearch.Query.Bool.MustNot;

{ TTBGElasticSearchBool }

function TTBGElasticSearchBool.&End: iElasticQuery;
begin
  Result := FParent;

  if Fminimum_should_match > 0 then
    FJSONQuery.AddPair('minimum_should_match', TJSONNumber.Create(Fminimum_should_match));

  if Fboost > 0 then
    FJSONQuery.AddPair('boost', TJSONNumber.Create(Fboost));

  FParent.asJsonObject.AddPair('bool', FJSONQuery);
end;

function TTBGElasticSearchBool.Filter: iElasticQueryFilter;
begin
  if not Assigned (FFilter) then
    FFilter := TTBGElasticSearchQueryFilter.New(Self);

  Result := FFilter;
end;

function TTBGElasticSearchBool.minimum_should_match(
  Value: Integer): iElasticBool;
begin
  Result := Self;
  Fminimum_should_match := Value;
end;

function TTBGElasticSearchBool.asJsonObject: TJsonObject;
begin
  Result := FJSONQuery;
end;

function TTBGElasticSearchBool.boost(Value: Currency): iElasticBool;
begin
  Result := Self;
  Fboost := Value;
end;

constructor TTBGElasticSearchBool.Create(Parent : iElasticQuery);
begin
  FParent := Parent;
  FJSONQuery := TJsonObject.Create;
  Fminimum_should_match := 0;
  Fboost := 0;
end;

destructor TTBGElasticSearchBool.Destroy;
begin
  inherited;
end;

function TTBGElasticSearchBool.Must: iElasticMust;
begin
  if not Assigned(FMust) then
    FMust := TTBGElasticSearchMust.New(Self);

  Result := FMust;
end;

function TTBGElasticSearchBool.Must_not: iElasticBoolMustNot;
begin
  if not Assigned(FMustNot) then
    FMustNot := TTBGElasticSearchQueryBoolMustNot.New(Self);

  Result := FMustNot;
end;

class function TTBGElasticSearchBool.New(Parent : iElasticQuery) : iElasticBool;
begin
    Result := Self.Create(Parent);
end;

function TTBGElasticSearchBool.Should: iElasticBoolShould;
begin
  if Not Assigned(FShould) then
    FShould := TTBGElasticSearchQueryShould.New(Self);

  Result := FShould;
end;

end.

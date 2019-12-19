unit TBGElasticSearch.Query.Bool.MustNot;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.JSON;

type
  TTBGElasticSearchQueryBoolMustNot = class(TInterfacedObject, iElasticBoolMustNot)
    private
      [weak]
      FParent : iElasticBool;
      FTerm : iElasticTerm<iElasticBoolMustNot>;
      FJSONArray : TJsonArray;
    public
      constructor Create(Parent : iElasticBool);
      destructor Destroy; override;
      class function New(Parent : iElasticBool) : iElasticBoolMustNot;
      function Term : iElasticTerm<iElasticBoolMustNot>;
      function asJsonArray : TJsonArray;
      function &End : iElasticBool;
  end;

implementation

uses
  System.SysUtils,
  TBGElasticSearch.Match, TBGElasticSearch.Term;

{ TTBGElasticSearchFilter }

function TTBGElasticSearchQueryBoolMustNot.&End: iElasticBool;
begin
  Result := FParent;
  FParent.asJsonObject.AddPair('must_not', FJSONArray);
end;

function TTBGElasticSearchQueryBoolMustNot.asJsonArray: TJsonArray;
begin
  Result := FJSONArray;
end;

constructor TTBGElasticSearchQueryBoolMustNot.Create(Parent : iElasticBool);
begin
  FParent := Parent;
  FJSONArray := TJsonArray.Create;
  FTerm := TTBGElasticSearchTerm<iElasticBoolMustNot>.New(FJSONArray, Self);
end;

destructor TTBGElasticSearchQueryBoolMustNot.Destroy;
begin
  inherited;
end;

function TTBGElasticSearchQueryBoolMustNot.Term: iElasticTerm<iElasticBoolMustNot>;
begin
  Result := FTerm;
end;

class function TTBGElasticSearchQueryBoolMustNot.New(Parent : iElasticBool) : iElasticBoolMustNot;
begin
    Result := Self.Create(Parent);
end;

end.


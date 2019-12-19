unit TBGElasticSearch.Term;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.RTTI,
  System.JSON;

type
  TTBGElasticSearchTerm<T : IInterface> = class(TInterfacedObject, iElasticTerm<T>)
    private
      FParent : T;
      FJsonObject : TJSONArray;
    public
      constructor Create(FJson : TJSONArray; Parent : T);
      destructor Destroy; override;
      class function New(FJson : TJSONArray; Parent : T) : iElasticTerm<T>;
      function AddField ( aField : String; aValue : String ) : iElasticTerm<T>;
      function asJsonArray : TJsonArray;
      function &End : T;
  end;

implementation

uses
  System.SysUtils, Injection;

{ TTBGElasticSearchTerm }

function TTBGElasticSearchTerm<T>.AddField(aField: String;
  aValue: String): iElasticTerm<T>;
begin
  Result := Self;
  FJsonObject.AddElement(
    TJSONObject
      .Create
      .AddPair(
        'term',
        TJSONObject
          .Create
          .AddPair(
            aField,
            aValue
          )
      )
  );
end;

function TTBGElasticSearchTerm<T>.&End: T;
begin
  Result := FParent;
end;

function TTBGElasticSearchTerm<T>.asJsonArray: TJsonArray;
begin
  Result := FJsonObject;
end;

constructor TTBGElasticSearchTerm<T>.Create(FJson : TJSONArray; Parent : T);
begin
  TInjection.Weak(@FParent, Parent);
  FJsonObject := FJson;
end;

destructor TTBGElasticSearchTerm<T>.Destroy;
begin
  inherited;
end;

class function TTBGElasticSearchTerm<T>.New(FJson : TJSONArray; Parent : T) : iElasticTerm<T>;
begin
    Result := Self.Create(FJson, Parent);
end;

end.

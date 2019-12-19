unit TBGElasticSearch.Match;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.RTTI,
  System.JSON;

type
  TTBGElasticSearchMatch<T : IInterface> = class(TInterfacedObject, iElasticMatch<T>)
    private
      FParent : T;
      FJsonObject : TJSONArray;
    public
      constructor Create(FJson : TJSONArray; Parent : T);
      destructor Destroy; override;
      class function New(FJson : TJSONArray; Parent : T) : iElasticMatch<T>;
      function AddField ( aField : String; aValue : String ) : iElasticMatch<T>;
      function asJsonArray : TJsonArray;
      function &End : T;
  end;

implementation

uses
  System.SysUtils, Injection;

{ TTBGElasticSearchMatch }

function TTBGElasticSearchMatch<T>.AddField(aField: String;
  aValue: String): iElasticMatch<T>;
begin
  Result := Self;
  FJsonObject.AddElement(
    TJSONObject
      .Create
      .AddPair(
        'match',
        TJSONObject
          .Create
          .AddPair(
            aField,
            aValue
          )
      )
  );
end;

function TTBGElasticSearchMatch<T>.&End: T;
begin
  Result := FParent;
end;

function TTBGElasticSearchMatch<T>.asJsonArray: TJsonArray;
begin
  Result := FJsonObject;
end;

constructor TTBGElasticSearchMatch<T>.Create(FJson : TJSONArray; Parent : T);
begin
  TInjection.Weak(@FParent, Parent);
  FJsonObject := FJson;
end;

destructor TTBGElasticSearchMatch<T>.Destroy;
begin
  inherited;
end;

class function TTBGElasticSearchMatch<T>.New(FJson : TJSONArray; Parent : T) : iElasticMatch<T>;
begin
    Result := Self.Create(FJson, Parent);
end;

end.

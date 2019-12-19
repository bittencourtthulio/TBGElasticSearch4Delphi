unit TBGElasticSearch.Range;

interface

uses
  TBGElasticSearch.Search.Interfaces,
  System.RTTI,
  System.JSON;

type
  TTBGElasticSearchRange<T : IInterface> = class(TInterfacedObject, iElasticRange<T>)
    private
      FParent : T;
      FJsonObject : TJsonValue;
      FJsonRange : TJsonObject;
      FField : String;
    public
      constructor Create(FJson : TJsonValue; Parent : T);
      destructor Destroy; override;
      class function New(FJson : TJsonValue; Parent : T) : iElasticRange<T>;
      function AddField ( aField : String; aValue : String ) : iElasticRange<T>;
      function Field ( aField : String ) : iElasticRange<T>;
      function gt ( aValue : String ) : iElasticRange<T>; overload;
      function gt ( aValue : Double ) : iElasticRange<T>; overload;
      function gte ( aValue : String ) : iElasticRange<T>; overload;
      function gte ( aValue : Double ) : iElasticRange<T>; overload;
      function lt ( aValue : String ) : iElasticRange<T>; overload;
      function lt ( aValue : Double ) : iElasticRange<T>; overload;
      function lte ( aValue : String ) : iElasticRange<T>; overload;
      function lte ( aValue : Double ) : iElasticRange<T>; overload;
      function asJsonValue : TJSONValue;
      function &End : T;
  end;

implementation

uses
  System.SysUtils, Injection;

{ TTBGElasticSearchRange }

function TTBGElasticSearchRange<T>.AddField(aField: String;
  aValue: String): iElasticRange<T>;
begin
  Result := Self;
//  FJsonObject
//    .AddElement(
//      TJSONObject.Create
//      .AddPair('range',
//        TJSONObject.Create
//        .AddPair(
//          FField,
//          aValue
//        )
//      )
//    );
end;

function TTBGElasticSearchRange<T>.&End: T;
begin
  Result := FParent;
  if FJsonObject is TJSONArray then
    TJSONArray(FJsonObject)
      .AddElement(
        TJSONObject.Create
        .AddPair('range',
          TJSONObject.Create
          .AddPair(
            FField,
            FJsonRange
          )
        )
      )
  else
    TJSONObject(FJsonObject)
        .AddPair('range',
          TJSONObject.Create
          .AddPair(
            FField,
            FJsonRange
          )
        );
end;

function TTBGElasticSearchRange<T>.Field(aField: String): iElasticRange<T>;
begin
  Result := Self;
  FField := aField;
end;

function TTBGElasticSearchRange<T>.gt(aValue: String): iElasticRange<T>;
begin
  Result := Self;
  FJsonRange.AddPair('gt', TJSONString.Create(aValue));
end;

function TTBGElasticSearchRange<T>.gt(aValue: Double): iElasticRange<T>;
begin
  Result := Self;
  FJsonRange.AddPair('gt', TJSONNumber.Create(aValue));
end;

function TTBGElasticSearchRange<T>.gte(aValue: String): iElasticRange<T>;
begin
  Result := Self;
  FJsonRange.AddPair('gte', TJSONString.Create(aValue));
end;

function TTBGElasticSearchRange<T>.gte(aValue: Double): iElasticRange<T>;
begin
  Result := Self;
  FJsonRange.AddPair('gte', TJSONNumber.Create(aValue));
end;

function TTBGElasticSearchRange<T>.lt(aValue: String): iElasticRange<T>;
begin
  Result := Self;
  FJsonRange.AddPair('lt', TJSONString.Create(aValue));
end;

function TTBGElasticSearchRange<T>.lt(aValue: Double): iElasticRange<T>;
begin
  Result := Self;
  FJsonRange.AddPair('lt', TJSONNumber.Create(aValue));
end;

function TTBGElasticSearchRange<T>.lte(aValue: String): iElasticRange<T>;
begin
  Result := Self;
  FJsonRange.AddPair('lte', TJSONString.Create(aValue));
end;

function TTBGElasticSearchRange<T>.lte(aValue: Double): iElasticRange<T>;
begin
  Result := Self;
  FJsonRange.AddPair('lte', TJSONNumber.Create(aValue));
end;

function TTBGElasticSearchRange<T>.asJsonValue: TJsonValue;
begin
  Result := FJsonObject;
end;

constructor TTBGElasticSearchRange<T>.Create(FJson : TJsonValue; Parent : T);
begin
  TInjection.Weak(@FParent, Parent);
  FJsonObject := FJson;
  FJsonRange := TJSONObject.Create;
end;

destructor TTBGElasticSearchRange<T>.Destroy;
begin
  inherited;
end;

class function TTBGElasticSearchRange<T>.New(FJson : TJsonValue; Parent : T) : iElasticRange<T>;
begin
    Result := Self.Create(FJson, Parent);
end;

end.

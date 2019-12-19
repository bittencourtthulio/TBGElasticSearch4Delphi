unit TBGElasticSearch.JsonUtils;

interface

uses
  DataSetConverter4D.Helper,
  DataSetConverter4D.Impl,
  DataSetConverter4D,
  DataSetConverter4D.Util,
  System.JSON,
  Data.DB,
  REST.Response.Adapter;

type

  iTBGElasticSearchJsonUtils = interface
    ['{9D12F862-9475-4F03-BF1B-D8B277BD1B02}']
  end;

  TTBGElasticSearchJsonUtils = class(TInterfacedObject, iTBGElasticSearchJsonUtils)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iTBGElasticSearchJsonUtils;
      class procedure _SourceToDataSet(aJson : TJSONObject; aDataSet : TDataSet); overload;
      class procedure _SourceToDataSet(aJson : String; aDataSet : TDataSet); overload;
      class procedure JsonToDataSet(aJson : String; aDataSet : TDataSet);
      class procedure ValidaStatus(aJson : String);
  end;

implementation

uses
  System.SysUtils, System.Classes;

{ TTBGElasticSearchJsonUtils }

constructor TTBGElasticSearchJsonUtils.Create;
begin

end;

destructor TTBGElasticSearchJsonUtils.Destroy;
begin

  inherited;
end;

class procedure TTBGElasticSearchJsonUtils.JsonToDataSet(aJson: String;
  aDataSet: TDataSet);
var
  jsonArray : TJsonArray;
  vConv : TCustomJSONDataSetAdapter;
begin
  Self.ValidaStatus(aJson);
  vConv := TCustomJSONDataSetAdapter.Create(Nil);
  try
     TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        vConv.Dataset := aDataSet;
        vConv.UpdateDataSet(TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(aJson), 0) as TJSONObject);
      end);
  finally
    vConv.Free;
  end;

end;

class function TTBGElasticSearchJsonUtils.New: iTBGElasticSearchJsonUtils;
begin
    Result := Self.Create;
end;

class procedure TTBGElasticSearchJsonUtils.ValidaStatus(aJson: String);
var
  FResult: string;
  FJsonResult, FJsonError : TJsonObject;
begin
  FJsonResult := (TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(aJson), 0) as TJSONObject);
  FJsonError := nil;
  try
    FJsonResult.TryGetValue<String>('status', FResult);
    if FResult <> '200' then
    begin
      FJsonResult.TryGetValue<TJsonObject>('error', FJsonError);
      raise Exception.Create(FJsonError.ToString);
    end;
  finally
    FJsonResult.Free;
  end;
end;

class procedure TTBGElasticSearchJsonUtils._SourceToDataSet(aJson: String;
  aDataSet: TDataSet);
var
  jsonResultSource : TJSONArray;
  jsonValueResult : TJsonValue;
  jsonObject, jsonSource : TJsonObject;
  jsonHits : TJsonArray;
  vConv : TCustomJSONDataSetAdapter;
begin
   //Self.ValidaStatus(aJson);


   vConv := TCustomJSONDataSetAdapter.Create(Nil);
   jsonResultSource := TJSONArray.Create;
   try
      jsonObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(aJson), 0) as TJSONObject;
      jsonObject.TryGetValue<TJsonArray>('hits.hits', jsonHits);
      for jsonValueResult in jsonHits do
      begin
        jsonValueResult.TryGetValue<TJsonObject>('_source', jsonSource);
        jsonResultSource.AddElement(TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(jsonSource.ToJSON), 0) as TJSONObject);
      end;

      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        vConv.Dataset := aDataSet;
        vConv.UpdateDataSet(jsonResultSource);
      end);

   finally
     vConv.Free;
     jsonResultSource.Free;
     jsonObject.Free;
   end;
end;

class procedure TTBGElasticSearchJsonUtils._SourceToDataSet(aJson: TJSONObject;
  aDataSet: TDataSet);
var
  jsonSource : TJsonObject;
begin
  jsonSource := aJson.P['_source'] as TJSONObject;
  aDataSet.FromJSONObject(jsonSource);
end;

end.

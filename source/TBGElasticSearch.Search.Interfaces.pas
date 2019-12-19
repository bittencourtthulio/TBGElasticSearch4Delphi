unit TBGElasticSearch.Search.Interfaces;

interface

uses
  System.RTTI,
  REST.Types,
  System.JSON,
  Data.DB, TBGElasticSearch.Index.Interfaces;

type
  iElasticQuery = interface;
  iElasticMatch<T> = interface;
  iElasticSearch = interface;
  iElasticMust = interface;
  iElasticBool = interface;
  iElasticQueryFilter = interface;
  iElasticTerm<T> = interface;
  iElasticFilter = interface;
  iElasticBoolShould = interface;
  iElasticBoolMustNot = interface;
  iElasticRange<T> = interface;

  iTBGElasticSearch = interface
    ['{7BF20142-20CE-4CD3-BFBB-72305365B1A4}']
    function Host (aHost : String ) : iTBGElasticSearch; overload;
    function Host : String; overload;
    function Port (aPort : Integer) : iTBGElasticSearch; overload;
    function Port : Integer; overload;
    function Index (aIndex : String ) : iTBGElasticSearch; overload;
    function Index : String; overload;
    function _Type (aType : String ) : iTBGElasticSearch; overload;
    function _Type : String; overload;
    function BaseURL (aBaseURL : String) : iTBGElasticSearch; overload;
    function BaseURL : String; overload;
    function DataSet ( aDataSet : TDataSet ) : iTBGElasticSearch; overload;
    function DataSet : TDataSet; overload;
    function _search : iElasticSearch;
    function _index : iElasticIndex;
  end;

  iElasticSearch = interface
    ['{3C3613D6-FA57-4AE0-A00E-FA73871F0333}']
    function From (aFrom : Integer ) : iElasticSearch;
    function Size (aSize : Integer ) : iElasticSearch;
    function Query : iElasticQuery;
    function asJsonObject : TJsonObject;
    function Execute : iElasticSearch;
    function &End : iTBGElasticSearch;
    function AsString : String;
  end;

  iElasticQuery = interface
    ['{50EF64E2-D5B6-406B-ACB4-CAB8F7213F51}']
    function Bool : iElasticBool;
    function Term : iElasticTerm<iElasticQuery>;
    function Range : iElasticRange<iElasticQuery>;
    function asJsonObject : TJsonObject;
    function &End : iElasticSearch;
  end;

  iElasticBool = interface
    ['{245C23EF-79C6-4888-966E-655981B990B2}']
    function minimum_should_match ( Value : Integer ) : iElasticBool;
    function boost ( Value : Currency ) : iElasticBool;
    function Must : iElasticMust;
    function Must_not : iElasticBoolMustNot;
    function Filter : iElasticQueryFilter;
    function Should : iElasticBoolShould;
    function asJsonObject : TJsonObject;
    function &End : iElasticQuery;
  end;

  iElasticBoolMustNot = interface
    ['{C93249C0-66AC-4A6B-B53E-B956C15583B1}']
    function Term : iElasticTerm<iElasticBoolMustNot>;
    function asJsonArray : TJsonArray;
    function &End : iElasticBool;
  end;

  iElasticBoolShould = interface
    ['{F2B483D7-8BBE-454C-B62A-53AFD2264783}']
    function Term : iElasticTerm<iElasticBoolShould>;
    function Match : iElasticMatch<iElasticBoolShould>;
    function asJsonArray : TJsonArray;
    function &End : iElasticBool;
  end;

  iElasticMust = interface
    ['{979D10FB-3F84-45A8-BA27-EAEEC3881248}']
    function Match : iElasticMatch<iElasticMust>;
    function asJsonArray : TJsonArray;
    function &End : iElasticBool;
  end;

  iElasticQueryFilter = interface
    ['{D876A182-3BDF-486A-880E-9F37F1DFF631}']
    function Term : iElasticTerm<iElasticQueryFilter>;
    function Range : iElasticRange<iElasticQueryFilter>;
    function asJsonArray : TJsonArray;
    function &End : iElasticBool;
  end;

  iElasticFilter = interface
    ['{D876A182-3BDF-486A-880E-9F37F1DFF631}']
    function Term : iElasticTerm<iElasticFilter>;
    function Range : iElasticRange<iElasticFilter>;
    function asJsonArray : TJsonArray;
    function &End : iElasticSearch;
  end;

  iElasticTerm<T> = interface
    ['{3386DB33-65D7-4FA8-AFC7-95397DB18362}']
    function asJsonArray : TJsonArray;
    function AddField ( aField : String; aValue : String ) : iElasticTerm<T>;
    function &End : T;
  end;

  iElasticRange<T> = interface
    ['{3386DB33-65D7-4FA8-AFC7-95397DB18362}']
    function asJsonValue : TJsonValue;
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
    function &End : T;
  end;

  iElasticMatch<T> = interface
    ['{3386DB33-65D7-4FA8-AFC7-95397DB18362}']
    function asJsonArray : TJsonArray;
    function AddField ( aField : String; aValue : String ) : iElasticMatch<T>;
    function &End : T;
  end;

implementation

end.

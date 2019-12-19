unit TBGElasticSearch.Index.Interfaces;

interface

type

  iElasticIndex = interface
    ['{B92C95DF-E8CB-4AC7-A36B-E1515A36873E}']
    function IndexName( aValue : String ) :  iElasticIndex;
    function Settings ( aValue : String ) :  iElasticIndex;
    function Execute : iElasticIndex;
  end;

implementation

end.

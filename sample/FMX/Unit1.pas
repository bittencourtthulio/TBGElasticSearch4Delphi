unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Grid,
  TBGElasticSearch.Search.Interfaces,
  TBGElasticSearch, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  FMX.StdCtrls, FMX.Edit, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope, FMX.Memo;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Label1: TLabel;
    Edit1: TEdit;
    ListBoxItem2: TListBoxItem;
    Label2: TLabel;
    Edit2: TEdit;
    ListBoxItem3: TListBoxItem;
    Button1: TButton;
    ListBoxItem4: TListBoxItem;
    Button2: TButton;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    Edit3: TEdit;
    Button3: TButton;
    Layout1: TLayout;
    Memo1: TMemo;
    ListBoxItem7: TListBoxItem;
    Button4: TButton;
    ListBoxItem8: TListBoxItem;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    FElastic : iTBGElasticSearch;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  FElastic
    ._search
      .Query
        .Bool
          .Must
            .Match
              .AddField('ITENS.DESCRICAO_PRODUTO', 'FORD')
              .AddField('NOME_COMPRADOR', 'PAULIM')
            .&End
          .&End
          .Filter
            .Term
              .AddField('CFOP', '5102')
            .&End
          .&End
        .&End
      .&End
    .Execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Add(

  FElastic
    ._search
      .Query
        .Bool
          .Should
            .Match
              .AddField('NOME_COMPRADOR', 'SYSTEMA')
              .AddField('ITENS.DESCRICAO', 'FILTRO')
              .AddField('OBS_NF', 'RETIRADA')
            .&End
          .&End
          .Filter
            .Term
              .AddField('CFOP', '5102')
            .&End
            .Range
              .Field('TOTAL')
              .gte(100)
              .lte(101)
            .&End
          .&End
        .&End
    .&End
    .From(0)
    .Size(50)
    .Execute
    .asJsonObject.ToJSON);
//        .Bool
//          .Filter
//            .Term
//              .AddField(Edit1.Text, Edit2.Text)
//            .&End
//          .&End
//          .Should
//            .Term
//              .AddField('COD_LOJA', '1')
//              .AddField('COD_CLIENTE', '99911')
//            .&End
//          .&End
//          .Must_not
//            .Term
//              .AddField('NUMERO_PEDIDO', '6005')
//              .AddField('NUMERO_PEDIDO', '5419')
//              .AddField('ITENS.COD_PRODUTO', '202584')
//            .&End
//          .&End
//          .minimum_should_match(1)
//          .boost(1.0)
//        .&End

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   TTBGElasticSearch.New
      .Host('http://localhost')
      .Port(9200)
      .DataSet(FDMemTable1)
      ._index
        .IndexName(Edit3.Text)
        .Settings(
          '{' +
          ' "settings" : { ' +
          '   "number_of_shards" : 2, ' +
          '   "number_of_replicas" : 2 ' +
          ' }' +
          '}'
        )
        .Execute;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Memo1.Lines.Add(

  FElastic
    ._search
      .Query
        .Range
          .Field('TOTAL')
          .gte(100)
          .lte(101)
        .&End
      .&End
    .Size(1000)
    .Execute
    .asJsonObject.ToString
  );
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  FElastic
    ._search
      .Query
        .Bool
          .Must
            .Match
              .AddField('ITENS.DESCRICAO_PRODUTO', 'FILTRO')
              .AddField('ITENS.DESCRICAO_PRODUTO', 'ANEL')
            .&End
          .&End
        .&End
      .&End
      .Size(1000)
    .Execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  FElastic :=
    TTBGElasticSearch.New
      .Host('http://localhost')
      .Port(9200)
      .Index('passaporte')
      ._Type('notas')
      .DataSet(FDMemTable1);
end;

end.

unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, ImgList, ToolWin;

type
   TForm1 = class(TForm)
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    SpeedButton1: TSpeedButton;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    Notebook1: TNotebook;
    RichEdit1: TRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.

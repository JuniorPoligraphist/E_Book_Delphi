unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TForm1 = class(TForm)
    btn1: TButton;
    lbl1: TLabel;
    pnl1: TPanel;
    lbl2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
 Form1.FormStyle := fsNormal;
 Form1.ShowModal;

end;

procedure TForm1.btn1Click(Sender: TObject);
begin
 Close;
end;

end.

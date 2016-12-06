unit MainFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ImgList, xmldom,  XMLIntf, msxmldom, XMLDoc, SHDocVw, Menus, Unit1, Unit2,
  OleCtrls, ExtCtrls, ComCtrls, ToolWin;

type
    TMainForm = class(TForm)
    tlb1: TToolBar;
    il1: TImageList;
    spBtn1: TSpeedButton;
    trv1: TTreeView;
    xmlDoc: TXMLDocument;
    spBtn2: TSpeedButton;
    mm1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    pnl1: TPanel;
    wb1: TWebBrowser;
    spBtn3: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure trv1Change(Sender: TObject; Node: TTreeNode);
    procedure trv1Expanded(Sender: TObject; Node: TTreeNode);
    procedure trv1Collapsed(Sender: TObject; Node: TTreeNode);
    procedure spBtn2Click(Sender: TObject);
    procedure spBtn1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure spBtn3Click(Sender: TObject);

  private
    { Private declarations }
    DataPath :String;
    procedure ProcessDocumentNode(root:TTreeNode; node:IXMLNode);


  public
    { Public declarations }
  end;

var
  mainForm: TMainForm;

implementation

 uses DataStructuresU;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
 var i :Integer;

begin
  mainForm.FormStyle := fsNormal;

  DataPath := ExtractFilePath(Application.ExeName) + 'DATA';
  xmlDoc.XML.LoadFromFile(DataPath + '\index.xml');
  xmlDoc.Active := true;

 for i := 0 to xmlDoc.DocumentElement.ChildNodes.Count - 1 do
  ProcessDocumentNode(nil, xmlDoc.DocumentElement.ChildNodes[i]);
end;

procedure TMainForm.ProcessDocumentNode(root:TTreeNode; node:IXMLNode);
 var newNode :TTreeNode;
     projectData :TProjectData;
     i :Integer;

begin
  projectData := TProjectData.Create();
  projectData.ID := node.Attributes['ID'];
  projectData.Caption := node.Attributes['Caption'];
  projectData.FileName := node.Attributes['File'];

  if root <> nil then
  begin
    root.ImageIndex := 0;
    root.SelectedIndex := 0;
  end;

  newNode := trv1.Items.AddChild(root, projectData.Caption);
  newNode.Data := projectData;
  newNode.ImageIndex := 2;
  newNode.SelectedIndex := 2;

  for i := 0 to node.ChildNodes.Count-1 do
  ProcessDocumentNode(newNode, node.ChildNodes[i]);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
 var i :Integer;

begin
  for i := 0 to trv1.Items.Count-1 do
  TProjectData(trv1.Items[i].Data).Free;
end;

// link TreeView with WebBrowser
procedure TMainForm.trv1Change(Sender: TObject; Node: TTreeNode);
 var FileName :String;

begin
  if TProjectData(Node.Data).FileName <> '' then
  begin
    FileName := TProjectData(Node.Data).FileName;
    wb1.Navigate(DataPath + '/' + FileName);
  end;
end;

procedure TMainForm.trv1Expanded(Sender: TObject; Node: TTreeNode);
 begin
  if Node = nil then Exit;

  Node.ImageIndex := 1;
  Node.SelectedIndex := 1;
 end;

procedure TMainForm.trv1Collapsed(Sender: TObject; Node: TTreeNode);
 begin
  if Node = nil then Exit;
  Node.ImageIndex := 0;
  Node.SelectedIndex := 0;
 end;

procedure TMainForm.spBtn2Click(Sender: TObject);
 var Node, prevNode, tmpNode :TTreeNode;

begin
  Node := trv1.Selected;
  if (Node = nil) then Exit;
  prevNode := Node.getPrevSibling;

   // give access to prev node 
   if (prevNode <> nil)then
   begin
     tmpNode := prevNode.GetLastChild;
     while (tmpNode <> nil) do
     begin
        prevNode := tmpNode;
        tmpNode := prevNode.GetLastChild;
     end;
   end;

  if prevNode = nil then prevNode := Node.Parent;
  if prevNode = nil then Exit;
  trv1.Selected := prevNode;
end;

procedure TMainForm.spBtn1Click(Sender: TObject);
 var Node, nextNode, tmpNode :TTreeNode;

begin
 Node := trv1.Selected;
 if (Node = nil)then Exit;
 nextNode := Node.getFirstChild;

 if nextNode = nil then
 nextNode := Node.getNextSibling;

 // give access to next node
 if nextNode = nil then
  begin
    tmpNode := Node;
    repeat
      tmpNode := tmpNode.Parent;
      nextNode := tmpNode.getNextSibling;
    until nextNode <> nil;
  end;  

 if nextNode = nil then Exit;
 trv1.Selected := nextNode;
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
 Application.CreateForm(TForm1, Form1);
end;

procedure TMainForm.N4Click(Sender: TObject);
begin
 Application.CreateForm(TForm2, Form2);
end;

procedure TMainForm.spBtn3Click(Sender: TObject);
begin
 if (trv1.Visible = True) then
 begin
   trv1.Visible := False;
 end
 else
 begin
  trv1.Visible := True;
 end;
end;
end.

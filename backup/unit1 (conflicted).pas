unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    CoolBar1: TCoolBar;
    Image1: TImage;
    ImageList1: TImageList;
    ImageListTools: TImageList;
    MainMenu1: TMainMenu;
    MenuItemExit: TMenuItem;
    Separator2: TMenuItem;
    MenuItemSaveAll: TMenuItem;
    MenuItemView: TMenuItem;
    MenuItemSaveAs: TMenuItem;
    MenuItemImage: TMenuItem;
    MenuItemFilters: TMenuItem;
    MenuItemColor: TMenuItem;
    MenuItemWindow: TMenuItem;
    MenuItemTools: TMenuItem;
    MenuItemNew: TMenuItem;
    MenuItemClose: TMenuItem;
    MenuItemSave: TMenuItem;
    Separator1: TMenuItem;
    MenuItemCloseAll: TMenuItem;
    MenuItemOpen: TMenuItem;
    MenuItemHelp: TMenuItem;
    MenuItemEdit: TMenuItem;
    MenuItemFile: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBarTools: TToolBar;
    ToolBarStandard: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure MenuItemFileClick(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;
  x:integer;
  y:integer;
  animation:Boolean;
  procedure doAnim();
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItemFileClick(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  x:=0;
  y:=0;
  image1.Picture.Bitmap.SetSize(400, 300);

end;

procedure TForm1.Button1Click(Sender: TObject);
begin

  animation:= not animation;
  doAnim;

end;
procedure doAnim();
begin

    repeat


    with Form1.Image1.Canvas do
         begin
         Clear;
            AntialiasingMode:= amOff;
            Brush.Color:= clRed;
            Pen.Color:=clWhite;
            Pen.Width:=1;
            Line(10,10,100,50);
            Brush.Color:= clRed;
            Ellipse(x+195, y+117, x+205, y+128);
            Brush.Color:= clBlue;
            Rectangle (x+192, y+130,x+208,y+160);
            Brush.Color:= clGreen;
            Rectangle (x+187, y+130,x+191,y+162);
            Brush.Color:= clYellow;
            Rectangle (x+209, y+130,x+213,y+162);
            Brush.Color:= clMaroon;
            Rectangle (x+193,y+161,x+199,y+200);
            Brush.Color:= clPurple;
            Rectangle (x+201,y+161,x+207,y+200);
            Sleep(10);
            Application.ProcessMessages;
            if x<100 then
            begin
                 x:=x+1;
            end
            else
            begin
                 x:=0 ;
            end;
            Y:=x;

            Form1.Image1.Refresh;
      end;
    until animation=false;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin

end;


end.


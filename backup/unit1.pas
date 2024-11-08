unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF HASAMIGA}
 athreads, hcamigaeffects,
  {$Else}
  hceffects,
  {$ENDIF}

  Classes, interfaces, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, ComCtrls, hccolorbox2, AnchorDockPanel, crt, line,
  pen, circle, hctypes, hcGlobals, animation, unitFormNewImage;

type

  { TForm1 }

  TForm1 = class(TForm)
    AnchorDockPanel1: TAnchorDockPanel;
    ColorDialog1: TColorDialog;
    FlowPanel1: TFlowPanel;
    HcColorFrame1: THcColorFrame;

    Image1: TImage;
    Image2: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItemExit: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
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
    TimerStartup: TTimer;
    ToolBarStandard: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButtonBlur: TToolButton;
    ToolButtonPixelate: TToolButton;
    ToolButtonZoomReset: TToolButton;
    ToolButtonZoomOut: TToolButton;
    ToolButtonZoomIn: TToolButton;
    ToolButtonEllipse: TToolButton;
    ToolButtonAnim: TToolButton;
    ToolButtonPen: TToolButton;
    ToolButtonLine: TToolButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ImageColorBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure TimerStartupTimer(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButtonBlurClick(Sender: TObject);
    procedure ToolButtonEllipseClick(Sender: TObject);
    procedure ToolButtonOpenClick(Sender: TObject);
    procedure ToolButtonPenClick(Sender: TObject);
    procedure ToolButtonLineClick(Sender: TObject);
    procedure ToolButtonPixelateClick(Sender: TObject);
    procedure ToolButtonZoomInClick(Sender: TObject);
    procedure ToolButtonZoomOutClick(Sender: TObject);
    procedure ToolButtonZoomResetClick(Sender: TObject);


  private

  public

  end;

var
  Form1: TForm1;



implementation

{$R *.lfm}

{ TForm1 }
procedure AssignEmptyImage(Image: TImage; IWidth, IHeight: integer);
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := IWidth;
    Bitmap.Height := IHeight;
    Bitmap.Canvas.Brush.Color := clWhite; // Arka plan rengini beyaz yap
    Bitmap.Canvas.FillRect(Rect(0, 0, IWidth, IHeight)); // Bitmap'i beyazla doldur
    Image.Picture.Graphic := Bitmap; // Bitmap'i TImage nesnesine ata
  finally
    Bitmap.Free; // Bitmap nesnesini serbest bırak
  end;
end;


procedure TForm1.ToolButtonEllipseClick(Sender: TObject);
begin
  hctool := TOOL_ELLIPSE1;
end;

procedure TForm1.ToolButtonOpenClick(Sender: TObject);
begin

  OpenDialog1.Execute;
  OpenDialog1.DoShow();
  Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.ToolButtonPenClick(Sender: TObject);
begin
  hctool := TOOL_PEN;
end;

procedure TForm1.ToolButtonLineClick(Sender: TObject);
begin
  hctool := TOOL_LINE;
end;

procedure TForm1.ToolButtonPixelateClick(Sender: TObject);
begin
  Image1 := Pixelate(Image1, 10);
end;

procedure TForm1.ToolButtonZoomInClick(Sender: TObject);
begin
  zoomFactor := zoomFactor * 1.2;
  Image1.Width := round(image2.Width * zoomFactor);  //Image 2 is original
  Image1.Height := round(image2.Height * zoomFactor);
  
end;

procedure TForm1.ToolButtonZoomOutClick(Sender: TObject);
begin
  zoomFactor := zoomFactor / 1.2;
  Image1.Width := round(image2.Width * zoomFactor);
  Image1.Height := round(image2.Height * zoomFactor);
end;

procedure TForm1.ToolButtonZoomResetClick(Sender: TObject);
begin
  zoomFactor := 1;
  Image1.Width := round(image2.Width * zoomFactor);
  Image1.Height := round(image2.Height * zoomFactor);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  image1.Picture.Bitmap.SetSize(400, 300);
  mouseButton := mbNone;
  Image2.Width := Image1.Width;
  Image2.Height := Image1.Height;
  AssignEmptyImage(Image1, 400, 300);
  // 200x200 boyutlarında boş bir resim ata
  AssignEmptyImage(Image2, Image1.Width, Image1.Height);
  // 200x200 boyutlarında boş bir resim ata
  // ToolButtonZoomOutClick(sender);

  zoomFactor := 1;

end;

procedure TForm1.TimerStartupTimer(Sender: TObject);
begin
  TimerStartup.Enabled := False;
  Image1.Refresh;
  //Amiga problem giderme amaçlı. Bu olmazsa açılışta Image1 küçük çıkıyor.
  ToolButtonZoomResetClick(Sender);
end;

procedure TForm1.ToolButton1Click(Sender: TObject);

var
  MyForm: TFormNewImage; // Declare a variable for the new form
begin
  // Create an instance of TMyForm
  MyForm := TFormNewImage.Create(nil); // nil means it has no owner
  try
    MyForm.ShowModal; // Show as a modal form
    // Alternatively, use MyForm.Show for a non-modal form
  finally
    MyForm.Free; // Free the form after it's closed to prevent memory leaks
  end;
end;


procedure TForm1.ToolButtonBlurClick(Sender: TObject);
begin
  ApplyBlurEffect(Image1);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin

  animrun := not animrun;
  if animrun then
  begin
    doAnim(Form1.Image1);
  end;

end;



// MOUSE EVENTS //
procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  oldX := round(X / zoomfactor);
  oldy := round(Y / Zoomfactor);
  mouseButton := mbLeft;
  Image1.Canvas.Pen.Color := foreColor;
  Image1.Canvas.Brush.Color := clNone;
  Image1.Canvas.Brush.Style := bsClear;    //todo daha sonra ayarla

  case hctool of
    TOOL_PEN: ;
    TOOL_LINE: ;
  end;

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin

  if mouseButton = mbLeft then
  begin
    hcShift := Shift;
    PX := round(X / zoomfactor);
    PY := round(Y / Zoomfactor);
    mouseEvent := 2;
    case hctool of
      TOOL_PEN: hc_pen(Image1, mouseButton, hcShift, pX, pY, mouseEvent);
      TOOL_LINE: hc_line(Image1, Image2, mouseButton, hcShift, pX, pY, mouseEvent);
      TOOL_ELLIPSE1: hc_ellipse1(Image1, Image2, mouseButton, hcShift,
          PX, PY, mouseEvent);
    end;
  end
  else if mouseButton = mbRight then
  begin

  end;
  StatusBar1.Panels[0].Text :=
    x.ToString + ' ' + y.ToString + ' - ' + PX.ToString + ' ' + PY.ToString;
  Memo1.Text := StatusBar1.Panels[0].Text;
end;
//Common tasks after end of  drawing
procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);
  mouseButton := mbNone;
end;


procedure TForm1.ImageColorBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  foreColor := HcColorFrame1.ImageColorBox.Canvas.Pixels[x, y];
end;

// MOUSE EVENTS END //


{END OF UNIT}
end.

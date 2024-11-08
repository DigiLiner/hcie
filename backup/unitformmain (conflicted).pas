unit unitFormMain;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF HASAMIGA}
 athreads, hcamigaeffects,
  {$Else}
  hceffects,
  {$ENDIF}

  Classes, interfaces, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls, ComCtrls, ExtDlgs, hccolorbox2, AnchorDockPanel, crt,
  line, pen, circle, hctypes, hcGlobals, animation, unitFormNewImage,
  BCFluentSlider, BGRAImageManipulation, uPSI_BGRAPascalScript,
  BGRAGraphicControl, BGRABitmap;

type

  { TFormMain }

  TFormMain = class(TForm)
    AnchorDockPanel1: TAnchorDockPanel;
    BCFluentSliderWidth: TBCFluentSlider;
    BCFluentSlider2: TBCFluentSlider;
    BCFluentSlider3: TBCFluentSlider;
    BGImage1: TBGRAImageManipulation;
    CalculatorDialog1: TCalculatorDialog;
    ColorDialog1: TColorDialog;
    EditWidth: TEdit;
    FindDialog1: TFindDialog;
    FlowPanel1: TFlowPanel;
    FontDialog1: TFontDialog;
    HcColorFrame1: THcColorFrame;

    Image1: TImage;
    Image2: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Separator4: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator3: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItemUndo: TMenuItem;
    MenuItemExit: TMenuItem;
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
    procedure AnimButtonClick(Sender: TObject);
    procedure BCFluentSliderWidthChangeValue(Sender: TObject);
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
  FormMain: TFormMain;
      pl:plim

procedure NewImage(_width: integer; _height: integer);
procedure NewBGRAImage(_width: integer; _height: integer) ;
implementation

{$R *.lfm}

{ TFormMain }
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


procedure TFormMain.ToolButtonEllipseClick(Sender: TObject);
begin
  hctool := TOOL_ELLIPSE1;
end;

procedure TFormMain.ToolButtonOpenClick(Sender: TObject);
begin

  OpenPictureDialog1.Execute;
  OpenPictureDialog1.DoShow();
  Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TFormMain.ToolButtonPenClick(Sender: TObject);
begin
  hctool := TOOL_PEN;
end;

procedure TFormMain.ToolButtonLineClick(Sender: TObject);
begin
  hctool := TOOL_LINE;
end;

procedure TFormMain.ToolButtonPixelateClick(Sender: TObject);
begin
  Image1 := Pixelate(Image1, 10);
end;

procedure TFormMain.ToolButtonZoomInClick(Sender: TObject);
begin
  zoomFactor := zoomFactor * 1.2;
  Image1.Width := round(image2.Width * zoomFactor);  //Image 2 is original
  Image1.Height := round(image2.Height * zoomFactor);

end;

procedure TFormMain.ToolButtonZoomOutClick(Sender: TObject);
begin
  zoomFactor := zoomFactor / 1.2;
  Image1.Width := round(image2.Width * zoomFactor);
  Image1.Height := round(image2.Height * zoomFactor);
end;

procedure TFormMain.ToolButtonZoomResetClick(Sender: TObject);
begin
  zoomFactor := 1;
  Image1.Width := round(image2.Width * zoomFactor);
  Image1.Height := round(image2.Height * zoomFactor);
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  {$if declared(UseHeapTrace)}
  GlobalSkipIfNoLeaks := True; // supported as of debugger version 3.2.0
  {$endIf}
  penWidth := 10;
  BCFluentSliderWidth.Value := penWidth;
  NewImage(400, 300);
  NewBGRAImage(400,300);

end;

procedure TFormMain.TimerStartupTimer(Sender: TObject);
begin
  TimerStartup.Enabled := False;
  Image1.Refresh;
  //Amiga problem giderme amaçlı. Bu olmazsa açılışta Image1 küçük çıkıyor.
  ToolButtonZoomResetClick(Sender);
end;

procedure TFormMain.ToolButton1Click(Sender: TObject);
var
  MyForm: TFormNewImage; // Declare a variable for the new form
begin
  // Create an instance of TMyForm
  MyForm := TFormNewImage.Create(nil); // nil means it has no owner
  try
    MyForm.ShowModal; // Show as a modal form
    // Alternatively, use MyForm.Show for a non-modal form
  finally
    if MyForm.ModalResult = mrOk then
    begin

      NewImage(MyForm.NewImageWidth, MyForm.NewImageHeight);
      NewBGRAImage(MyForm.NewImageWidth, MyForm.NewImageHeight);

    end;

    MyForm.Free; // Free the form after it's closed to prevent memory leaks

  end;
end;

procedure NewImage(_width: integer; _height: integer);
var
  image1, image2: TImage;
begin
  Image1 := FormMain.Image1;
  image2 := FormMain.Image2;
  Image1.Width := _width;
  Image1.Height := _height;
  Image1.Top := 0;
  Image1.Left := 0;
  image1.Picture.Bitmap.SetSize(Image1.Width, image1.Height);
  hMouseButton := mbNone;
  Image2.Width := Image1.Width;
  Image2.Height := Image1.Height;
  AssignEmptyImage(Image1, Image1.Width, Image1.Height);
  // 200x200 boyutlarında boş bir resim ata
  AssignEmptyImage(Image2, Image1.Width, Image1.Height);
  // 200x200 boyutlarında boş bir resim ata
  // ToolButtonZoomOutClick(sender);
  Image2.Hide;
  zoomFactor := 1;
end;

procedure NewBGRAImage(_width: integer; _height: integer) ;
var
  Bitmap: TBGRABitmap;
begin
       Bitmap := TBGRABitmap.Create(_width,_height,clWhite);
      // Bitmap.NewBitmap(_width,_height);
       FormMain.BGImage1.Bitmap:= Bitmap;
       Bitmap.free;
end;

procedure TFormMain.ToolButtonBlurClick(Sender: TObject);
begin
  ApplyBlurEffect(Image1);
end;

procedure TFormMain.FormPaint(Sender: TObject);
begin

end;

procedure TFormMain.Image1Click(Sender: TObject);
begin

end;

procedure TFormMain.AnimButtonClick(Sender: TObject);
begin

  animrun := not animrun;
  if animrun then
  begin
    doAnim(FormMain.Image1);
  end;

end;

procedure TFormMain.BCFluentSliderWidthChangeValue(Sender: TObject);
begin
  penWidth := BCFluentSliderWidth.Value;
end;



// MOUSE EVENTS //
procedure TFormMain.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  oldX := round(X / zoomfactor);
  oldy := round(Y / Zoomfactor);
  hmouseButton := mbLeft;
  Image1.Canvas.Pen.Color := foreColor;
  Image1.Canvas.Brush.Color := clNone;
  Image1.Canvas.Brush.Style := bsClear;    //todo daha sonra ayarla
  Image1.Canvas.Pen.Width := penWidth;

  Image1.Canvas.AntialiasingMode := amOn;
  if hMouseButton = mbLeft then
  begin
    hcShift := Shift;
    PX := round(X / zoomfactor);
    PY := round(Y / Zoomfactor);
    hMouseEvent := hMouseDown;
    case hctool of
      TOOL_PEN: hc_pen(Image1, hMouseButton, hcShift, pX, pY, hMouseEvent);
      TOOL_LINE: hc_line(Image1, Image2, hMouseButton, hcShift, pX, pY, hMouseEvent);
      TOOL_ELLIPSE1: hc_ellipse1(Image1, Image2, hMouseButton, hcShift,
          PX, PY, hMouseEvent);
    end;
  end;

end;

procedure TFormMain.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin

  if hMouseButton = mbLeft then
  begin
    hcShift := Shift;
    PX := round(X / zoomfactor);
    PY := round(Y / Zoomfactor);
    hMouseEvent := hMouseMove;
    case hctool of
      TOOL_PEN: hc_pen(Image1, hMouseButton, hcShift, pX, pY, hMouseEvent);
      TOOL_LINE: hc_line(Image1, Image2, hMouseButton, hcShift, pX, pY, hMouseEvent);
      TOOL_ELLIPSE1: hc_ellipse1(Image1, Image2, hMouseButton, hcShift,
          PX, PY, hMouseEvent);
    end;
  end
  else if hMouseButton = mbRight then
  begin

  end;
  StatusBar1.Panels[0].Text :=
    x.ToString + ' ' + y.ToString + ' - ' + PX.ToString + ' ' + PY.ToString;
  Memo1.Text := StatusBar1.Panels[0].Text;
end;
//Common tasks after end of  drawing
procedure TFormMain.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  hMouseEvent := hMouseUp;
  Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);
  hMouseButton := mbNone;
end;


procedure TFormMain.ImageColorBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  foreColor := HcColorFrame1.ImageColorBox.Canvas.Pixels[x, y];
end;

// MOUSE EVENTS END //


{END OF UNIT}
end.

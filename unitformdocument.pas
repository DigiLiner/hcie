unit unitformdocument;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, ComCtrls, ExtCtrls, Menus, SysUtils, Forms, Controls, Graphics, Dialogs
  , hceffects, hctypes, hcGlobals
  , LResources, BGRABitmap, BGRABitmapTypes  //BGRA Bitmap
  , line, pen, circle, fill
  , animation
  , Types;

type
  { TFormDocument}
  TFormDocument = class(TForm)
    Image1: TImage;
    Image2: TImage;
    ImageGrid :TImage ;
    MainPanel: TPanel;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure Image1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure Image1Paint (Sender :TObject );
    procedure Image1Resize(Sender: TObject);
    procedure MainPanelClick(Sender: TObject);
    procedure MenuItemEmbossHighlightClick(Sender: TObject);
    procedure MenuItemErodeBorderClick(Sender: TObject);
    procedure MenuItemPixelateClick(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ZoomIn;
    procedure ZoomOut;
    procedure ZoomReset;
    procedure Anim;
    procedure SetZoom(MousePoint: TPoint);
    procedure MyResize(MousePoint: Tpoint);
    procedure LoadImage;
    procedure NewImage;
    procedure AssignEmptyImage(_image: TImage; _width, _height: integer);
  private
    FormShown: boolean;
    zoomFactor: single;



  public
    fileName: string;
    ImageWidth, ImageHeight: integer;
    EmptyImage: boolean; // Boş mu olacak ,resim mi yüklenecek;

  end;

var
  FormDocument: TFormDocument;
  BitmapGrid:TBitmap;

  //HC Procedures

  procedure RenderGrid(Canvas: TCanvas; Height, Width: Integer;
  Size: Integer; Color1, Color2: TColor);


implementation

{$R *.lfm}

{ TFormDocument }

procedure TFormDocument.FormCreate(Sender: TObject);
begin
  //### NOTE: 03.11.2024
  //Bu bölüm tasarım sırasındaki karışıklığı engellemek için yazıldı
  MainPanel.Align := alClient;
  MainPanel.Anchors := [akBottom, akLeft, akRight, akTop];
  ScrollBox1.Align := alClient;
  ScrollBox1.Anchors := [];
  Panel1.Align := alNone;
  Panel1.Anchors := [akLeft, akTop];
  Image1.Align := alCustom;
  Image1.Anchors := [];
  // ### END NOTE ###############
  zoomFactor := 1;
  BitmapGrid:=TBitmap.Create;
  BitmapGrid.SetSize(ImageWidth,ImageHeight);
  BitMapGrid.PixelFormat:=pf24bit;
  RenderGrid(BitmapGrid.Canvas,ImageWidth,ImageHeight,40,clWhite,clGray);
end;

procedure TFormDocument.FormShow(Sender: TObject);
begin

end;

procedure TFormDocument.Image1Click(Sender: TObject);
begin

end;

procedure TFormDocument.MenuItemEmbossHighlightClick(Sender: TObject);
begin
  hceffects.EmbossHighlight(Image1, False);
end;

procedure TFormDocument.MenuItemErodeBorderClick(Sender: TObject);
begin
  ErodeBorderEffect(Image1);
end;

procedure TFormDocument.MenuItemPixelateClick(Sender: TObject);
begin
  Image1 := Pixelate(Image1, 10);
end;

procedure TFormDocument.ScrollBox1Click(Sender: TObject);
begin

end;


procedure TFormDocument.Timer1Timer(Sender: TObject);
begin
  // İlk kez çalışacak kodlar
  if EmptyImage = True then
    NewImage
  else
    LoadImage;

  hMouseButton := hMbNone;
  hMouseEvent := hMouseNone;
  zoomFactor := 1;
  ScaleFactor := 1;


  Timer1.Enabled := False;
end;

procedure TFormDocument.Anim;
begin
  animrun := not animrun;
  if animrun then
  begin
    doAnim(FormDocument.Image1);
  end;

end;

procedure TFormDocument.NewImage;
var
  bmp1, bmp2: TBGRABitmap;
begin
  // bmp1 := TBGRABitmap.Create(FormDocument.ImageWidth, FormDocument.ImageHeight,
  //  BGRAWhite);
  bmp1 := TBGRABitmap.Create(300, 300, BGRAWhite);
  bmp1.Draw(Image1.Canvas, 0, 0, True);
  bmp1.Free;           //free memory
  //FormMain'den kopya
  Image1.Width := ImageWidth;
  Image1.Height := ImageHeight;
  Image1.Top := 0;
  Image1.Left := 0;
  image1.Picture.Bitmap.SetSize(Image1.Width, image1.Height);
  image1.Canvas.Clear();
  image2.Canvas.Clear();
  Image2.Width := Image1.Width;
  Image2.Height := Image1.Height;
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;
  Image1.Picture.Bitmap.TransparentColor:=clBlack;
  Image1.Picture.Bitmap.TransparentMode:=tmFixed;
  Image1.Picture.Bitmap.Transparent:=true;

  Image2.Picture.Bitmap.PixelFormat:=pf24bit;
  Image2.Picture.Bitmap.TransparentColor:=clBlack;
  Image2.Picture.Bitmap.TransparentMode:=tmFixed;
  Image2.Picture.Bitmap.Transparent:=true;

  //tmpx AssignEmptyImage(Image1, Image1.Width, Image1.Height);
  // 200x200 boyutlarında boş bir resim ata
//tmpx AssignEmptyImage(Image2, Image1.Width, Image1.Height);
  // 200x200 boyutlarında boş bir resim ata
  // ToolButtonZoomOutClick(sender);
  Image2.Hide;
 zoomFactor := 1;
end;

procedure TFormDocument.AssignEmptyImage(_image: TImage; _width, _height: integer);

begin
  _Image.Picture.Bitmap := TBitmap.Create;
  try
  { //Transparency not work
    //_Image.Picture.Bitmap.Transparent := True;
    //FormMain.Image2.Picture.Bitmap.Transparent := True;
    //_Image.Picture.Bitmap.TransparentColor := $0;
    //FormMain.image2.Picture.Bitmap.TransparentColor := $0;
    //_Image.Picture.Bitmap.TransparentMode :=TTransparentMode.tmFixed;
   }
    _Image.Picture.Bitmap.Width := _width;
    _Image.Picture.Bitmap.Height := _height;
    _Image.Picture.Bitmap.Canvas.Brush.Color := $FFFFFF;
    _Image.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
   _Image.Picture.Bitmap.Canvas.FillRect(0, 0, _Width, _Height);

  finally

  end;
end;

procedure TFormDocument.LoadImage();
begin
  Image1.Picture.LoadFromFile(filename);
  Image1.Width := Image1.Picture.Width;
  Image1.Height := Image1.Picture.Height;
  Image2.Width := Image1.Picture.Width;
  Image2.Height := Image1.Picture.Height;

end;

{$REGION 'ZOOM'}

procedure TFormDocument.SetZoom(MousePoint: TPoint);
begin
  // with FormDocument do
  // begin
  Image1.Width := round(image2.Width * zoomFactor);
  //Image 2 is original
  Image1.Height := round(image2.Height * zoomFactor);
  Image1.Refresh;
  //FormMain.Image2.Scale := _zoomFactor;
  MyResize(MousePoint);
  //end;
end;
//todo ana formdaki toolbar -> zoom işlemlerinin hepsine bağlantı 8.11.24
//todo anaform toolbar butonlarını aktif-pasif et, menüleri uyarla
procedure TFormDocument.ZoomIn;
begin
  zoomFactor := zoomFactor * 1.2;
  SetZoom(Point(0, 0));
end;

procedure TFormDocument.ZoomOut;
begin
  zoomFactor := zoomFactor / 1.2;
  SetZoom(point(0, 0));
end;

procedure TFormDocument.ZoomReset;
begin
  zoomFactor := 1;
  SetZoom(point(0, 0));
end;

{$ENDREGION}

procedure TFormDocument.MyResize(MousePoint: Tpoint);
var
  border: integer;
  PX, PY: integer;
  ScrollPosX, ScrollPosY: integer;
begin
  // with FormDocument do
  // begin
  // Detect the scaling factor (for example, 125% scaling = 1.25)
  ScaleFactor := Screen.PixelsPerInch / 96; // Assuming 96 DPI is the baseline
  PX := round(round(MousePoint.X / zoomfactor) / ScaleFactor);
  Py := round(round(Mousepoint.Y / Zoomfactor) / ScaleFactor);

  border := round(max(Image1.Width, Image1.Height) / 50);
  Panel1.BorderSpacing.Left := round((ScrollBox1.Width - image1.Width) / 2);
  Panel1.BorderSpacing.top := round((ScrollBox1.Height - Image1.Height) / 2);
  Image1.left := border;
  image1.Top := border;

  Panel1.Width := image1.Width + (border * 2);
  panel1.Height := image1.Height + (border * 2);
  if (MousePoint.x <> 0) or (MousePoint.y <> 0) then
  begin
    ScrollPosX := MousePoint.X;
    ScrollPosY := MousePoint.y;
    //   ScrollBox1.HorzScrollBar.Position:=ScrollPosX;
    //  ScrollBox1.VertScrollBar.Position:=ScrollPosY;
  end;


  ScrollBox1.UpdateScrollbars;

  //end;

end;

{$REGION 'MOUSE EVENTS'}

//########### MOUSE DOWN ##############
procedure TFormDocument.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  // Detect the scaling factor (for example, 125% scaling = 1.25)
  ScaleFactor := Screen.PixelsPerInch / 96; // Assuming 96 DPI is the baseline
  oldX := round(round(X / zoomfactor) / ScaleFactor);
  oldy := round(round(Y / Zoomfactor) / ScaleFactor);
  //oldX := X;
  //oldy := y;
  hMouseEvent := hMouseDown;


  if Button = TMouseButton.mbLeft then
  begin
    hMouseButton := hMbLeft;
    Image1.Canvas.Pen.Width := penWidth;
    image1.Canvas.Pen.Color := foreColor;
    { RGBToColor(RedComponent(foreColor),GreenComponent(foreColor), BlueComponent(foreColor));   }
    // Image1.Canvas.Brush.Style := bsClear;    //todo daha sonra ayarla
    // Image1.Canvas.Brush.Color := clWhite;
    // image1.Canvas.AntialiasingMode := amOn;
    // Image1.Transparent := True;
    hcShift := Shift;
    PX := round(round(X / zoomfactor) / ScaleFactor);
    PY := round(round(Y / Zoomfactor) / ScaleFactor);

    case hctool of
      TOOL_PEN: hc_pen(Image1, hcShift, PX, PY);
      TOOL_LINE: hc_line(Image1, Image2, hcShift, pX, pY);
      TOOL_ELLIPSE1: hc_ellipse1(Image1, Image2, hcShift, PX, PY);
      TOOL_FILL: hc_Fill(image1, image2, Button, hcShift, PX, PY, hMouseEvent);
      else
      // Handle unexpected values

    end;
  end;

end;
// ####  MOUSE MOVE #########################
procedure TFormDocument.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin
  hMouseEvent := hMouseMove;
  PX := round(round(X / zoomfactor) / ScaleFactor);
  PY := round(round(Y / Zoomfactor) / ScaleFactor);

  if hmouseButton = hMbLeft then
  begin
    hcShift := Shift;


    case hctool of
      TOOL_PEN: hc_pen(Image1, Shift, PX, PY);
      TOOL_LINE: hc_line(Image1, Image2, Shift, pX, pY);
      TOOL_ELLIPSE1: hc_ellipse1(Image1, Image2, Shift, PX, PY);
      TOOL_FILL: ;

      else
      // Handle unexpected values

    end;
  end
  else if hmouseButton = hmbRight then
  begin

  end
  else if Shift = [ssMiddle] then
  begin
    //PAN
    // OldX mouse basıldığındaki ilk posizyon. PX şu anki pozisyon. Resim aradaki fark kadar kaydırılıyor.
    //PX ve  OldX zoomFactor eklenmiş olarak hesaplanıyor
    ScrollBox1.HorzScrollBar.Position := ScrollBox1.HorzScrollBar.Position - (px - oldX);
    ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position - (pY - oldY);

  end;
  // StatusBar1.Panels[0].Text
  UpdateText('X: ' + x.ToString + ' ' + ' Y: ' + y.ToString + ' - ' +
    ' PX: ' + PX.ToString + ' ' + ' PY: ' + PY.ToString + ' -  ' +
    ' Scale: ' + ' Image1 Left :' + Image1.left.ToString + ' Image1 Top :' +
    Image1.Top.ToString + ScaleFactor.ToString + ' ' + ' Zoom: ' +
    zoomFactor.ToString + ' H Scroll :' + ScrollBox1.HorzScrollBar.Position.ToString +
    ' V Scroll :' + ScrollBox1.VertScrollBar.Position.ToString);
end;


//######### MOUSE UP ####################
//Common tasks after end of  drawing
procedure TFormDocument.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  hMouseEvent := hMouseUp;
  PX := round(round(X / zoomfactor) / ScaleFactor);
  PY := round(round(Y / Zoomfactor) / ScaleFactor);
  case hctool of
    TOOL_PEN: hc_pen(Image1, hcShift, PX, PY);
    TOOL_LINE: hc_line(Image1, Image2, hcShift, pX, pY);
    TOOL_ELLIPSE1: hc_ellipse1(Image1, Image2, hcShift, PX, PY);
    TOOL_FILL: hc_Fill(image1, image2, Button, hcShift, PX, PY, hMouseEvent);
    else
    // Handle unexpected values

  end;
  Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);
  hMouseButton := hMbNone;
  hMouseEvent := hMouseNone;

end;

procedure TFormDocument.Image1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: boolean);
begin
  zoomFactor := zoomFactor / 1.1;
  SetZoom(MousePos);
end;

procedure TFormDocument.Image1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: boolean);
begin
  zoomFactor := zoomFactor * 1.1;
  SetZoom(MousePos);
end;

procedure TFormDocument.Image1Paint (Sender :TObject );
begin
  Image1.Canvas.Draw(0,0,BitmapGrid);
end;


// MOUSE EVENTS END //
{$ENDREGION 'MOUSE EVENTS'}


procedure TFormDocument.Image1Resize(Sender: TObject);
begin
  MyResize(point(0, 0));
end;

procedure TFormDocument.ScrollBox1Resize(Sender: TObject);
begin
  MyResize(point(0, 0));
end;


procedure TFormDocument.MainPanelClick(Sender: TObject);
begin

end;
procedure RenderGrid(canvas: Tcanvas; Height, Width: Integer;
  Size: Integer; Color1, Color2: TColor);
var
  y: Integer;
  x: Integer;
begin
  for y := 0 to Height div Size do
    for x := 0 to Width div Size do
    begin
      if Odd(x) xor Odd(y) then
       Canvas.Brush.Color := Color1
      else
       Canvas.Brush.Color := Color2;
       Canvas.FillRect(Rect(x*Size, y*Size, (x+1)*Size, (y+1)*Size));
    end;
end;



end.

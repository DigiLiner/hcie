UNIT unitformdocument;

{$mode ObjFPC}{$H+}

INTERFACE

USES
  Classes, ComCtrls, ExtCtrls, Menus, SysUtils, Forms, Controls, Graphics, Dialogs
  , LResources, BGRABitmap, BGRABitmapTypes  //BGRA Bitmap
  , Types
  , hceffects, hctypes, hcGlobals ,hcFileTypes
  ,line, pen, circle, fill
  , animation

  ;

TYPE
  { TFormDocument}
  TFormDocument = CLASS(TForm)
    Image1: TImage;
    Image2: TImage;
    ImageGrid: TImage;
    MainPanel: TPanel;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    Timer1: TTimer;
    PROCEDURE FormCreate(Sender: TObject);
    procedure FormResize (Sender :TObject );
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE Image1Click(Sender: TObject);
    PROCEDURE Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    PROCEDURE Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    PROCEDURE Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    PROCEDURE Image1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; VAR Handled: boolean);
    PROCEDURE Image1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; VAR Handled: boolean);
    PROCEDURE Image1Paint(Sender: TObject);
    PROCEDURE Image1Resize(Sender: TObject);
    PROCEDURE MainPanelClick(Sender: TObject);
    PROCEDURE MenuItemEmbossHighlightClick(Sender: TObject);
    PROCEDURE MenuItemErodeBorderClick(Sender: TObject);
    PROCEDURE MenuItemPixelateClick(Sender: TObject);
    PROCEDURE ScrollBox1Click(Sender: TObject);
    PROCEDURE ScrollBox1Resize(Sender: TObject);
    PROCEDURE Timer1Timer(Sender: TObject);
    PROCEDURE ZoomIn;
    PROCEDURE ZoomOut;
    PROCEDURE ZoomReset;
    PROCEDURE Anim;
    PROCEDURE SetZoom(MousePoint: TPoint);
    PROCEDURE MyResize(MousePoint: TPoint);
    PROCEDURE LoadImage;
    PROCEDURE NewImage;
    PROCEDURE AssignEmptyImage(_image: TImage; _width, _height: integer);
  private
    FormShown: boolean;
    zoomFactor: single;


  public
    fileName: string;
    ImageWidth, ImageHeight: integer;
    EmptyImage: boolean; // Boş mu olacak ,resim mi yüklenecek;

  END;

VAR
  FormDocument: TFormDocument;
  BitmapGrid: TBitmap;

  //HC Procedures

PROCEDURE RenderGrid(Canvas: TCanvas; Height, Width: integer;
  Size: integer; Color1, Color2: TColor);


IMPLEMENTATION

{$R *.lfm}

{ TFormDocument }

PROCEDURE TFormDocument.FormCreate(Sender: TObject);
BEGIN

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
  BitmapGrid := TBitmap.Create;
  BitmapGrid.SetSize(ImageWidth, ImageHeight);
  BitmapGrid.PixelFormat := pf24bit;
  RenderGrid(BitmapGrid.Canvas, ImageWidth, ImageHeight, 40, clWhite, clGray);
END;

procedure TFormDocument .FormResize (Sender :TObject );
begin
   MyResize(Point(0, 0));
end;

PROCEDURE TFormDocument.FormShow(Sender: TObject);
BEGIN

END;

PROCEDURE TFormDocument.Image1Click(Sender: TObject);
BEGIN

END;

PROCEDURE TFormDocument.MenuItemEmbossHighlightClick(Sender: TObject);
BEGIN
  hceffects.EmbossHighlight(Image1, False);
END;

PROCEDURE TFormDocument.MenuItemErodeBorderClick(Sender: TObject);
BEGIN
  ErodeBorderEffect(Image1);
END;

PROCEDURE TFormDocument.MenuItemPixelateClick(Sender: TObject);
BEGIN
  Image1 := Pixelate(Image1, 10);
END;

PROCEDURE TFormDocument.ScrollBox1Click(Sender: TObject);
BEGIN

END;


PROCEDURE TFormDocument.Timer1Timer(Sender: TObject);
BEGIN
  // İlk kez çalışacak kodlar
  IF EmptyImage = True THEN
    NewImage
  ELSE
    LoadImage;

  hMouseButton := hMbNone;
  hMouseEvent := hMouseNone;
  zoomFactor := 1;
  ScaleFactor := 1;


  Timer1.Enabled := False;
END;

PROCEDURE TFormDocument.Anim;
BEGIN
  animrun := NOT animrun;
  IF animrun THEN
    BEGIN
    doAnim(FormDocument.Image1);
    END;

END;

PROCEDURE TFormDocument.NewImage;
VAR
  bmp1, bmp2: TBGRABitmap;
BEGIN
  // bmp1 := TBGRABitmap.Create(FormDocument.ImageWidth, FormDocument.ImageHeight,
  //  BGRAWhite);

  Image1.Width := ImageWidth;
  Image1.Height := ImageHeight;
  Image1.Top := 0;
  Image1.Left := 0;
  Image1.Picture.Bitmap.SetSize(Image1.Width, Image1.Height);
  Image2.Width := Image1.Width;
  Image2.Height := Image1.Height;
  {$IFNDEF TRANSPARENCY_TEST_01}
  	//  Temporary disabled test transparency 9.11.24
        bmp1 := TBGRABitmap.Create(300, 300, BGRAWhite);
 	bmp1.Draw(Image1.Canvas, 0, 0, True);
  	bmp1.Free;       //free memory

	image1.Canvas.Clear();
	image2.Canvas.Clear();
   	Image1.Picture.Bitmap.PixelFormat:=pf24bit;
	Image1.Picture.Bitmap.TransparentColor:=clBlue;
	Image1.Picture.Bitmap.TransparentMode:=tmFixed;
	Image1.Picture.Bitmap.Transparent:=true;

	Image2.Picture.Bitmap.PixelFormat:=pf24bit;
	Image2.Picture.Bitmap.TransparentColor:=clYellow;
	Image2.Picture.Bitmap.TransparentMode:=tmFixed;
	Image2.Picture.Bitmap.Transparent:=true;

         // 200x200 boyutlarında boş bir resim ata
	AssignEmptyImage(Image1, Image1.Width, Image1.Height);
	AssignEmptyImage(Image2, Image1.Width, Image1.Height);
  {$ENDIF}

  Image2.Hide;
  zoomFactor := 1;
END;

PROCEDURE TFormDocument.AssignEmptyImage(_image: TImage; _width, _height: integer);
BEGIN
  _image.Picture.Bitmap := TBitmap.Create;
    TRY
  { //Transparency not work
    //_Image.Picture.Bitmap.Transparent := True;
    //FormMain.Image2.Picture.Bitmap.Transparent := True;
    //_Image.Picture.Bitmap.TransparentColor := $0;
    //FormMain.image2.Picture.Bitmap.TransparentColor := $0;
    //_Image.Picture.Bitmap.TransparentMode :=TTransparentMode.tmFixed;
   }
    _image.Picture.Bitmap.Width := _width;
    _image.Picture.Bitmap.Height := _height;
    {$IFNDEF TRANSPARENCY_TEST_01}
	_Image.Picture.Bitmap.Canvas.Brush.Color := $FFFFFF;
	_Image.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
	_Image.Picture.Bitmap.Canvas.FillRect(0, 0, _Width, _Height);
    {$ENDIF}

    FINALLY

    END;
END;

PROCEDURE TFormDocument.LoadImage();
BEGIN
  Image1.Picture.LoadFromFile(fileName);
  Image1.Width := Image1.Picture.Width;
  Image1.Height := Image1.Picture.Height;
  Image2.Width := Image1.Picture.Width;
  Image2.Height := Image1.Picture.Height;

END;

{$REGION 'ZOOM'}

PROCEDURE TFormDocument.SetZoom(MousePoint: TPoint);
BEGIN
  // with FormDocument do
  // begin
  Image1.Width := round(Image2.Width * zoomFactor);
  //Image 2 is original
  Image1.Height := round(Image2.Height * zoomFactor);
  Image1.Refresh;
  //FormMain.Image2.Scale := _zoomFactor;
  MyResize(MousePoint);
  //end;
END;
//todo ana formdaki toolbar -> zoom işlemlerinin hepsine bağlantı 8.11.24
//todo anaform toolbar butonlarını aktif-pasif et, menüleri uyarla
PROCEDURE TFormDocument.ZoomIn;
BEGIN
  zoomFactor := zoomFactor * 1.2;
  SetZoom(Point(0, 0));
END;

PROCEDURE TFormDocument.ZoomOut;
BEGIN
  zoomFactor := zoomFactor / 1.2;
  SetZoom(Point(0, 0));
END;

PROCEDURE TFormDocument.ZoomReset;
BEGIN
  zoomFactor := 1;
  SetZoom(Point(0, 0));
END;

{$ENDREGION}

PROCEDURE TFormDocument.MyResize(MousePoint: TPoint);
VAR
  border: integer;
  PX, PY: integer;
  ScrollPosX, ScrollPosY: integer;
BEGIN
  // with FormDocument do
  // begin
  // Detect the scaling factor (for example, 125% scaling = 1.25)
  ScaleFactor := Screen.PixelsPerInch / 96; // Assuming 96 DPI is the baseline
  PX := round(round(MousePoint.X / zoomFactor) / ScaleFactor);
  PY := round(round(MousePoint.Y / zoomFactor) / ScaleFactor);

  border := round(max(Image1.Width, Image1.Height) / 50);
  Panel1.BorderSpacing.Left := round((ScrollBox1.Width - Image1.Width) / 2);
  Panel1.BorderSpacing.Top := round((ScrollBox1.Height - Image1.Height) / 2);
  Image1.Left := border;
  Image1.Top := border;

  Panel1.Width := Image1.Width + (border * 2);
  Panel1.Height := Image1.Height + (border * 2);
  IF (MousePoint.X <> 0) OR (MousePoint.Y <> 0) THEN
    BEGIN
    ScrollPosX := MousePoint.X;
    ScrollPosY := MousePoint.Y;
    //   ScrollBox1.HorzScrollBar.Position:=ScrollPosX;
    //  ScrollBox1.VertScrollBar.Position:=ScrollPosY;
    END;


  ScrollBox1.UpdateScrollbars;

  //end;

END;

{$REGION 'MOUSE EVENTS'}

//########### MOUSE DOWN ##############
PROCEDURE TFormDocument.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
BEGIN
  // Detect the scaling factor (for example, 125% scaling = 1.25)
  ScaleFactor := Screen.PixelsPerInch / 96; // Assuming 96 DPI is the baseline
  oldX := round(round(X / zoomFactor) / ScaleFactor);
  oldy := round(round(Y / zoomFactor) / ScaleFactor);
  //oldX := X;
  //oldy := y;
  hMouseEvent := hMouseDown;


  IF Button = TMouseButton.mbLeft THEN
    BEGIN
    hMouseButton := hMbLeft;
    Image1.Canvas.pen.Width := penWidth;
    Image1.Canvas.pen.Color := foreColor;
    { RGBToColor(RedComponent(foreColor),GreenComponent(foreColor), BlueComponent(foreColor));   }
    // Image1.Canvas.Brush.Style := bsClear;    //todo daha sonra ayarla
    // Image1.Canvas.Brush.Color := clWhite;
    // image1.Canvas.AntialiasingMode := amOn;
    // Image1.Transparent := True;
    hcShift := Shift;
    PX := round(round(X / zoomFactor) / ScaleFactor);
    PY := round(round(Y / zoomFactor) / ScaleFactor);

    CASE hctool OF
      TOOL_PEN: hc_pen(Image1, hcShift, PX, PY);
      TOOL_LINE: hc_line(Image1, Image2, hcShift, PX, PY);
      TOOL_ELLIPSE1: hc_ellipse1(Image1, Image2, hcShift, PX, PY);
      TOOL_FILL: hc_Fill(Image1, Image2, Button, hcShift, PX, PY, hMouseEvent);
      ELSE
      // Handle unexpected values

      END;
    END;

END;
// ####  MOUSE MOVE #########################
PROCEDURE TFormDocument.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
BEGIN
  hMouseEvent := hMouseMove;
  PX := round(round(X / zoomFactor) / ScaleFactor);
  PY := round(round(Y / zoomFactor) / ScaleFactor);

  IF hMouseButton = hMbLeft THEN
    BEGIN
    hcShift := Shift;


    CASE hctool OF
      TOOL_PEN: hc_pen(Image1, Shift, PX, PY);
      TOOL_LINE: hc_line(Image1, Image2, Shift, PX, PY);
      TOOL_ELLIPSE1: hc_ellipse1(Image1, Image2, Shift, PX, PY);
      TOOL_FILL: ;

      ELSE
      // Handle unexpected values

      END;
    END
  ELSE IF hMouseButton = hmbRight THEN
      BEGIN

      END
    ELSE IF Shift = [ssMiddle] THEN
        BEGIN
    //PAN
    // OldX mouse basıldığındaki ilk posizyon. PX şu anki pozisyon. Resim aradaki fark kadar kaydırılıyor.
    //PX ve  OldX zoomFactor eklenmiş olarak hesaplanıyor
        ScrollBox1.HorzScrollBar.Position :=
          ScrollBox1.HorzScrollBar.Position - (PX - oldX);
        ScrollBox1.VertScrollBar.Position :=
          ScrollBox1.VertScrollBar.Position - (PY - oldy);

        END;
  // StatusBar1.Panels[0].Text
  UpdateText('X: ' + X.ToString + ' ' + ' Y: ' + Y.ToString + ' - ' +
    ' PX: ' + PX.ToString + ' ' + ' PY: ' + PY.ToString + ' -  ' +
    ' Scale: ' + ' Image1 Left :' + Image1.Left.ToString + ' Image1 Top :' +
    Image1.Top.ToString + ScaleFactor.ToString + ' ' + ' Zoom: ' +
    zoomFactor.ToString + ' H Scroll :' + ScrollBox1.HorzScrollBar.Position.ToString +
    ' V Scroll :' + ScrollBox1.VertScrollBar.Position.ToString);
END;


//######### MOUSE UP ####################
//Common tasks after end of  drawing
PROCEDURE TFormDocument.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
BEGIN
  hMouseEvent := hMouseUp;
  PX := round(round(X / zoomFactor) / ScaleFactor);
  PY := round(round(Y / zoomFactor) / ScaleFactor);
  CASE hctool OF
    TOOL_PEN: hc_pen(Image1, hcShift, PX, PY);
    TOOL_LINE: hc_line(Image1, Image2, hcShift, PX, PY);
    TOOL_ELLIPSE1: hc_ellipse1(Image1, Image2, hcShift, PX, PY);
    TOOL_FILL: hc_Fill(Image1, Image2, Button, hcShift, PX, PY, hMouseEvent);
    ELSE
    // Handle unexpected values

    END;
  Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);
  hMouseButton := hMbNone;
  hMouseEvent := hMouseNone;

END;

PROCEDURE TFormDocument.Image1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; VAR Handled: boolean);
BEGIN
  zoomFactor := zoomFactor / 1.1;
  SetZoom(MousePos);
END;

PROCEDURE TFormDocument.Image1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; VAR Handled: boolean);
BEGIN
  zoomFactor := zoomFactor * 1.1;
  SetZoom(MousePos);
END;

PROCEDURE TFormDocument.Image1Paint(Sender: TObject);
BEGIN
  Image1.Canvas.Draw(0, 0, BitmapGrid);
END;


// MOUSE EVENTS END //
{$ENDREGION 'MOUSE EVENTS'}


PROCEDURE TFormDocument.Image1Resize(Sender: TObject);
BEGIN
  MyResize(Point(0, 0));
END;

PROCEDURE TFormDocument.ScrollBox1Resize(Sender: TObject);
BEGIN
  MyResize(Point(0, 0));
END;


PROCEDURE TFormDocument.MainPanelClick(Sender: TObject);
BEGIN

END;

PROCEDURE RenderGrid(Canvas: TCanvas; Height, Width: integer;
  Size: integer; Color1, Color2: TColor);
VAR
  Y: integer;
  X: integer;
BEGIN
  FOR Y := 0 TO Height DIV Size DO
    FOR X := 0 TO Width DIV Size DO
      BEGIN
      IF Odd(X) XOR Odd(Y) THEN
        Canvas.Brush.Color := Color1
      ELSE
        Canvas.Brush.Color := Color2;
      Canvas.FillRect(Rect(X * Size, Y * Size, (X + 1) * Size, (Y + 1) * Size));
      END;
END;


END.

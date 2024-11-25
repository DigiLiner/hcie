unit unitFormMain;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF HASAMIGA}
 athreads, hcamigaeffects,
  {$Else}
  BGRAGraphicControl, CustomDrawnControls, hceffects,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,Registry,
  {$ENDIF}
  Classes ,interfaces ,SysUtils ,Forms ,Controls ,Graphics ,Dialogs ,Menus ,
  ExtCtrls ,StdCtrls ,ComCtrls ,ExtDlgs ,AnchorDockPanel ,crt ,unitFormNewImage ,
  BCFluentSlider ,BCToolBar ,BGRAFlashProgressBar ,BGRAImageList ,
  BGRAImageManipulation ,BGRACustomDrawn ,BGRAShape ,BCTrackbarUpdown ,
  BCMaterialProgressBarMarquee ,BCFluentProgressRing ,BCLeaLCDDisplay ,BCLeaLED ,
  BGRASVGImageList ,HexaColorPicker ,hctypes ,hcGlobals ,animation ,hcslider // Sliders
  , line, pen, circle, fill
  , unitCanvasSizeDialog
  , unitformdocument
  , LResources, BGRABitmap, BGRABitmapTypes  //BGRA Bitmap
  , Types, BCTypes;

type

  {$IFDEF WINDOWS}
  { TPageControl }
  TPageControl = class(ComCtrls.TPageControl)
  private


  protected
    procedure MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove ( Shift :TShiftState ; X ,Y :Integer );override;
    procedure PaintWindow(DC: HDC); override;
  const
   btnSize = 10;
   xoff   =-5;
   yoff =5;

  var
     onmouse:array  of boolean;
  end;
  {$ENDIF}


  { TFormMain }

  TFormMain = class(TForm)
    AnchorDockPanel1: TAnchorDockPanel;
    BCLeaLED1: TBCLeaLED;
    BCLeaLED2: TBCLeaLED;
    BCLeaLED3: TBCLeaLED;
    BCToolBar1 :TBCToolBar ;
    BGRAGraphicControl1: TBGRAGraphicControl;
    BGRAImageList1 :TBGRAImageList ;
    BGRASVGImageList1 :TBGRASVGImageList ;
    CalculatorDialog1: TCalculatorDialog;
    CheckBoxWebSafe: TCheckBox;
    ColorDialog1: TColorDialog;
    EditWidth: TEdit;
    FindDialog1: TFindDialog;
    FlowPanel1: TPanel;
    FontDialog1: TFontDialog;
    HexaColorPicker1: THexaColorPicker;
    IdleTimer1: TIdleTimer;

    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageRadius: TImage;
    ImageTransparency: TImage;
    ImageWidth: TImage;
    Label1: TLabel;
    Label2: TLabel;
    LabelForeColor: TLabel;
    MainMenu1: TMainMenu;
    MenuItemCopy: TMenuItem;
    MenuItemPaste: TMenuItem;
    MenuItemCut: TMenuItem;
    MenuItemRedo: TMenuItem;
    MenuItemUndo: TMenuItem;
    MenuItemSaveAs: TMenuItem;
    MenuItemSave: TMenuItem;
    MenuItemClose: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItemAddSelect: TMenuItem;
    MenuItemAttrib: TMenuItem;
    MenuItemAutoColor: TMenuItem;
    MenuItemBrush: TMenuItem;
    MenuItemBurn: TMenuItem;
    MenuItemCanvasSize: TMenuItem;
    MenuItemCircle: TMenuItem;
    MenuItemCloseAll: TMenuItem;
    MenuItemColor: TMenuItem;
    MenuItemColorBalance: TMenuItem;
    MenuItemDropper: TMenuItem;
    MenuItemEdit: TMenuItem;
    MenuItemEllipse: TMenuItem;
    MenuItemEmbossHighlight: TMenuItem;
    MenuItemEraser: TMenuItem;
    MenuItemErodeBorder: TMenuItem;
    MenuItemExif: TMenuItem;
    MenuItemExit: TMenuItem;
    MenuItemFile: TMenuItem;
    MenuItemFill: TMenuItem;
    MenuItemFillEllipse: TMenuItem;
    MenuItemCircled: TMenuItem;
    MenuItemFilters: TMenuItem;
    MenuItemFlattenImage: TMenuItem;
    MenuItemFlattenLayer: TMenuItem;
    MenuItemFlipHorizontal: TMenuItem;
    MenuItemFlipVertical: TMenuItem;
    MenuItemHelp: TMenuItem;
    MenuItemHexagon: TMenuItem;
    MenuItemImage: TMenuItem;
    MenuItemLine: TMenuItem;
    MenuItemNegative: TMenuItem;
    MenuItemNew: TMenuItem;
    MenuItemNewLayer: TMenuItem;
    MenuItemNGen: TMenuItem;
    MenuItemOpen: TMenuItem;
    MenuItemPen: TMenuItem;
    MenuItemPentagon: TMenuItem;
    MenuItemPixelate: TMenuItem;
    MenuItemPolySelect: TMenuItem;
    MenuItemRays: TMenuItem;
    MenuItemRectangle: TMenuItem;
    MenuItemRemoveSelect: TMenuItem;
    MenuItemResize: TMenuItem;
    MenuItemRotate: TMenuItem;
    MenuItemRoundRectangle: TMenuItem;
    MenuItemSaveAll: TMenuItem;
    MenuItemSelect: TMenuItem;
    MenuItemSelectByColor: TMenuItem;
    MenuItemSelectEliptic: TMenuItem;
    MenuItemSelectRect: TMenuItem;
    MenuItemSpray: TMenuItem;
    MenuItemStar: TMenuItem;
    MenuItemText: TMenuItem;
    MenuItemTools: TMenuItem;
    MenuItemView: TMenuItem;
    MenuItemWand: TMenuItem;
    MenuItemWindow: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    PageControl1: TPageControl;
    PopupMenuCircle: TPopupMenu;
    SavePictureDialog1: TSavePictureDialog;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Panel2: TPanel;
    Separator1: TMenuItem;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    Timer1: TTimer;
    TimerStartup: TTimer;
    TimerStatus: TTimer;
    S1: TToolButton;
    S3: TToolButton;
    S4: TToolButton;
    S5: TToolButton;
    S6: TToolButton;
    S7: TToolButton;
    ToolButtonFill: TToolButton;
    ToolButtonRedo: TToolButton;
    ToolButtonClear: TToolButton;
    ToolButtonCrop: TToolButton;
    ToolButtonUndo: TToolButton;
    ToolButtonCopy: TToolButton;
    ToolButtonPaste: TToolButton;
    ToolButtonCut: TToolButton;
    ToolButtonPrint: TToolButton;
    S2: TToolButton;
    ToolButtonNew: TToolButton;
    ToolButtonOpen: TToolButton;
    ToolButtonSave: TToolButton;
    ToolButtonBlur: TToolButton;
    ToolButtonPixelate: TToolButton;
    ToolButtonZoomReset: TToolButton;
    ToolButtonZoomOut: TToolButton;
    ToolButtonZoomIn: TToolButton;
    ToolButtonEllipse: TToolButton;
    ToolButtonAnim: TToolButton;
    ToolButtonPen: TToolButton;
    ToolButtonLine: TToolButton;
    TrackBar1: TTrackBar;

    procedure BCMaterialProgressBarMarquee1Click(Sender: TObject);
    procedure BCToolBar1Redraw (Sender :TObject ; Bitmap :TBGRABitmap );
    procedure BCTrackbarUpdown1Change(Sender: TObject; AByUser: boolean);
    procedure CheckBoxWebSafeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HexaColorPicker1Change(Sender: TObject);
    procedure ImageColorBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Label1Click(Sender: TObject);
    procedure MainPanelClick(Sender: TObject);
    procedure MenuItemCanvasSizeClick(Sender: TObject);
    procedure ImageWidthMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure MenuItemExitClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1CloseTabClicked (Sender :TObject );
    procedure PageControl1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);

    procedure ScrollBox1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure ToolButtonFillClick(Sender: TObject);
    procedure ToolButtonNewClick(Sender: TObject);
    procedure ToolButtonBlurClick(Sender: TObject);
    procedure ToolButtonEllipseClick(Sender: TObject);
    procedure ToolButtonOpenClick(Sender: TObject);
    procedure ToolButtonPenClick(Sender: TObject);
    procedure ToolButtonLineClick(Sender: TObject);
    procedure ToolButtonPixelateClick(Sender: TObject);
    procedure ToolButtonZoomInClick(Sender: TObject);

    //In Form procedures End

  private
    bImage1, bImage2: TBGRABitmap;

  public

  end;

var
  FormMain: TFormMain;

  // Additional procedures here

function IsDarkTheme: boolean;
procedure ApplyTheme(Form: TForm);
function findDocument(docTag: integer): TFormDocument;

implementation

{$R *.lfm}

{$IFDEF WINDOWS}
procedure TPageControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  R : TRect;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    R := TabRect(ActivePageIndex);
   if PtInRect(Classes.Rect(R.Right - btnSize + xoff-3, R.Top + yoff-3,
                             R.Right +xoff+4, R.Top + btnSize + yoff+4),
              Classes.Point(X, Y))
    then ActivePage.Free;
  end;
end;
procedure TPageControl.MouseMove (Shift :TShiftState ; X ,
      Y :Integer );
var
   i  :integer;
  R : TRect;
  bm : TBitmap;
  Pen: HPEN;
  OldPen : HPEN;
  DrawColor: TColor;
  Red, Green, Blue: Byte;
begin
  inherited MouseMove(Shift,X,Y);
   R := TabRect(ActivePageIndex);
   SetLength(onmouse,PageCount +1);
           if PtInRect(Classes.Rect(R.Right - btnSize + xoff-3, R.Top + yoff-3,
                             R.Right +xoff+4, R.Top + btnSize + yoff+4),
              Classes.Point(X, Y))  then
              begin
                onmouse[ActivePageIndex]  :=true;
              end else
                    onmouse[ActivePageIndex] :=false;

           Repaint;

end ;

procedure TPageControl.PaintWindow(DC: HDC);
var
  i  :integer;
  R : TRect;
  bm : TBitmap;
  Pen: HPEN;
  OldPen : HPEN;
  DrawColor: TColor;
  Red, Green, Blue: Byte;

begin
  inherited PaintWindow(DC);

  bm := TBitmap.Create;
  try
    bm.SetSize(16, 16);
    Images.GetBitmap(0, bm);
     SetLength(onmouse,PageCount +1);

    for i := 0 to Pred(PageCount) do
    begin
          R := TabRect(i);
          // Create a pen with desired thickness (e.g., 5)
          DrawColor := ColorToRGB(cl3DDkShadow);
          Red := GetRValue(DrawColor);
          Green := GetGValue(DrawColor);
          Blue := GetBValue(DrawColor);
           if onmouse[i] =true then
          begin
          Pen := CreatePen(PS_SOLID, 1, RGB( red, green, blue)); // 5 is the thickness of the pen
          OldPen := SelectObject(DC, Pen);
          Rectangle(DC,R.Right - btnSize+Xoff-3 ,R.Top +yoff -3,
          R.Right +Xoff +4,r.Top+btnSize +yoff +4 );
          end;

          Pen := CreatePen(PS_SOLID, 2, RGB( red, green, blue)); // 5 is the thickness of the pen
          OldPen := SelectObject(DC, Pen);

          MoveToEx(DC,R.Right - btnSize+Xoff ,R.Top +yoff ,Nil) ;
          LineTo(DC,R.Right +Xoff ,r.Top+btnSize +yoff)  ;
          MoveToEx(DC,R.Right - btnSize +Xoff,R.Top + btnsize + yoff,Nil) ;
          LineTo(DC,R.Right +Xoff ,R.Top +yoff )  ;


          //Alternative
          //     StretchBlt(DC, R.Right - btnSize - 4, R.Top + 2,
          //       btnSize, btnSize, bm.Canvas.Handle, 0, 0, 16, 16, cmSrcCopy);
    end;
  finally
    bm.Free;
    FormMain.Timer1.Enabled:=True;
    SelectObject(DC, OldPen);
  DeleteObject(Pen);
  end;
end;
{$ENDIF}


{ TFormMain }



procedure TFormMain.ToolButtonEllipseClick(Sender: TObject);
begin
  hctool := TOOL_ELLIPSE1;
end;

procedure TFormMain.ToolButtonOpenClick(Sender: TObject);
var
  NewDoc: TFormDocument;
  NewPage: TTabSheet;
begin

  if OpenPictureDialog1.Execute then
  begin
    NewPage := PageControl1.AddTabSheet;
    NewDoc := TFormDocument.Create(Application);
    NewDoc.Caption := OpenPictureDialog1.FileName;
    NewDoc.EmptyImage := False; //Load from File
    NewDoc.Parent := NewPage;
    NewDoc.WindowState := wsMaximized;
    Inc(imageCounter); // Increment last image number
    NewPage.Caption := OpenPictureDialog1.FileName;
    NewDoc.Tag := imageCounter;
    NewDoc.fileName := NewPage.Caption; // Set caption as Filename
    NewDoc.Show();
    NewPage.Invalidate;
    PageControl1.ActivePage := NewPage;
  end;

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

end;

procedure TFormMain.ToolButtonZoomInClick(Sender: TObject);
begin
  findDocument(5).ZoomIn;
end;


procedure TFormMain.FormCreate(Sender: TObject);
begin

  {$if declared(UseHeapTrace)}
  GlobalSkipIfNoLeaks := True; // supported as of debugger version 3.2.0
  {$endIf}
  ApplyTheme(Self);


  //Dark mode
  //30.11.2024 BGRA

  //todo set sliders from settings file
  //todo can use ssExtra for default setting
  penWidth := 10;
  PageControl1.Align := alClient;
  ImageWidth.Canvas.CreatePen();
  ImageTransparency.Canvas.CreatePen();
  ImageRadius.Canvas.CreatePen();
  hcslider.HCSlider(ImageWidth, [ssLeft], 25, -1, True);
  hcslider.HCSlider(ImageRadius, [ssLeft], 40, -1, True);
  hcslider.HCSlider(ImageTransparency, [ssLeft], 255, -1, True);
end;
{$REGION 'DARK THEME'}

procedure ApplyTheme(Form: TForm);
var
  i, j: integer;
  tb: TToolBar;
  tbt: TToolButton;
  mm: TMainMenu;
  mi: TMenuItem;
begin
  //todo FormMain ismi yerine sınıf ismi gelecek ve bu proc başka bir dosyaya taşınacak
  if IsDarkTheme then
  begin
    mm := TMainMenu.Create(nil);
    mi := TMenuItem.Create(nil);
    tb := TToolBar.Create(nil);
    tbt := TToolButton.Create(nil);
    Form.Color := $00202020;
    Form.Font.Color := $C0C0C0;
    FormMain.HexaColorPicker1.Color := Form.Color;
    for i := 0 to FormMain.FlowPanel1.ControlCount - 1 do
    begin
      if FormMain.FlowPanel1.Controls[i] is TWinControl then
      begin
        FormMain.FlowPanel1.Controls[i].Color := Form.Color;
        FormMain.FlowPanel1.Controls[i].Font.Color := Form.Font.Color;
      end;
    end;
    for i := 0 to FormMain.AnchorDockPanel1.ControlCount - 1 do
    begin
      if FormMain.AnchorDockPanel1.Controls[i] is TWinControl then
      begin
        FormMain.AnchorDockPanel1.Controls[i].Color := Form.Color;
        FormMain.AnchorDockPanel1.Controls[i].Font.Color := Form.Font.Color;
      end;
    end;
    for i := 0 to FormMain.Panel2.ControlCount - 1 do
    begin
      if FormMain.Panel2.Controls[i] is TWinControl then
      begin
        FormMain.Panel2.Controls[i].Color := Form.Color;
        FormMain.Panel2.Controls[i].Font.Color := Form.Font.Color;
      end;
    end;
    for i := 0 to Form.ControlCount - 1 do
    begin
      if Form.Controls[i] is TWinControl then
      begin
        (Form.Controls[i] as TWinControl).Color := Form.Color;
        (Form.Controls[i] as TWinControl).Font.Color := Form.Font.Color;
        if Form.Controls[i] is TToolBar then
          tb := Form.Controls[i] as TToolBar;
        begin
          for j := 0 to tb.ControlCount - 1 do
          begin
            tbt := tb.Controls[j] as TToolButton;
            tbt.Color := Form.Color;
            tbt.Font.Color := Form.Color;
          end;
        end;
      end;
    end;
  end
  else
  begin

    Form.Color := clForm;
    Form.Font.Color := clBtnText;
  end;
end;

{$IFDEF MSWINDOWS}
function IsDarkTheme: boolean;
const
  Key = 'Software\Microsoft\Windows\CurrentVersion\Themes\Personalize';
var
  Reg: TRegistry;
  Value: integer;
begin
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly(Key) then
    begin
      if Reg.ValueExists('AppsUseLightTheme') then
      begin
        Value := Reg.ReadInteger('AppsUseLightTheme');
        Result := (Value = 0); // 0 = Dark Mode, 1 = Light Mode
      end
      else
        Result := False; // Default to dark if the key doesn't exist
    end
    else
      Result := False; // Default to dark if the key doesn't exist
  finally
    Reg.Free;
  end;
end;
{$ENDIF}
{$IFDEF UNIX}
function IsDarkTheme: boolean;
begin
Result:=False; // todo implement
end;

{$ENDIF}



{$ENDREGION}

procedure TFormMain.ToolButtonFillClick(Sender: TObject);
begin
  hctool := TOOL_FILL;
end;

procedure TFormMain.ToolButtonNewClick(Sender: TObject);
var
  DialogForm: TFormNewImage; // Declare a variable for the new form
  NewDoc: TFormDocument;
  NewPage: TTabSheet;
begin
  // Create an instance of TMyForm
  DialogForm := TFormNewImage.Create(nil); // nil means it has no owner
  try
    DialogForm.ShowModal; // Show as a modal form
    // Alternatively, use MyForm.Show for a non-modal form
  finally
    if DialogForm.ModalResult = mrOk then
    begin
      NewPage := PageControl1.AddTabSheet;
      NewDoc := TFormDocument.Create(Application);
      NewDoc.ImageWidth := DialogForm.NewImageWidth;
      NewDoc.ImageHeight := DialogForm.NewImageHeight;
      NewDoc.Caption := 'NewImage';
      NewDoc.EmptyImage := True;
      NewDoc.Parent := NewPage;
      NewDoc.Align:=alClient; //Necessary for Linux
      NewDoc.WindowState := wsMaximized;
      Inc(imageCounter); // Increment last image number
      NewPage.Caption := 'Image' + imageCounter.ToString;
      NewDoc.Tag := imageCounter;
      NewDoc.fileName := NewPage.Caption; // Set caption as Filename
      NewDoc.Show();
      NewPage.Invalidate;
      PageControl1.ActivePage := NewPage;

    end;

    DialogForm.Free; // Free the form after it's closed to prevent memory leaks

  end;
end;



{
 procedure NewBGRAImage(_width: integer; _height: integer) ;
 var
   Bitmap: TBGRABitmap;
 begin
        Bitmap := TBGRABitmap.Create(_width,_height,clWhite);
       // Bitmap.NewBitmap(_width,_height);
        FormMain.BGImage1.Bitmap:= Bitmap;
        Bitmap.free;
 end;
}

procedure TFormMain.ToolButtonBlurClick(Sender: TObject);
begin
  // ApplyBlurEffect(Image1);
end;

procedure TFormMain.HexaColorPicker1Change(Sender: TObject);
begin
  foreColor := (HexaColorPicker1.SelectedColor);
end;



procedure TFormMain.BCMaterialProgressBarMarquee1Click(Sender: TObject);
begin

end;

procedure TFormMain .BCToolBar1Redraw (Sender :TObject ; Bitmap :TBGRABitmap );
begin
  // This code paints toolbar background
   Bitmap.Fill(clBtnFace);
end;

procedure TFormMain.BCTrackbarUpdown1Change(Sender: TObject; AByUser: boolean);
begin

end;

procedure TFormMain.CheckBoxWebSafeChange(Sender: TObject);
begin
  // ColorPickerHS1.WebSafe := CheckBoxWebSafe.Checked;
end;




procedure TFormMain.ImageColorBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  // foreColor := HcColorFrame1.ImageColorBox.Canvas.Pixels[x, y];
end;

procedure TFormMain.Label1Click(Sender: TObject);
begin

end;

procedure TFormMain.MainPanelClick(Sender: TObject);
begin

end;

procedure TFormMain.MenuItemCanvasSizeClick(Sender: TObject);
var
  MyForm: TFormSetCanvasSize;
begin
  // Create an instance of TMyForm
  MyForm := TFormSetCanvasSize.Create(nil); // nil means it has no owner
  try
    MyForm.ShowModal; // Show as a modal form
    // Alternatively, use MyForm.Show for a non-modal form
  finally
    if MyForm.ModalResult = mrOk then
    begin

    end;

    MyForm.Free; // Free the form after it's closed to prevent memory leaks

  end;

end;




{$ENDREGION}
procedure TFormMain.ImageWidthMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin
  //Set property sliders
  //All sliders connected to this event
  hcslider.HCSlider(Sender, Shift, X, Y);
end;

procedure TFormMain.MenuItemExitClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMain.PageControl1Change(Sender: TObject);
var
  ActiveDoc: TFormDocument;
  i: integer;
  ChildControl: TControl;
begin
  for i := 0 to PageControl1.ActivePage.ControlCount - 1 do
  begin
    ChildControl := PageControl1.ActivePage.Controls[i];
    // Burada ChildControl'e istediğiniz işlemi uygulayabilirsiniz
    if ChildControl is TFormDocument then
      FormMain.Caption := TFormDocument(ChildControl).FileName;
  end;

end;

procedure TFormMain .PageControl1CloseTabClicked (Sender :TObject );
begin
  //Linux only
    PageControl1.ActivePage.Free;
end;

procedure TFormMain.PageControl1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin

end;

//Use to active image page
function findDocument(docTag: integer): TFormDocument;
var
  ActiveDoc: TFormDocument;
  i: integer;
  ChildControl: TControl;
begin
  Result := nil;
  for i := 0 to FormMain.PageControl1.ActivePage.ControlCount - 1 do
  begin
    ChildControl := FormMain.PageControl1.ActivePage.Controls[i];
    // Burada ChildControl'e istediğiniz işlemi uygulayabilirsiniz
    if ChildControl is TFormDocument then
    begin
      Result := TFormDocument(ChildControl);
    end;
  end;

end;

procedure TFormMain.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TFormMain.Timer1Timer(Sender: TObject);
begin

end;

procedure TFormMain.TimerStatusTimer(Sender: TObject);
begin
  if status then
  begin
    StatusBar1.Panels[0].Text := statusText;
    status := False;
    TimerStatus.Enabled := True;
  end;
end;



end.

unit unitFormMain;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF HASAMIGA}
 athreads, hcamigaeffects,
  {$Else}
  BGRAGraphicControl, hceffects,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,Registry,
  {$ENDIF}
  Classes, interfaces, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls, ComCtrls, ExtDlgs, AnchorDockPanel, crt,
  unitFormNewImage, BCFluentSlider, BCToolBar,
  BGRAFlashProgressBar, BGRAImageList, BGRAImageManipulation, BGRACustomDrawn,
  BGRAShape, BCTrackbarUpdown, BCMaterialProgressBarMarquee,
  BCFluentProgressRing, BCLeaLCDDisplay, BCLeaLED, HexaColorPicker, hctypes,
  hcGlobals, animation, hcslider // Sliders
  , line, pen, circle, fill
  , unitCanvasSizeDialog
  , unitformdocument
  , LResources, BGRABitmap, BGRABitmapTypes  //BGRA Bitmap
  , Types;

type

  { TFormMain }

  TFormMain = class(TForm)
    AnchorDockPanel1: TAnchorDockPanel;
    BCLeaLED1: TBCLeaLED;
    BCLeaLED2: TBCLeaLED;
    BCLeaLED3: TBCLeaLED;
    BGRAGraphicControl1: TBGRAGraphicControl;
    CalculatorDialog1: TCalculatorDialog;
    CheckBoxWebSafe: TCheckBox;
    ColorDialog1: TColorDialog;
    EditWidth: TEdit;
    FindDialog1: TFindDialog;
    FlowPanel1: TPanel;
    FontDialog1: TFontDialog;
    HexaColorPicker1: THexaColorPicker;

    ImageList1: TImageList;
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
    StatusBar1:TStatusBar;
    TimerStartup: TTimer;
    TimerStatus:TTimer;
    ToolBarStandard: TToolBar;
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
    procedure ScrollBox1Click(Sender: TObject);
    procedure TimerStatusTimer(Sender:TObject);
    procedure ToolButtonFillClick(Sender: TObject);
    procedure ToolButtonNewClick(Sender: TObject);
    procedure ToolButtonBlurClick(Sender: TObject);
    procedure ToolButtonEllipseClick(Sender: TObject);
    procedure ToolButtonOpenClick(Sender: TObject);
    procedure ToolButtonPenClick(Sender: TObject);
    procedure ToolButtonLineClick(Sender: TObject);
    procedure ToolButtonPixelateClick(Sender: TObject);

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


implementation

{$R *.lfm}

{ TFormMain }



procedure TFormMain.ToolButtonEllipseClick(Sender: TObject);
begin
  hctool := TOOL_ELLIPSE1;
end;

procedure TFormMain.ToolButtonOpenClick(Sender: TObject);
var
  myForm: TFormDocument;
begin

  if OpenPictureDialog1.Execute then
  begin
    myForm := TFormDocument.Create(Self);
    myForm.fileName := OpenPictureDialog1.FileName;

    myForm.Show;
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
      //NewDoc.WindowState:= wsMaximized;
      NewPage.Caption:= 'Image' + PageControl1.PageCount.ToString;
      NewDoc.fileName:= NewPage.Caption; // Dosya adı olarak
      NewDoc.Show();
      PageControl1.ActivePage:=NewPage;

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

procedure TFormMain.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TFormMain.TimerStatusTimer(Sender:TObject);
begin
if status then
begin
StatusBar1.Panels[0].Text :=statusText;
status:=false;
TimerStatus.Enabled:=true;
end
end;




end.

unit hccolorbox2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, interfaces, SysUtils, Forms, Controls, ExtCtrls, Graphics;

type
  TColorArray = array[0..15] of TColor;
  TColorArray64 = array[0..63] of TColor;
  { THcColorFrame }

  THcColorFrame = class(TFrame)
    ImageColorBox: TImage;
    Panel1: TPanel;
    Timer1: TTimer;
    procedure ImageColorBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageColorBoxPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);


  private
    XFCount: integer;
    YFCount: integer;
    FWidth: integer; // Width of the one color box
    FHeight: integer; // Height of the one color box
    function GetXCount: integer;
    procedure SetXCount(Value: integer);
    function GetYCount: integer;
    procedure SetYCount(Value: integer);
    function GetWidth: integer;
    procedure SetWidth(Value: integer);
    function GetHeight: integer;
    procedure SetHeight(Value: integer);


    procedure FillColors(Sender: TImage);
  public

    property XCount: integer read GetXCount write SetXCount;
    property YCount: integer read GetYCount write SetYCount;
    property BoxWidth: integer read GetWidth write SetWidth;
    property BoxHeight: integer read GetHeight write SetHeight;

    constructor Create(AOwner: TComponent); override;
  end;
 const
  BasicColors: TColorArray = (
    clBlack,        // Siyah
    clMaroon,       // Bordo
    clGreen,        // Yeşil
    clOlive,        // Zeytin Yeşili
    clNavy,         // Lacivert
    clPurple,       // Mor
    clTeal,         // Cam Göbeği
    clGray,         // Gri
    clSilver,       // Gümüş
    clRed,          // Kırmızı
    clLime,         // Limon Yeşili
    clYellow,       // Sarı
    clBlue,         // Mavi
    clFuchsia,      // Fuşya
    clAqua,         // Su Yeşili
    clWhite         // Beyaz
  );

  ExtColors: TColorArray64 = (
    $000000, // Black
    $800000, // Maroon
    $FF0000, // Red
    $FFA500, // Orange
    $FFFF00, // Yellow
    $808000, // Olive
    $008000, // Green
    $00FF00, // Lime
    $008080, // Teal
    $00FFFF, // Aqua
    $000080, // Navy
    $0000FF, // Blue
    $800080, // Purple
    $FF00FF, // Fuchsia
    $808080, // Gray
    $C0C0C0, // Silver
    $FFFFFF, // White
    $A52A2A, // Brown
    $DEB887, // Burlywood
    $5F9EA0, // CadetBlue
    $7FFF00, // Chartreuse
    $D2691E, // Chocolate
    $FF7F50, // Coral
    $6495ED, // CornflowerBlue
    $FFF8DC, // Cornsilk
    $DC143C, // Crimson
    $00FFFF, // Cyan
    $00008B, // DarkBlue
    $008B8B, // DarkCyan
    $B8860B, // DarkGoldenRod
    $A9A9A9, // DarkGray
    $006400, // DarkGreen
    $BDB76B, // DarkKhaki
    $8B008B, // DarkMagenta
    $556B2F, // DarkOliveGreen
    $FF8C00, // DarkOrange
    $9932CC, // DarkOrchid
    $8B0000, // DarkRed
    $E9967A, // DarkSalmon
    $8FBC8F, // DarkSeaGreen
    $483D8B, // DarkSlateBlue
    $2F4F4F, // DarkSlateGray
    $00CED1, // DarkTurquoise
    $9400D3, // DarkViolet
    $FF1493, // DeepPink
    $00BFFF, // DeepSkyBlue
    $696969, // DimGray
    $1E90FF, // DodgerBlue
    $B22222, // FireBrick
    $FFFAF0, // FloralWhite
    $228B22, // ForestGreen
    $FF00FF, // Magenta
    $DCDCDC, // Gainsboro
    $F8F8FF, // GhostWhite
    $FFD700, // Gold
    $DAA520, // GoldenRod
    $ADFF2F, // GreenYellow
    $F0FFF0, // HoneyDew
    $FF69B4, // HotPink
    $CD5C5C, // IndianRed
    $4B0082, // Indigo
    $FFFFF0, // Ivory
    $F0E68C,  // Khaki
    $E6E6FA  // Lavender

    );

implementation

{$R *.lfm}

constructor THcColorFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);  // Ataları çağırmak için
  ImageColorBox.Width := 300;
  // İlk seferde resmi büyük yapıyorum. Bir kere kullanıldıktan sonra büyümüyor.
  ImageColorBox.Height := 600;
  ImageColorBox.Canvas.Clear;
  ImageColorBox.Visible := False;
  XFCount := 8; // xCount için varsayılan değer olarak 4 ayarlanır
  YFCount := 8;
  BoxWidth := 20;
  BoxHeight := 20;
  Randomize;   // Rastgele sayı üretimini başlat
end;

procedure THcColorFrame.Timer1Timer(Sender: TObject);
begin
  FillColors(ImageColorBox);
end;

procedure THcColorFrame.ImageColorBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure THcColorFrame.ImageColorBoxPaint(Sender: TObject);
begin

end;

{##### PROPERTIES #####}
function THcColorFrame.GetXCount: integer;
begin
  Result := XFCount;
end;

procedure THcColorFrame.SetXCount(Value: integer);
begin
  if Value >= 0 then // Değerin negatif olmaması gibi bir kontrol ekleyebilirsiniz
    XFCount := Value;
end;

function THcColorFrame.GetYCount: integer;
begin
  Result := YFCount;
end;

procedure THcColorFrame.SetYCount(Value: integer);
begin
  if Value >= 0 then // Değerin negatif olmaması gibi bir kontrol ekleyebilirsiniz
    YFCount := Value;
end;

procedure THcColorFrame.SetWidth(Value: integer);
begin
  if Value >= 0 then // Değerin negatif olmaması gibi bir kontrol ekleyebilirsiniz
    FWidth := Value;
end;

function THcColorFrame.GetWidth: integer;
begin
  Result := FWidth;
end;

procedure THcColorFrame.SetHeight(Value: integer);
begin
  if Value >= 0 then // Değerin negatif olmaması gibi bir kontrol ekleyebilirsiniz
    FHeight := Value;
end;

function THcColorFrame.GetHeight: integer;
begin
  Result := FHeight;
end;
{##### ///END OF PROPERTIES ##### }


function GenerateRandomColor: TColor;
begin
  // Rastgele kırmızı, yeşil ve mavi bileşenleri oluştur
  Result := RGBToColor(Random(255), Random(255), Random(255));
end;

procedure THcColorFrame.FillColors(Sender: TImage);
var
  x, y, w, h, rr, rg, rb,counter: integer;
begin
  w := FWidth;
  h := FHeight;
  rr := Random(127);
  rg := Random(127);
  rb := Random(127);
  counter:=0;
  Sender.Parent.Width := (w) * XFCount;
  Sender.Parent.Height := (h) * YFCount;
  Sender.Width := w * XFCount;
  Sender.Height := (h) * YFCount;
  //Sender.Canvas.Clear;
  ImageColorBox.Visible := True; //Başlangıçta gizlemiştim

  with Sender.Canvas do
  begin
    for x := 0 to XFCount - 1 do
    begin
      for y := 0 to YFCount - 1 do
      begin
        Pen.Color := clBlack;
        Brush.Color:=BasicColors[counter] ;
        Inc(counter);
        // Brush.Color := RGBToColor(round(x * (255 - rr) / XFCount), round(y * (255 - rg) / YFCount), rb);
        //Brush.Color := GenerateRandomColor();
        Rectangle(x * w, y * h, (x * w) + w, (y * h) + h);
      end;
    end;

    Sender.Refresh;

  end;
end;

end.

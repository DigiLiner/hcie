unit ColorBox;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls, Graphics;

type

  { TFrame1 }

  TFrame1 = class(TFrame)
    Image1: TImage;
    Timer1: TTimer;

    procedure Timer1Timer(Sender: TObject);

  private
    FCount: integer;
    function GetCount: integer;
    procedure SetCount(Value: integer);
    procedure FillColors(Sender: TImage);
  public
    constructor Create(AOwner: TComponent); override;
    // AOwner ekledim ve override ekledim
    property xCount: integer read GetCount write SetCount;
  end;

procedure Register;

implementation

{$R *.lfm}

{ TFrame1 }

constructor TFrame1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);  // Ataları çağırmak için
  Image1.Width := 300;  // İlk seferde resmi büyük yapıyorum. Bir kere kullanıldıktan sonra büyümüyor.
  Image1.Height := 600;
  Image1.Canvas.Clear;
  Image1.Visible := False;
  FCount := 4; // xCount için varsayılan değer olarak 4 ayarlanır
  Randomize;   // Rastgele sayı üretimini başlat
end;

function TFrame1.GetCount: integer;
begin
  Result := FCount;
end;

procedure TFrame1.SetCount(Value: integer);
begin
  if Value >= 0 then // Değerin negatif olmaması gibi bir kontrol ekleyebilirsiniz
    FCount := Value;
end;

function GenerateRandomColor: TColor;
begin
  // Rastgele kırmızı, yeşil ve mavi bileşenleri oluştur
  Result := RGBToColor(Random(255), Random(255), Random(255));
end;

procedure TFrame1.FillColors(Sender: TImage);
var
  x, y, w: integer;
begin
  w := 20;
  Sender.Parent.Width := w * FCount;
  Sender.Parent.Height := (w) * 8;
  Sender.Width := w * FCount;
  Sender.Height := (w) * 8;
  Sender.Canvas.Clear;
  Image1.Visible := True; //Başlangıçta gizlemiştim

  with Sender.Canvas do
  begin
    for x := 0 to FCount - 1 do
    begin
      for y := 0 to 7 do
      begin
        Pen.Color := clBlue;
        Brush.Color := GenerateRandomColor();
        Rectangle(x * w, y * w, (x * w) + w, (y * w) + w);
      end;
    end;

    Sender.Refresh;
  end;
end;

procedure TFrame1.Timer1Timer(Sender: TObject);
begin
  Randomize();
  FillColors(Image1);
end;

procedure Register;
begin
  RegisterComponents('Additional', [TFrame1]);
end;

end.

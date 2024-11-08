unit hceffects;

{$mode ObjFPC}{$H+}

interface

uses
  {$IFDEF UNIX}
 cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
 athreads,
  {$ENDIF}

  BGRABitmap, BGRABitmapTypes,
  Classes, SysUtils, Forms, ExtCtrls, Controls, Graphics, Math, Dialogs, LCLIntf;

function ApplyBlurEffect(Image: TImage): TImage;
function Pixelate(_image: TImage; BlockSize: integer): TImage;
function EmbossHighlight(_image: TImage; Selection: boolean): TImage;
function GetRed(Color: TColor): byte;
function GetGreen(Color: TColor): byte;
function GetBlue(Color: TColor): byte;
procedure ErodeBorderEffect(Image: TImage);

implementation

function GetRed(Color: TColor): byte;
begin
  Result := (Color and $FF);
end;

function GetGreen(Color: TColor): byte;
begin
  Result := (Color shr 8) and $FF;
end;

function GetBlue(Color: TColor): byte;
begin
  Result := (Color shr 16) and $FF;
end;



function ApplyBlurEffect(Image: TImage): TImage;
var
  Bitmap: TBGRABitmap;
begin
  Bitmap := TBGRABitmap.Create(Image.Picture.Bitmap);
  try
    Bitmap := Bitmap.FilterBlurRadial(5, 5, TRadialBlurType.rbBox);
    // Blur radius, you can adjust this value
    //Image.Picture.Bitmap.Assign(Bitmap);
    Image.Canvas.Draw(0, 0, Bitmap.Bitmap);
  finally
    Result := Image;
    Bitmap.Free;
  end;
end;


function Pixelate(_image: TImage; BlockSize: integer): TImage;
var
  Bitmap: TBGRABitmap;
begin
  Bitmap := TBGRABitmap.Create(_image.Picture.Bitmap);
  try
    Bitmap := Bitmap.FilterPixelate(5, False, TResampleFilter.rfLinear, False);

    //Image.Picture.Bitmap.Assign(Bitmap);
    _image.Canvas.Draw(0, 0, Bitmap.Bitmap);
  finally
    Result := _image;
    Bitmap.Free;
  end;
end;


function EmbossHighlight(_image: TImage; Selection: boolean): TImage;
var
  Bitmap: TBGRABitmap;
begin
  Bitmap := TBGRABitmap.Create(_image.Picture.Bitmap);
  try
    Bitmap := Bitmap.FilterEmbossHighlight(False, False);

    //Image.Picture.Bitmap.Assign(Bitmap);
    _image.Canvas.Draw(0, 0, Bitmap.Bitmap);
  finally
    Result := _image;
    Bitmap.Free;
  end;
end;
   function ErodeBorder(self:TImage ;size: Integer; R, G, B: Byte): Boolean;
var
  A_1, index, minValue: Integer;
begin
  Result := False;
  try
    minValue := Math.Min(Self.ClientWidth div 2, Self.ClientHeight div 2);
    size := Math.Min( minValue, size);  // Adjust this according to your logic
    for A_1 := 0 to Self.ClientHeight - 1 do
    begin
      // Your equivalent processing for "this.a(A_1, this.b);" should go here.
      for index := 0 to Self.ClientWidth - 1 do
      begin
        if not ((index > Random(size)) and (index < Self.ClientWidth - 1 - Random(size)) and
                (A_1 > Random(size)) and (A_1 < Self.ClientHeight - 1 - Random(size))) then
        begin
          Self.Canvas.Pixels[index, A_1] := RGB(R, G, B);
        end;
      end;
    end;
    // Your equivalent processing for "this.a(1, 1);" should go here.
    Result := True;
  except
    // Handle any exceptions here
  end;
end;

procedure ErodeBorderEffect(Image: TImage);
var
  x, y, Width, Height: integer;
  Bitmap: TBitmap;
  erodeColor: TColor;
  BorderWidth: integer;
  OriginalColor: TColor;
  R, G, B: byte;
  NewColor: TColor;
begin
   // Check if the image has been loaded
  if Image.Picture.Bitmap=nil then
    Exit;
  BorderWidth  :=20;
  // Loop through each pixel in the border area
  for y := 0 to BorderWidth - 1 do
  begin
    for x := 0 to Image.Picture.Bitmap.Width - 1 do
    begin
      // Get the original color of the pixel at the top border
      OriginalColor := Image.Picture.Bitmap.Canvas.Pixels[x, y];

      // Decrease the brightness by halving the RGB components
      R := GetRValue(OriginalColor) div 2;
      G := GetGValue(OriginalColor) div 2;
      B := GetBValue(OriginalColor) div 2;

      // Create the new color
      NewColor := RGB(R, G, B);

      // Set the new color to the border pixels at the top
      Image.Picture.Bitmap.Canvas.Pixels[x, y] := NewColor;

      // Set the new color to the border pixels at the bottom
      Image.Picture.Bitmap.Canvas.Pixels[x, Image.Picture.Bitmap.Height - 1 - y] := NewColor;
    end;
  end;

  for x := 0 to BorderWidth - 1 do
  begin
    for y := 0 to Image.Picture.Bitmap.Height - 1 do
    begin
      // Get the original color of the pixel at the left border
      OriginalColor := Image.Picture.Bitmap.Canvas.Pixels[x, y];

      // Decrease the brightness by halving the RGB components
      R := GetRValue(OriginalColor) div 2;
      G := GetGValue(OriginalColor) div 2;
      B := GetBValue(OriginalColor) div 2;

      // Create the new color
      NewColor := RGB(R, G, B);

      // Set the new color to the border pixels on the left
      Image.Picture.Bitmap.Canvas.Pixels[x, y] := NewColor;

      // Set the new color to the border pixels on the right
      Image.Picture.Bitmap.Canvas.Pixels[Image.Picture.Bitmap.Width - 1 - x, y] := NewColor;
    end;
  end;
end;
end.

unit hcamigaeffects;

{$mode ObjFPC}{$H+}

interface

uses

 {$IFDEF HASAMIGA}
 athreads,
 {$ENDIF}

  Classes, SysUtils,Forms,ExtCtrls, Controls, Graphics, Dialogs, LCLIntf ;

procedure ApplyBlurEffect(Image: TImage);
function Pixelate(Image: TImage; BlockSize: Integer):TImage;
function GetRed(Color: TColor): Byte;
function GetGreen(Color: TColor): Byte;
function GetBlue(Color: TColor): Byte;

implementation

function GetRed(Color: TColor): Byte;
begin
  Result := (Color and $FF);
end;

function GetGreen(Color: TColor): Byte;
begin
  Result := (Color shr 8) and $FF;
end;

function GetBlue(Color: TColor): Byte;
begin
  Result := (Color shr 16) and $FF;
end;

 procedure ApplyBlurEffect(Image: TImage);
 var
   x, y, i, j: Integer;
   r, g, b: Integer;
   Bitmap: TBitmap;
   TempBitmap: TBitmap;
   PixelColor: TColor;
 begin
   Bitmap := TBitmap.Create;
   TempBitmap := TBitmap.Create;
   try
     Bitmap.Assign(Image.Picture.Bitmap);
     TempBitmap.Assign(Bitmap);

     for x := 1 to Bitmap.Width - 2 do
     begin
       for y := 1 to Bitmap.Height - 2 do
       begin
         r := 0;
         g := 0;
         b := 0;

         for i := -1 to 1 do
         begin
           for j := -1 to 1 do
           begin
             PixelColor := Bitmap.Canvas.Pixels[x + i, y + j];
             r := r + GetRValue(PixelColor);
             g := g + GetGValue(PixelColor);
             b := b + GetBValue(PixelColor);
           end;
         end;

         r := round(r / 9);
         g := round(g / 9);
         b := round(b / 9);

         TempBitmap.Canvas.Pixels[x, y] := RGB(r, g, b);
       end;
     end;
      Image.Canvas.Draw(0,0,TempBitmap);
   //  Image.Picture.Bitmap.Assign(TempBitmap);
   finally
     Bitmap.Free;
     TempBitmap.Free;
   end;
 end;

 function Pixelate(Image: TImage; BlockSize: Integer):TImage;
 var
   x, y, i, j: Integer;
   r, g, b: Integer;
   PixelCount: Integer;
   Color: TColor;
   Bitmap:TBitmap;
 begin
   Bitmap:=Image.Picture.Bitmap;
   for y := 0 to Bitmap.Height - 1 do
     for x := 0 to Bitmap.Width - 1 do
     begin
       r := 0;
       g := 0;
       b := 0;
       PixelCount := 0;

       for j := 0 to BlockSize - 1 do
         for i := 0 to BlockSize - 1 do
         begin
           if (x + i < Bitmap.Width) and (y + j < Bitmap.Height) then
           begin
             Color := Bitmap.Canvas.Pixels[x + i, y + j];
             r := r + GetRValue(Color);
             g := g + GetGValue(Color);
             b := b + GetBValue(Color);
             Inc(PixelCount);
           end;
         end;

       r := r div PixelCount;
       g := g div PixelCount;
       b := b div PixelCount;

       for j := 0 to BlockSize - 1 do
         for i := 0 to BlockSize - 1 do
         begin
           if (x + i < Bitmap.Width) and (y + j < Bitmap.Height) then
           begin
             Bitmap.Canvas.Pixels[x + i, y + j] := RGB(r, g, b);
           end;
         end;
     end;
     Image.Picture.Bitmap.Assign(Bitmap);
   Result:=Image;
   // Image.Canvas.Draw(0,0,Bitmap);
 end;

end.


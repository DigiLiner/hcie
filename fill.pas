unit fill;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, ExtCtrls, Controls, Graphics, hctypes, hcGlobals
  , Math
  //Graphics32   defined in Project options - Custom Options
  {$IFDEF GR32}  , GR32_L, GR32_Image    {$ENDIF}
  //BGRA Bitmap
  , LResources, BGRABitmap, BGRABitmapTypes
  , crt;

type
  TDirection = (North, East, South, West);

  TPixel = record
    x, y: integer;
  end;

var
  x1, y1, x2, y2, i: integer;
  _radius: single;
  cur, mark, mark2: TPixel;
  curDir, markDir, mark2Dir: TDirection;
  backtrack, findloop: boolean;


procedure hc_Fill(Image1, Image2: TImage; Button: TMouseButton;
  Shift: TShiftState; PX, PY: integer; mEvent: integer // 1:Down,2:Move:3:Up);
  );
procedure FloodFillHC(x, y: integer; fillColor, borderColor: TColor; img: Timage);
procedure FloodFillHC2(x, y: integer; fillColor, borderColor: TColor; img: TImage);
procedure FloodFillHC3(x, y: integer; fillColor, borderColor: TColor; img: TImage);
{$IFDEF GR32} procedure FloodFillHC4(x, y: integer; fillColor, borderColor: TColor; image: TImage);   {$ENDIF}
procedure FloodFillHC5(x, y: integer; fillColor, borderColor: TColor; img: TImage);

implementation


procedure hc_Fill(image1, Image2: TImage; Button: TMouseButton;
  Shift: TShiftState; PX, PY: integer; mEvent: integer // 1:Down,2:Move:3:Up);
  );
var
  pointColor: TColor;
begin
  if (Button = mbLeft) and (mEvent = hMouseDown) then    //DOWN
  begin
    Image1.Canvas.Draw(0, 0, Image2.Picture.Graphic);
    pointColor := image1.Picture.Bitmap.Canvas.Pixels[PX, PY];
    image1.Picture.Bitmap.Canvas.Brush.Color := foreColor;
    image1.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
    {$IFDEF MSWINDOWS}
    //Win32 Api
    //Image1.Picture.Bitmap.Canvas.FloodFill(px, py, pointcolor, TFillStyle.fsSurface);
    FloodFillHC5(px, py, foreColor, image1.Picture.Bitmap.Canvas.Pixels[px,
      py], image1);
    {$ENDIF}
    {$IFDEF UNIX}
      FloodFillHC5( px,py,foreColor,image1.Picture.Bitmap.Canvas.Pixels[px, py],image1);
    {$ENDIF}
    Image1.Refresh;

  end
  else if (Button = mbLeft) and (mEvent = hMouseMove) then    //MOVE
  begin

  end

  else if (Button = mbLeft) and (mEvent = hMouseUp) then   //UP
  begin
    Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);
  end;

end;

procedure FloodFillHC5(x, y: integer; fillColor, borderColor: TColor; img: TImage);
var
  bmp1: TBGRABitmap;
  Pixel: TBGRAPixel;
begin
  Pixel.FromColor(fillColor, 255);

  bmp1 := TBGRABitmap.Create(img.Picture.Bitmap);
  // bmp.FillRect(20, 20, 100, 40, BGRA(255, 192, 0), dmSet);

  bmp1.FloodFill(X, Y, pixel, TFloodfillMode.fmSet);
  bmp1.Draw(img.Canvas, 0, 0, True);
  bmp1.Free;
end;

procedure FloodFillHC(x, y: integer; fillColor, borderColor: TColor; img: TImage);
begin
  // Boundary check to ensure (x, y) is within the image dimensions
  if (x < 0) or (x >= img.Picture.Bitmap.Width) or (y < 0) or
    (y >= img.Picture.Bitmap.Height) then
    Exit;

  // If the pixel is the border color or already the fill color, do nothing
  if (img.Picture.Bitmap.Canvas.Pixels[x, y] <> borderColor) or
    (img.Picture.Bitmap.Canvas.Pixels[x, y] = fillColor) then
    Exit;
  // img.refresh;
  // Set the current pixel to the fill color
  img.Picture.Bitmap.Canvas.Pixels[x, y] := fillColor;

  // Recursively fill adjacent pixels
  FloodFillHC(x + 1, y, fillColor, borderColor, img);
  FloodFillHC(x - 1, y, fillColor, borderColor, img);
  FloodFillHC(x, y + 1, fillColor, borderColor, img);
  FloodFillHC(x, y - 1, fillColor, borderColor, img);

end;

procedure FloodFillHC2(x, y: integer; fillColor, borderColor: TColor; img: TImage);
var
  Stack: array of TPoint;
  Current: TPoint;
  Width, Height: integer;
  Index: integer;
begin
  // Get image dimensions
  Width := img.Picture.Bitmap.Width;
  Height := img.Picture.Bitmap.Height;

  // Boundary check to ensure the starting point is within the image dimensions
  if (x < 0) or (x >= Width) or (y < 0) or (y >= Height) then
    Exit;

  // If the starting pixel is the border color or already the fill color, do nothing
  if (img.Picture.Bitmap.Canvas.Pixels[x, y] <> borderColor) or
    (img.Picture.Bitmap.Canvas.Pixels[x, y] = fillColor) then
    Exit;

  // Initialize stack with the starting point
  SetLength(Stack, 1);
  Stack[0] := Point(x, y);

  // Loop while there are points to process in the stack
  while Length(Stack) > 0 do
  begin
    // Pop the top point from the stack
    Index := High(Stack);
    Current := Stack[Index];
    SetLength(Stack, Index); // Remove the current point from the stack

    // Check if the current point is within bounds and has the correct color
    if (Current.X < 0) or (Current.X >= Width) or (Current.Y < 0) or
      (Current.Y >= Height) or
      (img.Picture.Bitmap.Canvas.Pixels[Current.X, Current.Y] <> borderColor) or
      (img.Picture.Bitmap.Canvas.Pixels[Current.X, Current.Y] = fillColor) then
      Continue;

    // Set the current pixel to the fill color
    img.Picture.Bitmap.Canvas.Pixels[Current.X, Current.Y] := fillColor;

    // Push neighboring points onto the stack
    SetLength(Stack, Length(Stack) + 4);
    Stack[High(Stack) - 3] := Point(Current.X + 1, Current.Y);
    Stack[High(Stack) - 2] := Point(Current.X - 1, Current.Y);
    Stack[High(Stack) - 1] := Point(Current.X, Current.Y + 1);
    Stack[High(Stack)] := Point(Current.X, Current.Y - 1);
  end;
end;

procedure FloodFillHC3(x, y: integer; fillColor, borderColor: TColor; img: TImage);
var
  Queue: array of TPoint;
  Current: TPoint;
  Width, Height: integer;
  Head, Tail, Max, updateCount: integer;
begin
  // Get image dimensions

  Width := img.Picture.Bitmap.Width;
  Height := img.Picture.Bitmap.Height;

  // Boundary check to ensure the starting point is within the image dimensions
  if (x < 0) or (x >= Width) or (y < 0) or (y >= Height) then
    Exit;

  // If the starting pixel is the border color or already the fill color, do nothing
  if (img.Picture.Bitmap.Canvas.Pixels[x, y] = fillColor) then
    Exit;

  // Initialize queue with the starting point
  Max := Width * Height;
  SetLength(Queue, Max * 5);
  Head := 0;
  Tail := 1;
  updateCount := 0;
  Queue[Head] := Point(x, y);

  // Loop while there are points to process in the queue
  while (Head < Tail) do
  begin
    // Dequeue the front point
    Current := Queue[Head];
    Inc(Head);


    // Check if the current point is within bounds and has the correct color
    if (Current.X < 0) or (Current.X >= Width) or (Current.Y < 0) or
      (Current.Y >= Height) or
      (img.Picture.Bitmap.Canvas.Pixels[Current.X, Current.Y] <> borderColor) or
      (img.Picture.Bitmap.Canvas.Pixels[Current.X, Current.Y] = fillColor) then
    begin

      Continue;
    end;

    // Set the current pixel to the fill color
    img.Picture.Bitmap.Canvas.Pixels[Current.X, Current.Y] := fillColor;
    Inc(updateCount);
    if (updateCount >= 1000) then
    begin
      img.Refresh;
      updateCount := 0;
    end;
    // Enqueue neighboring points
    Queue[Tail] := Point(Current.X + 1, Current.Y);
    Inc(Tail);
    Queue[Tail] := Point(Current.X - 1, Current.Y);
    Inc(Tail);
    Queue[Tail] := Point(Current.X, Current.Y + 1);
    Inc(Tail);
    Queue[Tail] := Point(Current.X, Current.Y - 1);
    Inc(Tail);

  end;
end;


{$IFDEF GR32}
procedure FloodFillHC4(x, y: integer; fillColor, borderColor: TColor; image: TImage);
//Buggy don't use this
var
  Queue: array of TPoint;
  Current: TPoint;
  _Width, _Height: integer;
  Head, Tail, Max: integer;
  img: TImage32;
begin
  // Create an instance of TImage32
  img := TImage32.Create(nil);
  // Ensure the TImage32 has a valid Bitmap
  img.Bitmap.SetSize(image.Picture.Bitmap.Width, image.Picture.Bitmap.Height);

  // Copy the TImage bitmap to TImage32
  // img.Bitmap.Assign(image.Picture.Bitmap);


  // Get image dimensions


  img.Bitmap.Canvas.Draw(x, y, image.Picture.bitmap);
  _Width := image.Picture.Bitmap.Width;
  _Height := image.Picture.Bitmap.Height;


  // Boundary check to ensure the starting point is within the image dimensions
  if (x < 0) or (x >= _Width) or (y < 0) or (y >= _Height) then
    Exit;

  // If the starting pixel is the border color or already the fill color, do nothing
  //if (img.Picture.Bitmap.Canvas.Pixels[x, y] = fillColor) then
  //  Exit;
  if (img.Bitmap.Pixel[x, y] = fillColor) then
    Exit;
  // Initialize queue with the starting point
  Max := _Width * _Height;
  SetLength(Queue, Max * 5);
  Head := 0;
  Tail := 1;
  Queue[Head] := Point(x, y);

  // Loop while there are points to process in the queue
  while (Head < Tail) do
  begin
    // Dequeue the front point
    Current := Queue[Head];
    Inc(Head);


    // Check if the current point is within bounds and has the correct color
    if (Current.X < 0) or (Current.X >= _Width) or (Current.Y < 0) or
      (Current.Y >= _Height) or (img.Bitmap.Pixel[Current.X, Current.Y] <>
      borderColor) or (img.Bitmap.Pixel[Current.X, Current.Y] = fillColor) then
    begin

      Continue;
    end;

    // Set the current pixel to the fill color
    img.Bitmap.Pixel[Current.X, Current.Y] := fillColor;

    // Enqueue neighboring points
    Queue[Tail] := Point(Current.X + 4, Current.Y);
    Inc(Tail);
    Queue[Tail] := Point(Current.X - 4, Current.Y);
    Inc(Tail);
    Queue[Tail] := Point(Current.X, Current.Y + 4);
    Inc(Tail);
    Queue[Tail] := Point(Current.X, Current.Y - 4);
    Inc(Tail);

  end;

  //image.Picture.Bitmap.Canvas.Draw(0,0,);
  image.Picture.Bitmap.Assign(img.Bitmap);

  img.Free;
end;
{$ENDIF}

end.

unit circle;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, ExtCtrls, Controls, Graphics, hctypes, hcGlobals,
  Math;

var
  x1, y1, x2, y2, i: integer;
  _radius: single;

procedure hc_ellipse1(Image1, Image2: TImage;
  Shift: TShiftState; PX, PY: integer
  );

implementation


procedure hc_ellipse1(image1, Image2: TImage;
  Shift: TShiftState; PX, PY: integer
  );
begin
  if (hMouseButton = hmbLeft) and (hMouseEvent = hMouseDown) then    //DOWN
  begin
    Image2.Picture.Bitmap.Canvas.Draw(0, 0, Image1.Picture.Graphic);
    x1 := px;
    y1 := py;
    _radius := 0;
    oldx := px;
    oldy := py;
      image1.Picture.Bitmap.Canvas.Brush.Color := foreColor;
    image1.Picture.Bitmap.Canvas.Brush.Style := bsClear;
  end
  else if (hMouseButton = hmbLeft) and (hMouseEvent = hMouseMove) then    //MOVE
  begin
    Image1.Picture.Bitmap.Canvas.Draw(0, 0, Image2.Picture.Graphic);
     image1.Picture.Bitmap.Canvas.Ellipse(oldX, oldy, px, py);

    {          // Manual Circle
   Image1.canvas.Draw(0, 0, Image2.picture.bitmap);
   _radius := Sqrt(Sqr(PX - oldx) + Sqr(PY - oldy));
    for i := 0 to 360 do
    begin
     // if (i mod 10) = 1 then
      if true then
      begin
        x2 := x1;
        y2 := y1;
        x1 := Round(_radius * Cos(DegToRad(i))) + oldx; // Calculate X
        y1 := Round(_radius * Sin(DegToRad(i))) + oldy; // Calculate Y

        if (((x1>=0) and (x1<=image1.Picture.Bitmap.Width)) and
        ((x2>=0) and (x2<= image1.Picture.Bitmap.Width)) and
        ((y1>=0) and (y1<= image1.Picture.Bitmap.Height)) and
         ((y2>=0) and (y2<= image1.Picture.Bitmap.Height )))
        then
        begin

            Image1.canvas.line(x1, y1, x2, y2);
        end;
        }
  end

  else if (hMouseButton = hmbLeft) and (hMouseEvent = hMouseUp) then   //UP
  begin

  end;

end;

end.

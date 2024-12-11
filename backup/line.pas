unit line;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, ExtCtrls, Controls, Graphics, hctypes, hcGlobals, pen;

procedure hc_line(Image1, Image2: TImage; Shift: TShiftState; PX, PY: integer);

implementation

procedure hc_line(Image1, Image2: TImage; Shift: TShiftState;
  PX, PY: integer // 1:Down,2:Move:3:Up);
  );
begin
  //DOWN
  if (hMouseButton = hmbLeft) and (hMouseEvent = hMouseDown) then
  begin
    Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);

  end
  //MOVE
  else if (hMouseButton = hmbLeft) and (hMouseEvent = hMouseMove) then
  begin

    Image1.Canvas.Draw(0, 0, Image2.Picture.Graphic);

    // Image1.Bitmap.Line(oldX, oldy, px, py,foreColor);

    Image1.Canvas.Line(oldX, oldy, px, py);

  end
  //UP
  else if (hMouseButton = hmbLeft) and (hMouseEvent = hMouseUp) then
  begin
    ewhewje;
  end;

end;

end.

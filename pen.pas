unit pen;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, ExtCtrls, Controls, Graphics, hctypes, hcGlobals;//HC12 , GR32,GR32_Image;

procedure hc_pen(Sender: TImage; Shift: TShiftState;
  PX, PY: integer // 1:Down,2:Move:3:Up);
  );

implementation


procedure hc_pen(Sender: TImage; Shift: TShiftState;
  PX, PY: integer // 1:Down,2:Move:3:Up);
  );
begin
//DOWN
  if (hMouseButton = hmbLeft) and (hMouseEvent = hMouseDown) then
  begin

  end
//MOVE
  else if (hMouseButton = hmbLeft) and (hMouseEvent = hMouseMove) then
  begin

  Sender.Canvas.Line(oldx, oldy, px, py);

    //Sender.bitmap.LineAS(oldx, oldy, px, py,foreColor);
    oldx := px;
    oldy := py;
  end
//UP
  else if (hMouseButton = hmbLeft) and (hMouseEvent = hMouseUp) then
  begin
    Sender.Canvas.Line(oldx, oldy, px, py);
  //  Sender.bitmap.LineA(oldX, oldy, px, py,foreColor);

  end;

end;

end.

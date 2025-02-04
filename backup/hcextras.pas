unit hcextras;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, ExtCtrls, Controls, Graphics, hcGlobals,hc;

procedure hc_line(Image1, Image2: TImage; Button: TMouseButton;
  Shift: TShiftState; PX, PY: integer; mEvent: integer // 1:Down,2:Move:3:Up);
  );

implementation

procedure hc_line(Image1, Image2: TImage; Button: TMouseButton;
  Shift: TShiftState; PX, PY: integer; mEvent: integer // 1:Down,2:Move:3:Up);
  );
begin

  if (mouseButton = mbLeft) and (mEvent = 1) then    //DOWN
  begin
    //Image2.Picture.Bitmap:=Image1.Picture.Bitmap;
    Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);
    // Copy Image1 to Image2
    //  Image2.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  end
  else if (mouseButton = mbLeft) and (mEvent = 2) then    //MOVE
  begin
    //Image1.Picture.Bitmap:=Image2.Picture.Bitmap;
    Image1.Canvas.Draw(0, 0, Image2.Picture.Graphic);
    Image1.Canvas.Pen.Color := clBlue;
    Image1.Canvas.Line(oldX, oldy, px, py);

  end
  else if (mouseButton = TMouseButton.mbLeft) and (mEvent = 3) then   //UP
  begin
    Image1.Canvas.Line(oldX, oldy, px, py);
    Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);

  end;

end;


end.

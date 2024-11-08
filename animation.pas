unit animation;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ExtCtrls,Graphics,crt,hcGlobals,Forms;
var

  //Anim
  ax: integer;
  ay: integer;
  countUP: boolean;

procedure doAnim(Image1:TImage);

implementation
 
procedure doAnim(Image1:TImage);


begin
  ax := -100;
  ay:=ax;
  countUP := True;
  repeat
    with Image1.Canvas do
    begin
     Image1.Picture.Bitmap.BeginUpdate();
      Clear;
      AntialiasingMode := amOff;
      Brush.Color := clRed;
      Pen.Color := clWhite;
      Pen.Width := 1;
      Brush.Color := clRed;
      Ellipse(ax + 195, ay + 117, ax + 205, ay + 128);
      Brush.Color := clBlue;
      Rectangle(ax + 192, ay + 130, ax + 208, ay + 160);
      Brush.Color := clGreen;
      Rectangle(ax + 187, ay + 130, ax + 191, ay + 162);
      Brush.Color := clyellow;
      Rectangle(ax + 209, ay + 130, ax + 213, ay + 162);
      Brush.Color := clMaroon;
      Rectangle(ax + 193, ay + 161, ax + 199, ay + 200);
      Brush.Color := clPurple;
      Rectangle(ax + 201, ay + 161, ax + 207, ay + 200);
      Delay(10);
      Application.ProcessMessages;


      if countUP then
      begin
        ax := ax + 1;
        if ax > 100 then
        begin
          countUP := False;
        end;
      end
      else
      begin
        ax := ax - 1;
        if ax < -100 then
        begin
          countUP := True;
        end;
      end;
      ay := ax;

       Image1.Picture.Bitmap.EndUpdate();
    end;
  until animrun = False;
end;

end.


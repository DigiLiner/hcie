unit hcslider;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, StdCtrls, ExtCtrls, Forms, Math, interfaces,
  Graphics, Dialogs, Menus,
  ComCtrls, ExtDlgs, hcGlobals;

procedure HCSlider(Sender: TObject; Shift: TShiftState; X, Y: integer;SetDefault:Boolean =false);

implementation

//Controls 3 sliders on the main form
procedure HCSlider(Sender: TObject; Shift: TShiftState; X, Y: integer;SetDefault:Boolean =false);
var
  Value: integer;
  max: integer;
  FontHeight: integer;
  _ImageGauge: TImage;
  _tx: integer;
  _ty: integer;
begin
  if ssLeft in Shift then
  begin
    _ImageGauge := Sender as TImage;
    case _imageGauge.tag of
      0: max := 50;                      //Pen Width
      1: max := 255;                     //Transparency
      2: max := 200                       //Radius
      else;
    end;
        if SetDefault= true then
        begin
         Value:=X
        end
        else
        begin
             Value := Trunc((X / _ImageGauge.Width) * Max);
    	     Value := min(Value, max)
        end



    try
      //Fill Background Color
      _ImageGauge.Canvas.Brush.Color := clBtnFace;
      _ImageGauge.Canvas.FillRect(Rect(0, 0, _ImageGauge.Width, _ImageGauge.Height));
      // Fill Gauge
      _ImageGauge.Canvas.Brush.Color := clBlue;
      _ImageGauge.Canvas.FillRect(Rect(0, 0, X, _ImageGauge.Height));
      //Set Text
      _ImageGauge.Canvas.Brush.Style := bsClear;
      _ImageGauge.Canvas.Font.Name := 'SansSerif';
      _ImageGauge.Canvas.Font.Size := 10;
      _ImageGauge.Canvas.Font.Style := [fsBold];
      _ImageGauge.Canvas.Font.Color := clDkGray;
      //Text Coords
      FontHeight := _ImageGauge.Canvas.TextHeight('A');
      // Measure the height of the letter 'A'
      _tx := Round(_ImageGauge.Width / 2);
      _ty := Round((_ImageGauge.Height - FontHeight) / 2) - 1;
      //Write Text Shadow

      _ImageGauge.Canvas.TextOut(_tx - 1, _ty - 1, IntToStr(Value));
      _ImageGauge.Canvas.TextOut(_tx + 1, _ty - 1, IntToStr(Value));
      _ImageGauge.Canvas.TextOut(_tx - 1, _ty + 1, IntToStr(Value));
      _ImageGauge.Canvas.TextOut(_tx + 1, _ty + 1, IntToStr(Value));
      // Write Text Inner Contrast
      _ImageGauge.Canvas.Font.Size := 9;
      _ImageGauge.Canvas.Font.Style := [];
      _ImageGauge.Canvas.Font.Color := clWhite;
      FontHeight := _ImageGauge.Canvas.TextHeight('A');
      // Measure the height of the letter 'A'
      _tx := Round(_ImageGauge.Width / 2);
      _ty := Round((_ImageGauge.Height - FontHeight) / 2) - 1;
      _ImageGauge.Canvas.TextOut(_tx, _ty, IntToStr(Value));
    finally
      case _imageGauge.tag of
        0: penWidth := Value;     //Pen Width
        1: ;                     //Transparency
        2:                       //Radius
        else;
      end;

    end;

  end;

end;

end.

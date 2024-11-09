unit hcGlobals;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, Graphics, hctypes;

var
  foreColor, backColor: TColor;
  hctool: TToolType;
  //todo bir ara bunları document içine alabilirim
  ScaleFactor: single;
  hMouseButton: hcMouseButton;
  hMouseEvent: integer;
  oldX: integer; //Mouse X old
  oldy: integer;
  hcShift: TShiftState;
  PX, PY: integer;

  penWidth: integer;
  //Status Bar text on MainForm
  statusText: string; // A text will be written
  status: boolean;// True when a text updated
  imageCounter: integer; //Image Number counter

const
  hMouseDown = 1281101;
  hMouseMove = 1281102;
  hMouseUp = 1281103;
  hMouseNone = 1281104;

function max(a, b: longint): longint;
function min(a, b: longint): longint;
procedure UpdateText(NewText: string);


// HC12 function Color32toColor (TColor32: TColor32): TColor;
implementation

procedure UpdateText(NewText: string);
begin
  StatusText := NewText;
  status := True;

end;


//Max for linux
function max(a, b: longint): longint;
begin
  if a > b then
    Result := a
  else
    Result := b;
end;

function min(a, b: longint): longint;
begin
  if a < b then
    Result := a
  else
    Result := b;
end;

//HC12
//TColor32  to TColor Conversion
{
function Color32toColor (TColor32: TColor32): TColor;
begin
result := RGBToColor(RedComponent(TColor32),
      GreenComponent(TColor32), BlueComponent(TColor32));
end;
}
end.

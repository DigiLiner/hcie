unit hcGlobals;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, Graphics, hctypes;

var
  oldX: integer; //Mouse X old
  oldy: integer;

  hcShift: TShiftState;
  PX, PY: integer;
  hMouseButton: hcMouseButton;
  hMouseEvent: integer;
  foreColor, backColor: TColor;
  hctool: TToolType;
  zoomFactor, ScaleFactor: single;
  animrun: boolean; // Çok gerekli değil test için
  penWidth: integer;
  //Ana form Status Bar yazıları
  statusText: string; // Ana formdaki status bara yazılacak yazı
  status:boolean ;// Text Güncellemesi var demektir
  imageCounter:integer ; // Açık pencerelerdeki resim numaraları

const
  hMouseDown = 1281101;
  hMouseMove = 1281102;
  hMouseUp = 1281103;
  hMouseNone = 1281104;

function max(a, b: longint): longint;
function min(a, b: longint): longint;
procedure UpdateText(NewText:string);


// HC12 function Color32toColor (TColor32: TColor32): TColor;
implementation

procedure UpdateText(NewText:string);
begin
      StatusText:=     NewText;
      status:=true;

end;


//Max for linux
function max(a, b: longint): longint;
begin
  if a > b then
    max := a
  else
    max := b;
end;

function min(a, b: longint): longint;
begin
  if a < b then
    min := a
  else
    min := b;
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

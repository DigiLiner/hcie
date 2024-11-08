{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit frame1;

{$warn 5023 off : no warning about unused units}
interface

uses
  hccolorbox, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('hccolorbox', @Register);
end.

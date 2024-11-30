program lazarus_hcie;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,  unitFormMain, unitFormNewImage
  ,hceffects, hctypes, hcGlobals, hcFileTypes
  , line, pen, circle, fill
  , animation  , unitformeffect ;
  {$R *.res}

begin
  RequireDerivedFormResource := True;
  Application .Scaled :=True ;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormNewImage, FormNewImage);
  Application .CreateForm (TFormEffect ,FormEffect );
  Application.Run;
end.

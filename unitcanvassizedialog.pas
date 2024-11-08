unit unitCanvasSizeDialog;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, StdCtrls,SysUtils, Forms, Controls, Graphics, Dialogs;

type
  TFormSetCanvasSize = class(TForm)
    ButtonOK:TButton;
    ButtonCancel:TButton;
    EditWidth:TEdit;
    EditHeight:TEdit;
    Label1:TLabel;
    Label2:TLabel;
    procedure ButtonCancelClick(Sender:TObject);
    procedure ButtonOKClick(Sender:TObject);
  private

  public

  end;

var
  FormSetCanvasSize: TFormSetCanvasSize;

implementation

{$R *.lfm}

procedure TFormSetCanvasSize.ButtonOKClick(Sender:TObject);
begin
ModalResult := mrOk; // Close the form and set the modal result
end;

procedure TFormSetCanvasSize.ButtonCancelClick(Sender:TObject);
begin
ModalResult := mrCancel; // Close the form and set the modal result
end;

end.


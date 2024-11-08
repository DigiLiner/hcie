unit Panel1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type
  TPanel1 = class(TPanel)
  private

  protected

  public

  published

  end;
           TEnhancedPanel = class(TCustomControl)
private
  { The new attribute for the embedded label }
  FEmbeddedLabel: TPanel;

public
  { The constructor must be overriden so the label can be created }
  constructor Create(AOwner: TComponent); override;

published
  { Make the label visible in the IDE }
  property EmbeddedLabel: TPanel read FEmbeddedLabel;
end;

implementation

constructor TEnhancedPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Set default width and height
  with GetControlClassDefaultSize do
    SetInitialBounds(0, 0, CX, CY);

  // Add the embedded label
  FEmbeddedLabel := TPanel.Create(Self); // Add the embedded label
  FEmbeddedLabel.Parent := self;         // Show the label in the panel
  FEmbeddedLabel.SetSubComponent(true);  // Tell the IDE to store the modified properties
 // TPanel1.Name := 'EmbeddedLabel';
 // TPanel1.Caption := 'Howdy World!';

  // Make sure the embedded label can not be selected/deleted within the IDE
  //TPanel1.ControlStyle := TPanel1.ControlStyle - [csNoDesignSelectable];

  // Set other properties if necessary
  //...

end;

procedure Register;
begin
  RegisterComponents('Additional',[TPanel1]);
end;
 end.

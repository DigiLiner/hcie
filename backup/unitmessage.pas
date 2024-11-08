//Bu unite child tarafından gönderilen mesajları ana forma iletir.
unit unitMessage;

{$mode ObjFPC}{$H+}

interface

uses
hcGlobals,unitFormMain,Classes, SysUtils;

var
MainForm: TMainForm; // Reference to the main form
StatusBar: TStatusBar;
procedure UpdateStatusText;
implementation



procedure UpdateStatusText;
begin
MainForm := TMainForm(Application.MainForm); // Get reference to the main form
StatusBar := MainForm.StatusBar; // Get reference to the status bar
StatusBar.Panels[0].Text := statusText; // Example: Set status bar text
end;
end.


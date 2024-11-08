unit unitFormNewImage;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TFormNewImage }

  TFormNewImage = class(TForm)
    ButtonOK: TButton;
    ButtonCancel: TButton;
    ComboBoxResolutions: TComboBox;
    EditWidth: TEdit;
    EditHeight: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label_NewImageSize: TLabel;
    RadioButton_Size: TRadioButton;
    RadioButton_Custom: TRadioButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
           NewImageWidth:Integer;
           NewImageHeight:Integer;
  end;

var
  FormNewImage: TFormNewImage;

implementation

{$R *.lfm}

{ TFormNewImage }

procedure TFormNewImage.FormCreate(Sender: TObject);
begin
  ComboBoxResolutions.Items.Clear();
  ComboBoxResolutions.Items.Add('800x600');

  ComboBoxResolutions.Items.Add('500x500');
  ComboBoxResolutions.Items.Add('1024x1024');
  ComboBoxResolutions.Items.Add('320x200');
  ComboBoxResolutions.Items.Add('400x300');
  ComboBoxResolutions.Items.Add('640x400');
  ComboBoxResolutions.Items.Add('640x480');
  ComboBoxResolutions.Items.Add('800x600');
  ComboBoxResolutions.Items.Add('1024x768');
  ComboBoxResolutions.Items.Add('1280x720');
  ComboBoxResolutions.Items.Add('1920x1080');
  ComboBoxResolutions.Items.Add('2560x1440');
  ComboBoxResolutions.Items.Add('3840x2160');
   ComboBoxResolutions.Items.Add('640x70');
  ComboBoxResolutions.ItemIndex := 0; // Set the default to the first item
end;

procedure TFormNewImage.ButtonOKClick(Sender: TObject);
var
   Res: TStringArray;
   ComboText: String;
begin
  if RadioButton_Custom.Checked= True then
  begin

  // Check if the width is numeric and convert it
  if TryStrToInt(EditWidth.Text, NewImageWidth) then
  begin
    // Successfully converted width
  end
  else
  begin
    // Handle non-numeric input for width
    ShowMessage('Please enter a valid numeric value for width.');
    Exit; // Exit the procedure if the input is invalid
  end;

  // Check if the height is numeric and convert it
  if TryStrToInt(EditHeight.Text, NewImageHeight) then
  begin
    // Successfully converted height
  end
  else
  begin
    // Handle non-numeric input for height
    ShowMessage('Please enter a valid numeric value for height.');
    Exit; // Exit the procedure if the input is invalid
  end;
  end
  else if RadioButton_Size.Checked=True then
  begin
  // Optionally parse the selected resolution from the ComboBox
  if ComboBoxResolutions.ItemIndex <> -1 then
  begin
    // Split the selected resolution text
    ComboText:=ComboBoxResolutions.Text;
    Res := ComboText.Split('x');
    if Length(Res) = 2 then
    begin
      // Set the Edit fields with the selected resolution
    if TryStrToInt(Res[0],NewImageWidth) then    // Set width
    begin
    end
    else
    begin
           // Handle non-numeric input for height
           ShowMessage('Please enter a valid numeric value for height.');
           Exit; // Exit the procedure if the input is invalid
    end;

    if TryStrToInt(Res[1],NewImageHeight) then   // Set height
    begin

    end
    else  begin
           // Handle non-numeric input for height
    ShowMessage('Please enter a valid numeric value for height.');
    Exit; // Exit the procedure if the input is invalid
    end;

    end;
  end;
   end;
  // You can now use NewImageWidth and NewImageHeight to create a new image
  // Here you could call a method to create the image
  ModalResult := mrOk; // Close the form and set the modal result
  end;

end.

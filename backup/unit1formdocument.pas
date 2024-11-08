unit unit1formdocument;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, ExtCtrls,SysUtils, Forms, Controls, Graphics, Dialogs;

type
  TFormDocument = class(TForm)
    Image1:TImage;
    Image2:TImage;
    MainPanel:TPanel;
    Panel1:TPanel;
    ScrollBox1:TScrollBox;
    procedure FormCreate(Sender:TObject);
  private

  public
  fileName:string;

  end;

var
  FormDocument: TFormDocument;

implementation

{$R *.lfm}

procedure TFormDocument.FormCreate(Sender:TObject);
begin
//### NOTE: 03.11.2024
//Bu bölüm tasarım sırasındaki karışıklığı engellemek için yazıldı
  MainPanel.Align:= alClient;
  MainPanel.Anchors:=[akBottom,akLeft,akRight,akTop];
  ScrollBox1.Align:=alClient;
  ScrollBox1.Anchors:=[];
  Panel1.Align:=alNone;
  Panel1.Anchors:=[akLeft,akTop];
  Image1.Align:=alCustom;
  Image1.Anchors:=[];
  LoadImage;
// ### END NOTE ###############
end;

procedure LoadImage():
begin
     Image1.Picture.LoadFromFile(filename);
    Image1.Width := Image1.Picture.Width;
    Image1.Height := Image1.Picture.Height;
    Image2.Width := Image1.Picture.Width;
    Image2.Height := Image1.Picture.Height;

end.


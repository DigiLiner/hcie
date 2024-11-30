unit unitfrmeffect ;

{$mode ObjFPC}{$H+}

interface

uses
  Classes ,SysUtils ,Forms ,Controls ,Graphics ,Dialogs ,ExtCtrls ,StdCtrls ,
  ComCtrls ,BGRAShape ,atshapelinebgra ,SdpoJoystick ;

type

  { TFrmEffect }

  TFrmEffect = class (TForm )
    Button1 :TButton ;
    Button2 :TButton ;
    Button3 :TButton ;
    Button4 :TButton ;
    CheckBox1 :TCheckBox ;
    CheckBox2 :TCheckBox ;
    GroupBox1 :TGroupBox ;
    GroupBox2 :TGroupBox ;
    GroupBox3 :TGroupBox ;
    Image1 :TImage ;
    Image2 :TImage ;
    Label1 :TLabel ;
    Label2 :TLabel ;
    Label3 :TLabel ;
    Label4 :TLabel ;
    Label5 :TLabel ;
    Label6 :TLabel ;
    Label7 :TLabel ;
    Label8 :TLabel ;
    RadioButton1 :TRadioButton ;
    RadioButton2 :TRadioButton ;
    RadioButton3 :TRadioButton ;
    RadioButton4 :TRadioButton ;
    RadioButton5 :TRadioButton ;
    RadioButton6 :TRadioButton ;
    RadioButton7 :TRadioButton ;
    RadioButton8 :TRadioButton ;
    Shape1 :TShape ;
    Shape2 :TShape ;
    StaticText1 :TStaticText ;
    StaticText2 :TStaticText ;
    StaticText3 :TStaticText ;
    StaticText4 :TStaticText ;
    StaticText5 :TStaticText ;
    StaticText6 :TStaticText ;
    StaticText7 :TStaticText ;
    StaticText8 :TStaticText ;
    TrackBar1 :TTrackBar ;
    TrackBar2 :TTrackBar ;
    TrackBar3 :TTrackBar ;
    TrackBar4 :TTrackBar ;
    TrackBar5 :TTrackBar ;
    TrackBar6 :TTrackBar ;
    TrackBar7 :TTrackBar ;
    TrackBar8 :TTrackBar ;
    procedure Shape1ChangeBounds (Sender :TObject );
  private

  public

  end ;

var
  FrmEffect : TFrmEffect ;

implementation

{$R *.lfm}

{ TForm1 }

procedure TFrmEffect.Shape1ChangeBounds (Sender :TObject );
begin

end;

end .


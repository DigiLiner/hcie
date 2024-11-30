unit hcFileTypes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TIoMethod = (imNone, imLoad, imSave);
  TFREE_IMAGE_FORMAT = (fifUnknown, fifBmp, fifJpeg, fifPng); // Örnek enum değerleri
  TFREE_IMAGE_LOAD_FLAGS = set of (lfDefault);
  TFREE_IMAGE_SAVE_FLAGS = set of (sfDefault);

  TImageFormat = class // Burada ImageFormat için gerekli alanları tanımlayabilirsiniz
  end;

  THcFiletypes = class
  private
    FExt: string;
    FLoadMethod: TIoMethod;
    FSaveMethod: TIoMethod;
    FIformat: TObject;
    // System.Drawing.Imaging.ImageFormat karşılığı yok, TObject olarak ayarladım
    FFformat: TFREE_IMAGE_FORMAT;
    FLoadFlags: TFREE_IMAGE_LOAD_FLAGS;
    FSaveFlags: TFREE_IMAGE_SAVE_FLAGS;
    FDesc: string;
    FKnown: boolean;
    FOptions: boolean;
    FExt2: string;
    FExt3: string;
    FExt4: string;
    FTransparency32: boolean;
    FTransparency8: boolean;
  public
    Ext: string;
    Desc: string;
    LoadMethod: TIoMethod;
    SaveMethod: TIoMethod;
    Iformat: TImageFormat;
    Fformat: TFREE_IMAGE_FORMAT;
    LoadFlags: TFREE_IMAGE_LOAD_FLAGS;
    SaveFlags: TFREE_IMAGE_SAVE_FLAGS;
    Known: boolean;
    Options: boolean;
    Ext2: string;
    Ext3: string;
    Ext4: string;
    Transparency32: boolean;
    Transparency8: boolean;
    constructor Create(const AExt: string = '';
      const ALoadMethod: TIoMethod = imNone; const ASaveMethod: TIoMethod = imNone;
      AIformat: TObject = nil; const AFformat: TFREE_IMAGE_FORMAT = fifBmp;
      ALoadFlags: TFREE_IMAGE_LOAD_FLAGS = [];
      ASaveFlags: TFREE_IMAGE_SAVE_FLAGS = []; const ADesc: string = '';
      const AKnown: boolean = False; const AOptions: boolean = False;
      const AExt2: string = ''; const AExt3: string = ''; const AExt4: string = '';
      const ATrans32: boolean = False; const ATrans8: boolean = False);
  end;

var
  _j: integer = 0; // Global index variable

implementation

constructor THcFiletypes.Create(const AExt: string = '';
  const ALoadMethod: TIoMethod = imNone; const ASaveMethod: TIoMethod = imNone;
  AIformat: TObject = nil; const AFformat: TFREE_IMAGE_FORMAT = fifBmp;
  ALoadFlags: TFREE_IMAGE_LOAD_FLAGS = []; ASaveFlags: TFREE_IMAGE_SAVE_FLAGS = [];
  const ADesc: string = ''; const AKnown: boolean = False;
  const AOptions: boolean = False; const AExt2: string = '';
  const AExt3: string = ''; const AExt4: string = ''; const ATrans32: boolean = False;
  const ATrans8: boolean = False);
begin
  FExt := AExt;
  FLoadMethod := ALoadMethod;
  FSaveMethod := ASaveMethod;
  FIformat := AIformat;
  FFformat := AFformat;
  FLoadFlags := ALoadFlags;
  FSaveFlags := ASaveFlags;
  FDesc := ADesc;
  FKnown := AKnown;
  FOptions := AOptions;
  FExt2 := AExt2;
  FExt3 := AExt3;
  FExt4 := AExt4;
  FTransparency32 := ATrans32;
  FTransparency8 := ATrans8;
end;

function Fill(var f1: array of THcFiletypes;
  const ext: string;
  const desc: string;
  loadMethod: TIoMethod;
  saveMethod: TIoMethod = imNone;
  const ext2: string = '';
  const ext3: string = '';
  const ext4: string = '';
  iformat: TImageFormat = nil;
  fformat: TFREE_IMAGE_FORMAT = fifBmp;
  loadFlags: TFREE_IMAGE_LOAD_FLAGS = [lfDefault];
  saveFlags: TFREE_IMAGE_SAVE_FLAGS = [sfDefault];
  known: boolean = False; options: boolean = False;
  transparency32: boolean = False;
  transparency8: boolean = False): boolean;
begin
  if Length(f1) <= _j then
  begin
   //todo error SetLength(f1, _j + 1);
    f1[_j] := THcFiletypes.Create;
  end;

  f1[_j].Ext := ext;
  f1[_j].Desc := desc;
  f1[_j].LoadMethod := loadMethod;
  f1[_j].SaveMethod := saveMethod;
  f1[_j].LoadFlags := loadFlags;
  f1[_j].SaveFlags := saveFlags;
  f1[_j].Iformat := iformat;
  f1[_j].Fformat := fformat;
  f1[_j].Known := known;
  f1[_j].Options := options;
  f1[_j].Ext2 := ext2;
  f1[_j].Ext3 := ext3;
  f1[_j].Ext4 := ext4;
  f1[_j].Transparency32 := transparency32;
  f1[_j].Transparency8 := transparency8;

  Inc(_j);

  Result := True;
end;

end.

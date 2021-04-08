unit AWS4D.S3;
interface
uses
  System.Classes,
  AWS4D.Interfaces,
  Jpeg,
  {$IFDEF HAS_FMX}
    FMX.Objects;
  {$ELSE}
    Vcl.ExtCtrls;
  {$ENDIF}
type
  TAWS4DS3 = class(TInterfacedObject, iAWS4DS3)
    private
      [weak]
      FParent : iAWS4D;
      FContent : String;
      FContentByteStream : TBytesStream;
    public
      constructor Create(aParent : iAWS4D);
      destructor Destroy; override;
      class function New(aParent : iAWS4D) : iAWS4DS3;
      function SendFile : iAWS4DS3SendFile;
      function GetFile : iAWS4DS3GetFile;
      function ToString : String; reintroduce;
      function ToBytesStream : TBytesStream;
      function FromImage(var aValue : TImage) : iAWS4DS3;
      function Content ( aValue : String ) :  iAWS4DS3; overload;
      function Content ( var aValue : TBytesStream ) : iAWS4DS3; overload;
      function ContentByteStream : TBytesStream;
      function &End : iAWS4D;
   end;
implementation
uses
  Data.Cloud.AmazonAPI,
  Data.Cloud.CloudAPI,
  AWS4D.S3.Get,
  AWS4D.S3.Send,
  AWS4D.S3.Credencial;
{ TBind4DAmazonS3 }
function TAWS4DS3.ToBytesStream: TBytesStream;
begin
  Result := FContentByteStream;
end;
function TAWS4DS3.ToString: String;
begin
  Result := FContent;
end;
function TAWS4DS3.Content(aValue: String): iAWS4DS3;
begin
  Result := Self;
  FContent := aValue;
end;
function TAWS4DS3.&End: iAWS4D;
begin
  Result := FParent;
end;
function TAWS4DS3.Content(var aValue: TBytesStream): iAWS4DS3;
begin
  Result := Self;
  FContentByteStream := aValue;
end;
function TAWS4DS3.ContentByteStream: TBytesStream;
begin
  Result := FContentByteStream;
end;

constructor TAWS4DS3.Create(aParent : iAWS4D);
begin
  FParent := aParent;
  FContentByteStream := TBytesStream.Create;
end;
destructor TAWS4DS3.Destroy;
begin
  if Assigned(FContentByteStream) then
    FContentByteStream.Free;
  inherited;
end;
function TAWS4DS3.FromImage(var aValue: TImage): iAWS4DS3;
var
  FJpegImage : TJpegImage;
begin
  Result := Self;
  FJpegImage := TJpegImage.Create;
  try
    FJpegImage.LoadFromStream(FContentByteStream);
    {$IFDEF HAS_FMX}
      aValue.Bitmap.LoadFromStream(FContentByteStream);
    {$ELSE}
      aValue.Picture.Assign(FJpegImage);
    {$ENDIF}
  finally
    FJpegImage.Free;
  end;
end;
function TAWS4DS3.GetFile: iAWS4DS3GetFile;
begin
  Result := TAWS4DS3GetFile.New(Self);
end;
class function TAWS4DS3.New(aParent : iAWS4D) : iAWS4DS3;
begin
  Result := Self.Create(aParent);
end;
function TAWS4DS3.SendFile: iAWS4DS3SendFile;
begin
  Result := TAWS4DS3SendFile.New(Self);;
end;

end.

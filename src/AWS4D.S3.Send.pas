unit AWS4D.S3.Send;

interface

uses
  System.Classes,
  AWS4D.Interfaces,
  {$IFDEF HAS_FMX}
    FMX.Objects;
  {$ELSE}
    Vcl.ExtCtrls;
  {$ENDIF}

type
  TAWS4DS3SendFile = class(TInterfacedObject, iAWS4DS3SendFile)
    private
      [weak]
      FParent : iAWS4DS3;
      FFileName : String;
      FContentType : String;
      FFileStream : TBytesStream;
    public
      constructor Create(aParent : iAWS4DS3);
      destructor Destroy; override;
      class function  New ( aParent : iAWS4DS3) : iAWS4DS3SendFile;
      function FileName( aValue : String ) : iAWS4DS3SendFile;
      function ContentType( aValue : String ) : iAWS4DS3SendFile;
      function FileStream( aValue : TBytesStream ) : iAWS4DS3SendFile; overload;
      function FileStream( aValue : TImage ) : iAWS4DS3SendFile; overload;
      function Send : iAWS4DS3;
  end;

implementation

uses
  Data.Cloud.AmazonAPI,
  Data.Cloud.CloudAPI;

{ TBind4DAmazonS3Send }

function TAWS4DS3SendFile.ContentType(
  aValue: String): iAWS4DS3SendFile;
begin
  Result := Self;
  FContentType := aValue;
end;

constructor TAWS4DS3SendFile.Create(aParent: iAWS4DS3);
begin
  FParent := aParent;
end;

destructor TAWS4DS3SendFile.Destroy;
begin
  if Assigned(FFileStream) then
    FFileStream.Free;
  inherited;
end;

function TAWS4DS3SendFile.FileName(aValue: String): iAWS4DS3SendFile;
begin
  Result := Self;
  FFileName := aValue;
end;

function TAWS4DS3SendFile.FileStream(
  aValue: TBytesStream): iAWS4DS3SendFile;
begin
  Result := Self;
  FFileStream := aValue;
end;

function TAWS4DS3SendFile.FileStream(
  aValue: TImage): iAWS4DS3SendFile;
begin
  Result := Self;
  if not Assigned(FFileStream) then
    FFileStream := TBytesStream.Create();
  {$IFDEF HAS_FMX}
    aValue.Bitmap.SaveToStream(FFileStream);
  {$ELSE}
    aValue.Picture.SaveToStream(FFileStream);
  {$ENDIF}

end;

class function TAWS4DS3SendFile.New(
  aParent: iAWS4DS3): iAWS4DS3SendFile;
begin
  Result := Self.Create(aParent);
end;

function TAWS4DS3SendFile.Send: iAWS4DS3;
var
  AmazonConnectionInfo1: TAmazonConnectionInfo;
  StorageService : TAmazonStorageService;
  CloudResponse : TCloudResponseInfo;
  Header : TStringList;
begin
  Result := FParent;
  AmazonConnectionInfo1 := TAmazonConnectionInfo.Create(nil);
  StorageService := TAmazonStorageService.Create(AmazonConnectionInfo1);
  CloudResponse := TCloudResponseInfo.Create;
  Header := TStringList.Create;
  try
    Header.Values['Content-Type'] := FContentType;
    AmazonConnectionInfo1.AccountKey := FParent.&End.Credential.AccountKey;
    AmazonConnectionInfo1.AccountName := FParent.&End.Credential.AccountName;
    AmazonConnectionInfo1.StorageEndpoint := FParent.&End.Credential.StorageEndPoint;
    AmazonConnectionInfo1.UseDefaultEndpoints := False;

    if StorageService.UploadObject(
        FParent.&End.Credential.Bucket,
        FFileName,
        FFileStream.Bytes,
        False,
        nil,
        Header,
        amzbaPublicReadWrite,
        CloudResponse
    ) then
      FParent.Content('https://' + FParent.&End.Credential.Bucket + '.' + FParent.&End.Credential.StorageEndPoint + '/' + FFileName);
  finally
    Header.Free;
    CloudResponse.Free;
    StorageService.Free;
    AmazonConnectionInfo1.Free;
  end;
end;

end.

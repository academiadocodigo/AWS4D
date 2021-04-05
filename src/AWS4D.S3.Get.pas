unit AWS4D.S3.Get;

interface

uses
  AWS4D.Interfaces;

type
  TAWS4DS3GetFile = class(TInterfacedObject, iAWS4DS3GetFile)
    private
      [weak]
      FParent : iAWS4DS3;
      FFileName : String;
      FContentType : String;
    public
      constructor Create( aParent : iAWS4DS3);
      destructor Destroy; override;
      class function New ( aParent : iAWS4DS3) : iAWS4DS3GetFile;
      function FileName ( aValue : String ) : iAWS4DS3GetFile;
      function ContentType( aValue : String ) : iAWS4DS3GetFile;
      function Get : iAWS4DS3;
  end;

implementation

uses
  System.Classes,
  System.StrUtils,
  Data.Cloud.AmazonAPI,
  Data.Cloud.CloudAPI,
  System.SysUtils,
  Jpeg;

{ TBind4DAmazonS3Get }

function TAWS4DS3GetFile.ContentType(aValue: String): iAWS4DS3GetFile;
begin
  Result := Self;
  FContentType := aValue;
end;

constructor TAWS4DS3GetFile.Create(aParent: iAWS4DS3);
begin
  FParent := aParent;
end;

destructor TAWS4DS3GetFile.Destroy;
begin

  inherited;
end;

function TAWS4DS3GetFile.FileName(aValue: String): iAWS4DS3GetFile;
begin
  Result := Self;
  FFileName := aValue;
end;

function TAWS4DS3GetFile.Get: iAWS4DS3;
var
  AmazonConnectionInfo1: TAmazonConnectionInfo;
  StorageService : TAmazonStorageService;
  CloudResponse : TCloudResponseInfo;
begin
  Result := FParent;
  AmazonConnectionInfo1 := TAmazonConnectionInfo.Create(nil);
  StorageService := TAmazonStorageService.Create(AmazonConnectionInfo1);
  CloudResponse := TCloudResponseInfo.Create;
  FFileName := ReverseString(FFileName);
  FFileName := Copy(FFileName, 0, Pos('/', FFileName)-1);
  FFileName := ReverseString(FFileName);
  try
    if Trim(FFileName) <> '' then
    begin
      AmazonConnectionInfo1.AccountKey := FParent.&End.Credential.AccountKey;
      AmazonConnectionInfo1.AccountName := FParent.&End.Credential.AccountName;
      AmazonConnectionInfo1.StorageEndpoint := FParent.&End.Credential.StorageEndPoint;
      AmazonConnectionInfo1.UseDefaultEndpoints := False;

      if not StorageService.GetObject(
        FParent.&End.Credential.Bucket,
        FFileName,
        FParent.ContentByteStream,
        CloudResponse
      ) then
        raise Exception.Create(CloudResponse.StatusMessage);
    end;
  finally
    CloudResponse.Free;
    StorageService.Free;
    AmazonConnectionInfo1.Free;
  end;
end;

class function TAWS4DS3GetFile.New(
  aParent: iAWS4DS3): iAWS4DS3GetFile;
begin
  Result := Self.Create(aParent);
end;

end.

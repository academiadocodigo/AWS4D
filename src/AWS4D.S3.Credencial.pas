unit AWS4D.S3.Credencial;

interface

uses
  AWS4D.Interfaces;

type

  TAWS4DCredential = class(TInterfacedObject, iAWS4DCredential)
    private
      [weak]
      FParent : iAWS4DS3;
      FAccountKey : String;
      FAccountName : String;
      FStorageEndPoint : String;
      FBucket : String;
    public
      constructor Create (aParent : iAWS4DS3);
      destructor Destroy; override;
      class function New(aParent : iAWS4DS3) : iAWS4DCredential; overload;
      function AccountKey( aValue : String ) : iAWS4DCredential; overload;
      function AccountName( aValue : String ) :  iAWS4DCredential; overload;
      function StorageEndPoint( aValue : String ) : iAWS4DCredential;  overload;
      function Bucket ( aValue : String ) : iAWS4DCredential; overload;
      function AccountKey : String; overload;
      function AccountName : String; overload;
      function StorageEndPoint : String; overload;
      function Bucket : String; overload;
      function &End : iAWS4DS3;
  end;

implementation

{ TAmazonS3Credencial }

function TAWS4DCredential.AccountKey(aValue: String): iAWS4DCredential;
begin
  Result := Self;
  FAccountKey := aValue;
end;

function TAWS4DCredential.AccountName(
  aValue: String): iAWS4DCredential;
begin
  Result := Self;
  FAccountName := aValue;
end;

function TAWS4DCredential.Bucket(aValue: String): iAWS4DCredential;
begin
  Result := Self;
  FBucket := aValue;
end;

function TAWS4DCredential.&End: iAWS4DS3;
begin
  Result := FParent;
end;

constructor TAWS4DCredential.Create(aParent: iAWS4DS3);
begin
  FParent := aParent;
end;

destructor TAWS4DCredential.Destroy;
begin

  inherited;
end;

class function TAWS4DCredential.New(
  aParent: iAWS4DS3): iAWS4DCredential;
begin
  Result := Self.Create(aParent);
end;

function TAWS4DCredential.StorageEndPoint: String;
begin
  Result := FStorageEndPoint;
end;

function TAWS4DCredential.StorageEndPoint(
  aValue: String): iAWS4DCredential;
begin
  Result := Self;
  FStorageEndPoint := aValue;
end;

function TAWS4DCredential.AccountKey: String;
begin
  Result := FAccountKey;
end;

function TAWS4DCredential.AccountName: String;
begin
  Result := FAccountName;
end;

function TAWS4DCredential.Bucket: String;
begin
  Result := FBucket;
end;

end.

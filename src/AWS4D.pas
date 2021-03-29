unit AWS4D;

interface

uses
  AWS4D.Interfaces;

type
  TAWS4D = class(TInterfacedObject, iAWS4D)
    private
      FCredencial : iAWS4DCredential;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAWS4D;
      function S3 : iAWS4DS3;
      function Credential : iAWS4DCredential;
  end;

var
  vAWS4D : iAWS4D;

implementation

uses
  AWS4D.S3,
  AWS4D.S3.Credencial;

{ TBind4DAmazon }

constructor TAWS4D.Create;
begin

end;

function TAWS4D.Credential: iAWS4DCredential;
begin
  if not Assigned(FCredencial) then
    FCredencial := TAWS4DCredential.New(Self);

  Result := FCredencial;
end;

destructor TAWS4D.Destroy;
begin

  inherited;
end;

class function TAWS4D.New: iAWS4D;
begin
  if not Assigned(vAWS4D) then
    vAWS4D := Self.Create;

  Result := vAWS4D;
end;

function TAWS4D.S3: iAWS4DS3;
begin
  Result := TAWS4DS3.New(Self);;
end;

end.

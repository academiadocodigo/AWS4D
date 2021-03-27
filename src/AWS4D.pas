unit AWS4D;

interface

uses
  AWS4D.Interfaces;

type
  TAWS4D = class(TInterfacedObject, iAWS4D)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAWS4D;
      function S3 : iAWS4DS3;
  end;

implementation

uses
  AWS4D.S3;

{ TBind4DAmazon }

constructor TAWS4D.Create;
begin

end;

destructor TAWS4D.Destroy;
begin

  inherited;
end;

class function TAWS4D.New: iAWS4D;
begin
  Result := Self.Create;
end;

function TAWS4D.S3: iAWS4DS3;
begin
  Result :=  TAWS4DS3.New;
end;

end.

unit AWS4D.Interfaces;

interface

uses
  System.Classes,
  Jpeg,
  {$IFDEF HAS_FMX}
    FMX.Objects;
  {$ELSE}
    Vcl.ExtCtrls;
  {$ENDIF}

type
  iAWS4DS3 = interface;
  iAWS4DS3SendFile = interface;
  iAWS4DS3GetFile = interface;
  iAWS4DCredential = interface;

  iAWS4D = interface
    ['{26E15418-DE77-455D-AF27-8EECF7C6A64B}']
    function S3 : iAWS4DS3;
    function Credential : iAWS4DCredential;
  end;

  iAWS4DS3 = interface
   ['{9D596CD1-33F8-438B-BDB8-A65766354680}']
    function SendFile : iAWS4DS3SendFile;
    function GetFile : iAWS4DS3GetFile;
    function ToString : String;
    function ToBytesStream : TBytesStream;
    function FromImage(var aValue : TImage) : iAWS4DS3;
    function Content ( aValue : String ) :  iAWS4DS3; overload;
    function Content ( var aValue : TBytesStream ) : iAWS4DS3; overload;
    function ContentByteStream : TBytesStream;
    function &End : iAWS4D;
  end;

  iAWS4DCredential = interface
    ['{8D46D890-12DE-41B6-BD57-A8684BCEF635}']
    function AccountKey( aValue : String ) : iAWS4DCredential; overload;
    function AccountName( aValue : String ) :  iAWS4DCredential; overload;
    function StorageEndPoint( aValue : String ) : iAWS4DCredential; overload;
    function Bucket ( aValue : String ) : iAWS4DCredential; overload;
    function AccountKey : String; overload;
    function AccountName : String; overload;
    function StorageEndPoint : String; overload;
    function Bucket : String; overload;
    function &End : iAWS4D;
  end;

  iAWS4DS3GetFile = interface
    ['{65859963-94C5-43F8-A777-4830696DC105}']
    function FileName ( aValue : String ) : iAWS4DS3GetFile;
    function ContentType( aValue : String ) : iAWS4DS3GetFile;
    function Get : iAWS4DS3;
  end;

  iAWS4DS3SendFile = interface
    ['{7B0C4AD1-80AB-4D74-99AE-64D89C089D46}']
    function FileName( aValue : String ) : iAWS4DS3SendFile;
    function ContentType( aValue : String ) : iAWS4DS3SendFile;
    function FileStream( aValue : TBytesStream ) : iAWS4DS3SendFile; overload;
    function FileStream( aValue : TImage ) : iAWS4DS3SendFile; overload;
    function Send : iAWS4DS3;
  end;

implementation

end.

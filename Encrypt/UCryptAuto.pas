unit UCryptAuto;
(* 2002 Twiddle *)

interface
uses
  Classes,
  SysUtils,
  Windows;

type
  HCRYPTPROV = Longword;
  HCRYPTKEY  = Longword;
  HCRYPTHASH = Longword;
  ALG_ID     = Cardinal;

  THogeCryptAuto = class(TObject)
  protected
    FErrorCode: cardinal;
    FErrorStr: string;
    FCryptAlg: ALG_ID;
    FBlockSize: cardinal;
    FHashAlg:  ALG_ID;
    FBufSize: cardinal;
    FMaxBlobSize: cardinal;
  public
    constructor Create;
    destructor Destroy; override;
    function Encrypt(inputStream: TStream;      // (in) plain text
                     const password: string;    // (in) password
                     outputStream: TStream)     // (out) encrypted text
        : boolean;
    function Decrypt(inputStream: TStream;      // (in) ecrrypted text
                     const password: string;    // (in) password
                     outputStream: TStream)     // (out) plain text
        : boolean;
    property ErrorCode: cardinal read FErrorCode;
    property ErrorStr: string read FErrorStr;
    property CryptAlg: ALG_ID read FCryptAlg write FCryptAlg;
    property BlockSize: Cardinal read FBlockSize write FBlockSize;
    property HashAlg: ALG_ID read FHashAlg write FHashAlg;
    property BufSize: cardinal read FBufSize write FBufSize;
    property MaxBlobSize: cardinal read FMaxBlobSize write FMaxBlobSize;
  end;



const
  PROV_RSA_FULL      =     1;
  PROV_RSA_SIG       =     2;
  PROV_DSS           =     3;
  PROV_FORTEZZA      =     4;
  PROV_MS_EXCHANGE   =     5;
  PROV_SSL           =     6;
  PROV_RSA_SCHANNEL  =    12;
  PROV_DSS_DH        =    13;
  PROV_EC_ECDSA_SIG  =    14;
  PROV_EC_ECNRA_SIG  =    15;
  PROV_EC_ECDSA_FULL =    16;
  PROV_EC_ECNRA_FULL =    17;
  PROV_SPYRUS_LYNKS  =    20;

  SIMPLEBLOB         =    $1;
  PUBLICKEYBLOB      =    $6;
  PRIVATEKEYBLOB     =    $7;
  PLAINTEXTKEYBLOB   =    $8;

  AT_KEYEXCHANGE     =     1;
  AT_SIGNATURE       =     2;

  CRYPT_USERDATA     =     1;

  //Algorithm classes
  ALG_CLASS_ANY          = (0);
  ALG_CLASS_SIGNATURE    = (1 shl 13);
  ALG_CLASS_MSG_ENCRYPT  = (2 shl 13);
  ALG_CLASS_DATA_ENCRYPT = (3 shl 13);
  ALG_CLASS_HASH         = (4 shl 13);
  ALG_CLASS_KEY_EXCHANGE = (5 shl 13);

  // Algorithm types
  ALG_TYPE_ANY           = (0);
  ALG_TYPE_DSS           = (1 shl 9);
  ALG_TYPE_RSA           = (2 shl 9);
  ALG_TYPE_BLOCK         = (3 shl 9);
  ALG_TYPE_STREAM        = (4 shl 9);
  ALG_TYPE_DH            = (5 shl 9);
  ALG_TYPE_SECURECHANNEL = (6 shl 9);

  // Generic sub-ids
  ALG_SID_ANY            = 0;

  // Some RSA sub-ids
  ALG_SID_RSA_ANY        = 0;
  ALG_SID_RSA_PKCS       = 1;
  ALG_SID_RSA_MSATWORK   = 2;
  ALG_SID_RSA_ENTRUST    = 3;
  ALG_SID_RSA_PGP        = 4;

  // Some DSS sub-ids
  ALG_SID_DSS_ANY        = 0;
  ALG_SID_DSS_PKCS       = 1;
  ALG_SID_DSS_DMS        = 2;

  // Block cipher sub ids
  // DES sub_ids
  ALG_SID_DES            =  1;
  ALG_SID_3DES           =  3;
  ALG_SID_DESX           =  4;
  ALG_SID_IDEA           =  5;
  ALG_SID_CAST           =  6;
  ALG_SID_SAFERSK64      =  7;
  ALG_SID_SAFERSK128     =  8;
  ALG_SID_3DES_112       =  9;
  ALG_SID_CYLINK_MEK     = 12;
  ALG_SID_RC5            = 13;

  // Fortezza sub-ids
  ALG_SID_SKIPJACK       = 10;
  ALG_SID_TEK            = 11;

  // KP_MODE
  CRYPT_MODE_CBCI        =  6;      // ANSI CBC Interleaved
  CRYPT_MODE_CFBP        =  7;      // ANSI CFB Pipelined
  CRYPT_MODE_OFBP        =  8;      // ANSI OFB Pipelined
  CRYPT_MODE_CBCOFM      =  9;      // ANSI CBC + OF Masking
  CRYPT_MODE_CBCOFMI     = 10;      // ANSI CBC + OFM Interleaved

  // RC2 sub-ids
  ALG_SID_RC2            = 2;

  // Stream cipher sub-ids
  ALG_SID_RC4            = 1;
  ALG_SID_SEAL           = 2;

  // Diffie-Hellman sub-ids
  ALG_SID_DH_SANDF       = 1;
  ALG_SID_DH_EPHEM       = 2;
  ALG_SID_AGREED_KEY_ANY = 3;
  ALG_SID_KEA            = 4;

  // Hash sub ids
  ALG_SID_MD2            = 1;
  ALG_SID_MD4            = 2;
  ALG_SID_MD5            = 3;
  ALG_SID_SHA            = 4;
  ALG_SID_SHA1           = 4;
  ALG_SID_MAC            = 5;
  ALG_SID_RIPEMD         = 6;
  ALG_SID_RIPEMD160      = 7;
  ALG_SID_SSL3SHAMD5     = 8;
  ALG_SID_HMAC           = 9;

  // secure channel sub ids
  ALG_SID_SSL3_MASTER           =  1;
  ALG_SID_SCHANNEL_MASTER_HASH  =  2;
  ALG_SID_SCHANNEL_MAC_KEY      =  3;
  ALG_SID_PCT1_MASTER           =  4;
  ALG_SID_SSL2_MASTER           =  5;
  ALG_SID_TLS1_MASTER           =  6;
  ALG_SID_SCHANNEL_ENC_KEY      =  7;

  // algorithm identifier definitions
  CALG_MD2	     = (ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD2);
  CALG_MD4	     = (ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD4);
  CALG_MD5	     = (ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD5);
  CALG_SHA	     = (ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SHA);
  CALG_SHA1	     = (ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SHA1);
  CALG_MAC	     = (ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MAC);
  CALG_RSA_SIGN	     = (ALG_CLASS_SIGNATURE or ALG_TYPE_RSA or ALG_SID_RSA_ANY);
  CALG_DSS_SIGN	     = (ALG_CLASS_SIGNATURE or ALG_TYPE_DSS or ALG_SID_DSS_ANY);
  CALG_RSA_KEYX	     = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_RSA or ALG_SID_RSA_ANY);
  CALG_DES	     = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_DES);
  CALG_3DES_112	     = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_3DES_112);
  CALG_3DES	     = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_3DES);
  CALG_RC2	     = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_RC2);
  CALG_RC4	     = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_STREAM or ALG_SID_RC4);
  CALG_SEAL	     = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_STREAM or ALG_SID_SEAL);
  CALG_DH_SF         = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH or ALG_SID_DH_SANDF);
  CALG_DH_EPHEM	     = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH or ALG_SID_DH_EPHEM);
  CALG_AGREEDKEY_ANY = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH or ALG_SID_AGREED_KEY_ANY);
  CALG_KEA_KEYX	     = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH or ALG_SID_KEA);
  CALG_HUGHES_MD5    = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_ANY or ALG_SID_MD5);
  CALG_SKIPJACK	     = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_SKIPJACK);
  CALG_TEK	     = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_TEK);
  CALG_CYLINK_MEK    = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_CYLINK_MEK);
  CALG_SSL3_SHAMD5   = (ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SSL3SHAMD5);
  CALG_SSL3_MASTER   = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SSL3_MASTER);
  CALG_SCHANNEL_MASTER_HASH = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SCHANNEL_MASTER_HASH);
  CALG_SCHANNEL_MAC_KEY = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SCHANNEL_MAC_KEY);
  CALG_SCHANNEL_ENC_KEY = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SCHANNEL_ENC_KEY);
  CALG_PCT1_MASTER   = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_PCT1_MASTER);
  CALG_SSL2_MASTER   = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_SSL2_MASTER);
  CALG_TLS1_MASTER   = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL or ALG_SID_TLS1_MASTER);
  CALG_RC5           = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_RC5);
  CALG_HMAC	     = (ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_HMAC);

  // dwFlags definitions for CryptAcquireContext
  CRYPT_VERIFYCONTEXT  = $F0000000;
  CRYPT_NEWKEYSET      = $00000008;
  CRYPT_DELETEKEYSET   = $00000010;
  CRYPT_MACHINE_KEYSET = $00000020;

  // dwFlag definitions for CryptGenKey
  CRYPT_EXPORTABLE     = $00000001;
  CRYPT_USER_PROTECTED = $00000002;
  CRYPT_CREATE_SALT    = $00000004;
  CRYPT_UPDATE_KEY     = $00000008;
  CRYPT_NO_SALT        = $00000010;
  CRYPT_PREGEN         = $00000040;
  CRYPT_RECIPIENT      = $00000010;
  CRYPT_INITIATOR      = $00000040;
  CRYPT_ONLINE         = $00000080;
  CRYPT_SF             = $00000100;
  CRYPT_CREATE_IV      = $00000200;
  CRYPT_KEK            = $00000400;
  CRYPT_DATA_KEY       = $00000800;


function CryptAcquireContext(
        var hProv: HCRYPTPROV;  // out
        szContainer: PChar;     // in
        szProvider: PChar;      // in
        dwProvType: Longword;   // in
        dwFlags: Longword       // in
) : LongBool; stdcall; external 'advapi32.dll' name 'CryptAcquireContextA';

function CryptReleaseContext(
        hProv: HCRYPTPROV;      // in
        dwFlags: Longword       // in
) : LongBool; stdcall; external 'advapi32.dll';

function CryptGetUserKey(
        hProv: HCRYPTPROV;      // in
        dwKeySpec: Longword;    // in
        var hUserKey: HCRYPTKEY // out
) : LongBool; stdcall; external 'advapi32.dll';

function CryptGenKey(
        hProv: HCRYPTPROV;      // in
        Algid: ALG_ID;          // in
        dwFlags: Longword;      // in
        var hKey: HCRYPTKEY     // out
) : LongBool; stdcall; external 'advapi32.dll';


function CryptDestroyKey(
        hKey: HCRYPTKEY         // in
) : LongBool; stdcall; external 'advapi32.dll';

function CryptExportKey(
        hKey: HCRYPTKEY;        // in
        hExpKey: HCRYPTKEY;     // in
        dwBlobType: Longword;   // in
        dwFlags: Longword;      // in
        pbData: Pointer;        // in
        var cbDataLen: Longword // in/out
) : LongBool; stdcall; external 'advapi32.dll';

function CryptCreateHash(
        hProv: HCRYPTPROV;      // in
        Algid: ALG_ID;          // in
        hKey: HCRYPTKEY;        // in
        dwFlags: Longword;      // in
        var hHash: HCRYPTHASH   // out
) : LongBool; stdcall; external 'advapi32.dll';

function CryptDestroyHash(
        hHash: HCRYPTHASH       // in
) : LongBool; stdcall; external 'advapi32.dll';

function CryptHashData(
        hHash: HCRYPTHASH;      // in
        pbData: Pointer;        // in
        cbData: Longword;       // in
        dwFlags: Longword       // in
) : LongBool; stdcall; external 'advapi32.dll';

function CryptDeriveKey(
        hProv: HCRYPTPROV;      // in
        Algid: ALG_ID;          // in
        hBaseData: HCRYPTHASH;  // in
        dwFlags: Longword;      // in
        var hKey: HCRYPTKEY     // in/out
) : LongBool; stdcall; external 'advapi32.dll';

function CryptImportKey(
        hProv: HCRYPTPROV;      // in
        pbData: Pointer;        // in
        dwDataLen: Longword;    // in
        hPubKey: HCRYPTKEY;     // in
        dwFlags: Longword;      // in
        var hKey: HCRYPTKEY     // out
) : LongBool; stdcall; external 'advapi32.dll';

function CryptEncrypt(
        hKey: HCRYPTPROV;       // in
        hHash: HCRYPTHASH;      // in
        Final: LongBool;        // in
        dwFlags: Longword;      // in
        pbData: Pointer;        // in/out
        var cbData: Longword;   // in/out
        cbBuffer: Longword      // in
) : LongBool; stdcall; external 'advapi32.dll';

function CryptDecrypt(
        hKey: HCRYPTKEY;        // in
        hHash: HCRYPTHASH;      // in
        Final: LongBool;        // in
        dwFlags: Longword;      // in
        pbData: Pointer;        // in/out
        var pcbData: Longword   // in/out
) : LongBool; stdcall; external 'advapi32.dll';



implementation
{$B-} (* short circuit *)

constructor THogeCryptAuto.Create;
begin
  FCryptAlg  := CALG_RC2;
  FBlockSize := 8;
  FHashAlg   := CALG_MD5;
  FBufSize   := 1024;       (* MUST be multiple of FBlockSize *)
  FErrorCode := 0;
  FErrorStr  := '';
  FMaxBlobSize := 1024 * 1024;
end;

destructor THogeCryptAuto.Destroy;
begin
end;

function THogeCryptAuto.Encrypt(inputStream: TStream; const password: string;
                                outputStream: TStream): boolean;
var
  hProv: HCRYPTPROV;
  hKey: HCRYPTKEY;
  hXKey: HCRYPTKEY;
  hHash: HCRYPTHASH;
  dwLen: Longword;
  pBlob: Pointer;
  pBuffer: Pointer;
  dwSize: cardinal;
  Final: boolean;
begin
  FErrorCode := 0;
  FErrorStr  := '';
  result := false;
  if FBufSize <= 0 then
    exit;
  hProv := 0;
  hKey := 0;
  hXKey := 0;
  hHash := 0;
  pBlob := nil;
  pBuffer := nil;
  try
    if (not CryptAcquireContext(hProv, nil, nil, PROV_RSA_FULL, 0)) and
       (not CryptAcquireContext(hProv, nil, nil, PROV_RSA_FULL,
                                CRYPT_NEWKEYSET)) then
      raise Exception.Create('CryptAcquireContext');
    if length(password) <= 0 then
    begin
      if not CryptGenKey(hProv, FCryptAlg, CRYPT_EXPORTABLE, hKey) then
        raise Exception.Create('CryptGenKey');
      if (not CryptGetUserKey(hProv, AT_KEYEXCHANGE, hXKey)) then
      begin
        if GetLastError <> Longword(NTE_NO_KEY) then
          raise Exception.Create('CryptGetUserKey');
        if (not CryptGenKey(hProv, AT_KEYEXCHANGE, 0, hXKey)) then
          raise Exception.Create('CryptGenKey 2');
      end;
      if not CryptExportKey(hKey, hXKey, SIMPLEBLOB, 0, nil, dwLen) then
        raise Exception.Create('CryptExportKey 1');
      GetMem(pBlob, dwLen);
      if not CryptExportKey(hKey, hXKey, SIMPLEBLOB, 0, pBlob, dwLen) then
        raise Exception.Create('CryptExportKey 2');
      CryptDestroyKey(hXKey);
      hXKey := 0;
      outputStream.WriteBuffer(dwLen, SizeOf(dwLen));
      outputStream.WriteBuffer(pBlob^, dwLen);
    end
    else begin
      if not CryptCreateHash(hProv, FHashAlg, 0, 0, hHash) then
        raise Exception.Create('CryptCreateHash');
      if not CryptHashData(hHash, PChar(password), length(password), 0) then
        raise Exception.Create('CryptHashData');
      if not CryptDeriveKey(hProv, FCryptAlg, hHash, 0, hKey) then
        raise Exception.Create('CryptDeriveKey');
      CryptDestroyHash(hHash);
      hHash := 0;
    end;
    dwLen := FBufSize + FBlockSize;
    GetMem(pBuffer, dwLen);
    repeat
      dwSize := inputStream.Read(pBuffer^, FBufSize);
      Final := (inputStream.Size <= inputStream.Position);
      if not CryptEncrypt(hKey, 0, Final, 0,
                          pBuffer, dwSize, dwLen) then
        raise Exception.Create('CryptEncrypt');
      outputStream.WriteBuffer(pBuffer^, dwSize);
    until Final;
    result := true;
  except
    on e: Exception do
    begin
      FErrorCode := Windows.GetLastError;
      FErrorStr := e.Message;
    end;
  end;
  if pBuffer <> nil then Dispose(pBuffer);
  if pBlob <> nil then Dispose(pBlob);
  if hHash <> 0 then CryptDestroyHash(hHash);
  if hXKey <> 0 then CryptDestroyKey(hXKey);
  if hKey <> 0 then CryptDestroyKey(hKey);
  if hProv <> 0 then CryptReleaseContext(hProv, 0);
end;

function THogeCryptAuto.Decrypt(inputStream: TStream; const password: string;
                                outputStream: TStream): boolean;
var
  hProv: HCRYPTPROV;
  hKey: HCRYPTKEY;
  hXKey: HCRYPTKEY;
  hHash: HCRYPTHASH;
  dwLen: Longword;
  pBlob: Pointer;
  pBuffer: Pointer;
  dwSize: cardinal;
  Final: boolean;
begin
  FErrorCode := 0;
  FErrorStr  := '';
  result := false;
  if FBufSize <= 0 then
    exit;
  hProv := 0;
  hKey := 0;
  hXKey := 0;
  hHash := 0;
  pBlob := nil;
  pBuffer := nil;
  try
    if (not CryptAcquireContext(hProv, nil, nil, PROV_RSA_FULL, 0)) and
       (not CryptAcquireContext(hProv, nil, nil, PROV_RSA_FULL,
                                CRYPT_NEWKEYSET)) then
      raise Exception.Create('CryptAcquireContext');
    if length(password) <= 0 then
    begin
      dwSize := inputStream.Read(dwLen, SizeOf(dwLen));
      if dwSize <> SizeOf(dwLen) then
        raise Exception.Create('invalid size');
      if FMaxBlobSize < dwLen then
        raise Exception.Create('too large'); 
      GetMem(pBlob, dwLen);
      dwSize := inputStream.Read(pBlob^, dwLen);
      if dwSize <> dwLen then
        raise Exception.Create('invalid size');
      if not CryptImportKey(hProv, pBlob, dwSize, 0, 0, hKey) then
        raise Exception.Create('CryptImportKey');
    end
    else begin
      if not CryptCreateHash(hProv, FHashAlg, 0, 0, hHash) then
        raise Exception.Create('CryptCreateHash');
      if not CryptHashData(hHash, PChar(password), length(password), 0) then
        raise Exception.Create('CryptHashData');
      if not CryptDeriveKey(hProv, FCryptAlg, hHash, 0, hKey) then
        raise Exception.Create('CryptDeriveKey');
      CryptDestroyHash(hHash);
      hHash := 0;
    end;
    dwLen := FBufSize + FBlockSize;
    GetMem(pBuffer, dwLen);
    repeat
      dwSize := inputStream.Read(pBuffer^, FBufSize);
      Final := (inputStream.Size <= inputStream.Position);
      if not CryptDecrypt(hKey, 0, Final, 0, pBuffer, dwSize) then
        raise Exception.Create('CryptDecrypt');
      outputStream.WriteBuffer(pBuffer^, dwSize);
    until Final;
    result := true;
  except
    on e: Exception do
    begin
      FErrorCode := Windows.GetLastError;
      FErrorStr := e.Message;
    end;
  end;
  if pBuffer <> nil then Dispose(pBuffer);
  if pBlob <> nil then Dispose(pBlob);
  if hHash <> 0 then CryptDestroyHash(hHash);
  if hXKey <> 0 then CryptDestroyKey(hXKey);
  if hKey <> 0 then CryptDestroyKey(hKey);
  if hProv <> 0 then CryptReleaseContext(hProv, 0);
end;

end.

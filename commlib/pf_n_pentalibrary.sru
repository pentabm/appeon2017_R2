HA$PBExportHeader$pf_n_pentalibrary.sru
$PBExportComments$$$HEX6$$0cd3ccc604d508b884c72000$$ENDHEX$$DLL $$HEX17$$78c680bd68d518c2200038d69ccda9c6200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$. $$HEX3$$a8bae0b42000$$ENDHEX$$DLL $$HEX25$$68d518c2200038d69ccd40c7200074c7200024c60cbe1dc8b8d27cb92000b5d174d5200074c7e8b8b4c52000d1c9c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_pentalibrary from nonvisualobject
end type
end forward

global type pf_n_pentalibrary from nonvisualobject autoinstantiate
end type

type prototypes
function integer pf_Seed128Encrypt(string UserKey, string PlainText, Ref string EncrypedText) library "pentalib.dll" alias for "pf_Seed128Encrypt;Ansi"
function integer pf_Seed128Decrypt(string UserKey, string EncryptedText, Ref string PlainText) library "pentalib.dll" alias for "pf_Seed128Decrypt;Ansi"
function integer pf_SHA256Hash(string lpszPlainText, ref string lpszHashedText) library "pentalib.dll" alias for "pf_SHA256Hash;Ansi"
function boolean pf_MD5Hash(string lpszPlainText, ref string lpszHashedText) library "pentalib.dll" alias for "pf_MD5Hash;Ansi"

function long pf_CompositeBackgroundImage(string as_sourceImagePath, string as_targetImagePath, string as_backgroundImagePath, long ai_backgroundtop, long ai_backgroundleft) library "pentalib.dll" alias for "pf_CompositeBackgroundImage;Ansi"
function long pf_CropImage(string as_sourceImagePath, string as_targetImagePath, long ai_left, long ai_top, long ai_width, long ai_height) library "pentalib.dll" alias for "pf_CropImage;Ansi"
function boolean pf_DWCacheRead(string lpsFileName, string lpsUserKey, ref blob bDWSyntax, ref long nDWLength) library "pentalib.dll" alias for "pf_DWCacheRead;Ansi"
function boolean pf_DWCacheWrite(string lpsFileName, string lpsUserKey, ref blob bDWSyntax, long nDWLength) library "pentalib.dll" alias for "pf_DWCacheWrite;Ansi"
function boolean pf_GetFileWriteTime(string lpszFileName, ref string lpszWriteTime) library "pentalib.dll" Alias For "pf_GetFileWriteTime;Ansi"
function boolean pf_SetFileWriteTime(string lpszFileName, string lpszWriteTime) library "pentalib.dll" Alias For "pf_SetFileWriteTime;Ansi"
function long pf_GetImageSize(string lpctImagePath, ref pf_s_size imageSize) library "pentalib.dll" alias for "pf_GetImageSize;Ansi"
function long pf_GetTextSize(ulong hWnd, string szText, string szFontFace, long fontSize, long fontWeight, ref pf_s_size textSize) library "pentalib.dll" alias for "pf_GetTextSize;Ansi"
function long pf_GetTextSizeW(ulong hWnd, string szText, string szFontFace, long fontSize, long fontWeight, ref pf_s_size textSize) library "pentalib.dll" alias for "pf_GetTextSizeW"
function long pf_GetTextSizeEX(ulong hWnd, string szText, string szFontFace, int fontSize, int fontWeight, ulong fdwFamily, ulong fdwPitch, ulong  fdwCharSet, ref pf_s_size textSize) library "pentalib.dll" alias for "pf_GetTextSizeEX;Ansi"
function long pf_StringToHex(string input, ref string output) library "pentalib.dll" alias for "pf_StringToHex;Ansi"
function long pf_HexToString(string input, ref string output) library "pentalib.dll" alias for "pf_HexToString;Ansi"
function int pf_MakeCommandButtonOverlayImage(string szSourceImage, string szTargetImage, int nCBWidth, int nCBHeight, string szCBText, int nFontSize, int nFontWeight, ulong nFontColor, ulong fdwItalic, ulong fdwUnderline, ulong fdwCharSet, ulong fdwPitch, ulong fdwFamily, string szFontFace) library "pentalib.dll" alias for "pf_MakeCommandButtonOverlayImage;Ansi"
function int pf_MakeCommandButtonOverlayImageW(string szSourceImage, string szTargetImage, int nCBWidth, int nCBHeight, string szCBText, int nFontSize, int nFontWeight, ulong nFontColor, ulong fdwItalic, ulong fdwUnderline, ulong fdwCharSet, ulong fdwPitch, ulong fdwFamily, string szFontFace) library "pentalib.dll" alias for "pf_MakeCommandButtonOverlayImageW"
function int pf_MakeCommandButtonImageW(string szSourceImage, string szTargetImage, int nCBWidth, int nCBHeight, string szCBText, int nFontSize, int nFontWeight, ulong nFontColor, ulong fdwItalic, ulong fdwUnderline, ulong fdwCharSet, ulong fdwPitch, ulong fdwFamily, string szFontFace, string szIconFile) library "pentalib.dll" alias for "pf_MakeCommandButtonImageW"
function long pf_MakeMouseoverButtonImage(string source_img_path, string target_img_path) library "pentalib.dll" alias for "pf_MakeMouseoverButtonImage;Ansi"
function long pf_MakeClickedButtonImage(string source_img_path, string target_img_path) library "pentalib.dll" alias for "pf_MakeClickedButtonImage;Ansi"
function long pf_MakeDisabledButtonImage(string source_img_path, string target_img_path) library "pentalib.dll" alias for "pf_MakeDisabledButtonImage;Ansi"
function long pf_MakeGradientBackgroundImage(string target_img_path, int obj_width, int obj_height) library "pentalib.dll" alias for "pf_MakeGradientBackgroundImage;Ansi"
function long pf_MakePictureButtonImage(string icon_name, string target_img_path, long button_width, long button_height, boolean enabled) library "pentalib.dll" alias for "pf_MakePictureButtonImage;Ansi"
function boolean pf_MakeBackgroundTransparent(ulong hWnd, ref pf_s_rect srect, string lpszSourcePath, string lpszTargetPath) library "pentalib.dll" alias for "pf_MakeBackgroundTransparent;Ansi"
function long pf_ResizeImage4PB(string as_sourceImagePath, string as_targetImagePath, long basePixelX, long basePixelY, long resizeWidth, long resizeHeight) library "pentalib.dll" alias for "pf_ResizeImage4PB;Ansi"
function long pf_SetMDIClientBorder(ulong hWnd, long index ) library "pentalib.dll" Alias For "pf_SetMDIClientBorder;Ansi"
function long pf_SetSystemColor(ulong a1, ulong a2, ulong a3, ulong a4, ulong a5, ulong a6, ulong a7, ulong a8, ulong a9, ulong a10, ulong a11, ulong a12, ulong a13, ulong a14, ulong a15, ulong a16, ulong a17, ulong a18, ulong a19, ulong a20, ulong a21, ulong a22, ulong a23, ulong a24, ulong a25, ulong a26, ulong a27, ulong a28, ulong a29, ulong a30) library "pentalib.dll" alias for "pf_SetSystemColor;Ansi"
function long pf_UriEncode(blob input, ref string output) library "pentalib.dll" alias for "pf_UriEncode;Ansi"
function long pf_UriDecode(string input, ref blob output) library "pentalib.dll" alias for "pf_UriDecode;Ansi"
function boolean pf_WINTransparentColor(ulong hWnd, long trspColor, byte alpha, boolean state) library "pentalib.dll" alias for "pf_WINTransparentColor;Ansi"
function boolean pf_WINRoundRect(ulong hWnd, int x1, int y1, int x2, int y2, int x3, int y3) library "pentalib.dll" alias for "pf_WINRoundRect;Ansi"
function long pf_URLDownloadToFile(string lpszURL, string lpszLocalFile) library "pentalib.dll" alias for "pf_URLDownloadToFile;Ansi"

function uint pf_BitwiseOR_uint(uint op1, uint op2) library "pentalib.dll"
function ulong pf_BitwiseOR_ulong(ulong op1, ulong op2) library "pentalib.dll"
function uint pf_BitwiseAND_uint(uint op1, uint op2) library "pentalib.dll"
function ulong pf_BitwiseAND_ulong(ulong op1, ulong op2) library "pentalib.dll"
function uint pf_BitwiseXOR_uint(uint op1, uint op2) library "pentalib.dll"
function ulong pf_BitwiseXOR_ulong(ulong op1, ulong op2) library "pentalib.dll"
function uint pf_BitwiseNOT_uint(uint op1) library "pentalib.dll"
function ulong pf_BitwiseNOT_ulong(ulong op1) library "pentalib.dll"
function uint pf_BitwiseRShift_uint(uint op1, int cnt) library "pentalib.dll"
function ulong pf_BitwiseRShift_ulong(ulong op1, int cnt) library "pentalib.dll"
function uint pf_BitwiseLShift_uint(uint op1, int cnt) library "pentalib.dll"
function ulong pf_BitwiseLShift_ulong(ulong op1, int cnt) library "pentalib.dll"

function string pf_ReplaceAll(string lpszOriginal, string lpszPattern, string lpszReplacement) library "pentalib.dll" alias for "pf_ReplaceAll;Ansi"
function boolean pf_GetPBControlBackgroundImage(ulong hWnd, ref pf_s_rect srect, string lpszTargetPath) library "pentalib.dll" alias for "pf_GetPBControlBackgroundImage;Ansi"
function long pf_EnableSendMessage() library "pentalib.dll" alias for "pf_EnableSendMessage;Ansi"
function long pf_DisableSendMessage() library "pentalib.dll" alias for "pf_DisableSendMessage;Ansi"
function long pf_CreateHooks() library "pentalib.dll" alias for "pf_DisableSendMessage;Ansi"
function long pf_GetHostName(ref string hostname,long length) library "pentalib.dll" alias for "pf_GetHostName;Ansi"
function long pf_GetIPAddress(ref string ipaddress,long length) library "pentalib.dll" alias for "pf_GetIPAddress;Ansi"
function long pf_GetMacAddress(ref string macaddress,long length) library "pentalib.dll" alias for "pf_GetMacAddress;Ansi"
function long pf_ClipboardToBitmap(string lpFileName) library "pentalib.dll" alias for "pf_ClipboardToBitmap;Ansi"

function ulong pf_Compress(ref blob bTarget, ulong nTargetSize, ref blob bSource, ulong nSourceSize) library "pentalib.dll" alias for "pf_Compress"
function ulong pf_Uncompress(ref blob bTarget, ulong nTargetSize, ref blob bSource, ulong nSourceSize) library "pentalib.dll" alias for "pf_Uncompress"
function ulong pf_compressfile(string lpszSource, string lpszDestination) library "pentalib.dll" alias for "pf_compressfile;Ansi"
function ulong pf_uncompressfile(string lpszSource, string lpszDestination) library "pentalib.dll" alias for "pf_uncompressfile;Ansi"

function int pf_http_filedownload(string lpszURL, string lpszFilename) library "pentalib.dll" alias for "pf_http_filedownload;Ansi"
function int pf_http_fileupload(string lpszURL, string lpszFilename) library "pentalib.dll" alias for "pf_http_fileupload;Ansi"
function int pf_http_post_request(string lpszDownloadURL, string lpszPostFields, string lpszSaveAsFilename) library "pentalib.dll" alias for "pf_http_post_request;Ansi"
function int pf_http_multipart_upload(ulong hWnd, string lpszDownloadURL, string lpszPostFields, string lpszFilename) library "pentalib.dll" alias for "pf_http_multipart_upload;Ansi"
function ulong pf_getfilesize(string lpszFilename) library "pentalib.dll" alias for "pf_getfilesize;Ansi"

function int pf_http_globalinit() library "pentalib.dll"
function int pf_http_addformfield(int nFormType, string lpszItemName, string lpszItemValue) library "pentalib.dll" alias for "pf_http_addformfield;Ansi"
function int pf_http_setpostfields(string lpszPostFields) library "pentalib.dll" alias for "pf_http_setpostfields;Ansi"
function int pf_http_addhttpheader(string lpszHeader) library "pentalib.dll" alias for "pf_http_addhttpheader;Ansi"
function int pf_http_openupload(string lpszURL, string lpszFilename) library "pentalib.dll" alias for "pf_http_openupload;Ansi"
function int pf_http_opendownload(string lpszURL, string lpszFilename) library "pentalib.dll" alias for "pf_http_opendownload;Ansi"
function int pf_http_send() library "pentalib.dll"
function int pf_http_checkrunningstatus() library "pentalib.dll"
function double pf_http_uploadprogress_now() library "pentalib.dll"
function double pf_http_uploadprogress_total() library "pentalib.dll"
function double pf_http_downloadprogress_now() library "pentalib.dll"
function double pf_http_downloadprogress_total() library "pentalib.dll"
function string pf_http_getresponsefromupload() library "pentalib.dll" alias for "pf_http_getresponsefromupload;Ansi"
function int pf_http_close() library "pentalib.dll"
function int pf_http_abort() library "pentalib.dll"
function int pf_http_getresultcode() library "pentalib.dll"
function string pf_http_geterrormessage(int nErrorNumb) library "pentalib.dll" alias for "pf_http_geterrormessage;Ansi"
function string pf_http_getlasterror() library "pentalib.dll" alias for "pf_http_getlasterror;Ansi"
function int pf_http_globalcleanup() library "pentalib.dll"

function boolean pf_http_ping(string lpszURL, uint nTimeout) library "pentalib.dll" alias for "pf_http_ping;Ansi"
function int pf_http_escape(string lpszURL, ref string lpszescaped) library "pentalib.dll" alias for "pf_http_escape;Ansi"
function int pf_http_unescape(string lpszURL, ref string lpszUnescaped) library "pentalib.dll" alias for "pf_http_unescape;Ansi"
function int pf_http_speedupload(ref double nBytesPerSec) library "pentalib.dll"
function int pf_http_speeddownload(ref double nBytesPerSec) library "pentalib.dll"
function long pf_http_getinfo_long(int nInfoType) library "pentalib.dll"
function double pf_http_getinfo_double(int nInfoType) library "pentalib.dll"
function string pf_http_getinfo_char(int nInfoType) library "pentalib.dll"
function int pf_RescaleImage(string sourceImage, int imageWidth, int imageHeight, string resizedImage) library "pentalib.dll" alias for "pf_RescaleImage;Ansi"
function int pf_ConvertImageFormat(string sourceImage, string targetImage) library "pentalib.dll" alias for "pf_ConvertImageFormat;Ansi"
function int pf_ConvertWMFtoBMP(string sourceImage, string targetImage) library "pentalib.dll" alias for "pf_ConvertWMFtoBMP;Ansi"
function int pf_http_sendmail(string szURL, string szAddFiles[10], int nFileCnt) library "pentalib.dll" alias for "pf_http_sendmail;Ansi"

// Kernel32.dll
function ULong GetTempPath (ULong nBufferLength, Ref String lpBuffer) library "kernel32.dll" Alias For "GetTempPathA;Ansi"
function ULong GetLongPathName(Ref String lpszShortPath, Ref String lpszLongPath, ULong cchBuffer ) library "kernel32.dll" Alias For "GetLongPathNameA;Ansi"
function Boolean SetCurrentDirectory(ref string lpsdir) library "Kernel32.dll" Alias For "SetCurrentDirectoryA;Ansi"
function Long GetModuleHandle(String modulename) library "kernel32.dll" Alias for "GetModuleHandleA;Ansi"
function Boolean CreateDirectory(ref string pathname,integer sa) library "kernel32.dll" Alias For "CreateDirectoryA;Ansi"
function ULong GetCurrentDirectoryA (ulong cchCurDir, ref string lpszCurDi) library "kernel32.dll" alias for "GetCurrentDirectoryA;Ansi"
function ULong SetCurrentDirectoryA (string lpszCurDi) library "kernel32.dll" alias for "SetCurrentDirectoryA;Ansi"
function ULong GetWindowsDirectoryA (ref string wdir, ulong buf) library "kernel32.dll" alias for "GetWindowsDirectoryA;Ansi"
subroutine Sleep(ulong millisecond) library "Kernel32.dll"
function boolean GetComputerName (Ref string buffer, Ref long buflen) Library "kernel32.dll" Alias For "GetComputerNameA;Ansi"
function ulong GetLastError() Library "kernel32.dll"
function ulong FormatMessage(ulong dwFlags, ulong lpSource, ulong dwMessageId, 	ulong dwLanguageId, Ref string lpBuffer, ulong nSize, ulong Arguments) Library "kernel32.dll" Alias For "FormatMessageA;Ansi"

// User32.dll
function boolean GetCursorPos(Ref pf_s_point mousepos) library "User32.dll"
function long GetClassName(ulong hwnd, ref string cname, int buf) library "User32.dll" Alias For "GetClassNameA;Ansi"
function long SetWindowLong(ULong hWnd, ULong offset, ULong attributes) library 'user32.dll' Alias For "SetWindowLongA;Ansi"
function long GetWindowLong(ULong hWnd, int nIndex) library 'user32.dll' Alias For "GetWindowLongA;Ansi"
function long SetLayeredWindowAttributes(ULong hWnd, ULong colorref, Char Transparency, ULong flag) library 'user32.dll'
function boolean ReleaseCapture() library "user32.dll"
function long SetCapture(long hWnd) library "user32.dll"
function boolean ScreenToClient(ulong hWnd, Ref pf_s_point lpPoint) library "user32.dll"
function ulong SetParent (ulong hChild, ulong hParent) library "user32.dll"
function ulong GetParent (ulong hChild) library "user32.dll"
function uint SetFocus(int winHand) library "user32.dll" 
function uint FindWindow(Ulong className, string winName) library "user32.dll" Alias For "FindWindowA;Ansi"
function boolean CloseWindow(ulong w_handle) library "user32.dll"
function boolean DestroyWindow(ulong w_handle) library "user32.dll"
subroutine keybd_event(int bVk, int bScan, int dwFlags, int dwExtraInfo) library "user32.dll"
function long GetDesktopWindow() library "user32" alias for "GetDesktopWindow;Ansi"
function long GetWindow( long hWnd, long uCmd ) library "user32" alias for "GetWindow;Ansi"
function long GetClassNameA ( long hWnd, Ref String lpClassName, long nMaxCount ) library "user32" alias for "GetClassNameA;Ansi"
function long GetWindowTextA ( long hWnd, Ref String lpString, long nMaxCount ) library "user32" alias for "GetWindowTextA;Ansi"
function long SetTimer(Long hwnd, long idTimer, Long uTimeOut, Long tmprc) Library "user32.dll"
function long KillTimer(Long hwnd, Long idEvent) Library "user32.dll" 
function integer GetSystemMetrics (integer nIndex) Library "user32.dll"
function long MonitorFromWindow (Long hwnd, Long dwFlags) Library "user32"
function long GetMonitorInfo (long hMonitor, ref pf_s_tagmonitorinfo moninfo) Library "user32"  alias for "GetMonitorInfoA"
function boolean SetForegroundWindow(long hWnd) Library "user32"  alias for "SetForegroundWindow"
function boolean ShowWindow (ulong hWnd, int nCmdShow) library "user32.DLL"

// Shlwapi.dll
function Boolean PathRemoveFileSpec(Ref String pszPath) library "shlwapi.dll" Alias For "PathRemoveFileSpecA;Ansi"
subroutine PathStripPath(Ref String pszPath) library "shlwapi.dll" Alias For "PathStripPathA;Ansi"

// Wininet.dll
function Boolean InternetCanonicalizeUrl(String lpszUrl, Ref String lpszBuffer, Ref Long lpdwBufferLength, long dwFlags) library "Wininet.dll" Alias for "InternetCanonicalizeUrlA;Ansi"

// Shell32.dll
function long ShellExecute (uint  ihwnd,string  lpszOp, string lpszFile, string lpszParams, string lpszDir, int  wShowCmd) library "shell32.dll" Alias For "ShellExecuteA;Ansi" 
function long ShellExecuteEx(REF pf_s_shellexecuteinfo lpExecInfo) library "shell32.dll" Alias For "ShellExecuteA;Ansi"

// Imm32.dll
function Long ImmGetContext( long handle ) library "imm32.dll"
function Long ImmSetConversionStatus( long hlMC,long fFlag,long cFlag) library "imm32.dll"
function Long ImmReleaseContext( long handle,long hlMC) library "imm32.dll"

// Gdi32.dll
function long GetDC(long hwnd) library "user32.dll"
function long CreateCompatibleDC(long hdc) library "gdi32.dll"
function boolean ReleaseDC(long hwnd, long hdc)library "user32.dll"
function boolean DeleteDC(long hdc) library "gdi32.dll"
function long SelectObject(long hdc, long handle) library "gdi32.dll"
function long CreateCompatibleBitmap(long hdc, int nWidth, int nHeight) library "gdi32.dll"
function long CreateBitmap(long w, long h, long panels, long bits, long data) library "gdi32.dll"
function boolean BitBlt(long hdcDest, long nXDest, long nYDest, long nWidth, long nHeight, long hdcSrc,long nXSrc, long nYSrc, long dwRop) library "gdi32.dll"
function boolean DeleteObject(long hObject)library "gdi32.dll"
function long CreateSolidBrush(long crColor) library "gdi32.dll"
function long SetBkMode(long hdc,int iBkMode) library "gdi32.dll"
function long SetBkColor(long hdc, long crColor) library "gdi32.dll"
function long SetTextColor(long hdc, long crColor) library "gdi32.dll"
function ulong GetStockObject(ulong nIndex) library "gdi32.dll"
function long SetDCPenColor(ulong hdc,ulong color) library "gdi32.dll"
function long SetDCBrushColor(ulong hdc,ulong color) library "gdi32.dll"

function Integer GlobalAddAtom (ref string lpString) library "kernel32.dll" ALIAS FOR "GlobalAddAtomA" 
function ulong RegisterHotKey (ulong hwnd, ulong id, ulong fsModifiers, ulong vk) library "user32.dll" 

// Odbc32.dll
Function integer SQLGetInfo (long hconn, integer infotype, ref string infotypeptr, integer bufferlength, ref integer bufferlengthptr) Library "odbc32.dll" Alias For "SQLGetInfo;Ansi"

//// Shell FUNCTIONs
//subroutine SHAddToRecentDocs( ulong uFlags, Ref String pV ) library "shell32.dll" alias for "SHAddToRecentDocs;Ansi" 
//function long SHBrowseForFolder( Ref BROWSEINFO lpBi ) library "shell32.dll" alias for "SHBrowseForFolder;Ansi"
//function boolean SHGetPathFromIDList( long pIDL, ref String pszPath) library "shell32.dll" Alias For "SHGetPathFromIDListA;Ansi"
//function long SHFileOperation( Ref SHFILEOPSTRUCT lpFileOp ) library "shell32.dll" Alias For "SHFileOperationA;Ansi"
//function long SHGetSpecialFolderLocation( long hwndOwner, long nFolder, Ref Long ppidl ) library "shell32.dll"
//function long SHFormatDrive( ulong hWnd, ulong iDrive, ulong iCapacity, ulong iType ) library "shell32.dll"
//function long CoTaskMemFree( long pv ) library "ole32.dll"
//// Memory FUNCTIONs
//function long RtlMoveMemory(REF Char Destination[], long Source, long Size) library "kernel32" alias for "RtlMoveMemory"
//function long RtlMoveMemory(long Destination, REF Char Source[], long Size) library "kernel32" alias for "RtlMoveMemory"
//function long LocalAlloc(long Flags, long Bytes) library "kernel32"
//function long LocalFree(long MemHandle) library "kernel32"
//function long Lstrcpy(long Destination, string Source) library "kernel32.dll" ALIAS FOR "lstrcpyA;Ansi"
//function long lstrcpy(long Destination, ref char Source[]) library "kernel32.dll" alias for "lstrcpy;Ansi"
//subroutine GetMinMaxInfo ( ref minmaxinfo d, long s, long l ) library 'kernel32.dll' alias for "RtlMoveMemory"
//subroutine SetMinMaxInfo ( long d, minmaxinfo s, long l ) library 'kernel32.dll' alias for "RtlMoveMemory"
//function long Loadlibrary(ref string lpLibFileName) library "kernel32.dll" ALIAS FOR "LoadlibraryA;Ansi"
//function long Freelibrary(long hLibModule) library "kernel32.dll"
//function long GetDevMode(REF DEVMODE Destination, long Source, long Size) library "kernel32.dll" Alias For "RtlMoveMemory"
//function long GetDevNames(REF DEVNAMES Destination, long Source, long Size) library "kernel32.dll" Alias For "RtlMoveMemory"
//function long GetLogFont(REF LOGFONT Destination, long Source, long Size) library "kernel32.dll" Alias For "RtlMoveMemory"
//function long PutLogFont(long Destination, REF LOGFONT Source, long Size) library "kernel32.dll" Alias For "RtlMoveMemory"
//function long StrCopy(long Destination, REF string Source, long Size) library "kernel32.dll"  Alias for "RtlMoveMemory"
//function long CommDlgExtendedError() library "comdlg32.dll"
//function long LocalLock(long Handle) library "kernel32.dll"
//function long LocalUnlock(long Handle) library "kernel32.dll"
//// Directory FUNCTIONs
//function ulong GetModuleFileName (ulong hinstModule, ref string lpszPath, ulong cchPath ) library "KERNEL32.DLL" Alias for "GetModuleFileNameA;Ansi"
//function long CreateDirectory(ref string lpPathName,ref SECURITY_ATTRIBUTES lpSecurityAttributes) library "kernel32.dll" ALIAS FOR "CreateDirectoryA;Ansi"
//function ulong GetLongPathName(string nShort,ref string nLong, ulong buffer) library "kernel32.dll" ALIAS FOR "GetLongPathNameA;Ansi"
//function long GetWindowsDirectory(REF string Buffer, long Size) library "kernel32.dll" ALIAS FOR "GetWindowsDirectoryA;Ansi"
//// File FUNCTIONs
//function long FindFirstFile(string FileName, ref WIN32_FIND_DATA FindFileData ) library "kernel32.dll" Alias for "FindFirstFileA;Ansi"
//function integer FindNextFile ( ulong FindFile, ref WIN32_FIND_DATA FindFileData ) library "kernel32.dll" Alias for "FindNextFileA;Ansi"
//function integer FindClose( ulong FindFile ) library "kernel32.dll"
//function long SearchPath ( ref string Path, ref string FileName, ref string Extension, ulong BufferLength, ref string Buffer, ref integer FilePart ) library  "kernel32.dll" Alias for "SearchPathA;Ansi"
//function ulong FindFirstFileEx(ref string lpFileName, integer finfolevelid, ref WIN32_FIND_DATA lpFindFileData, long fsearchop, long lpsearchfilter, long dwadditionalflags) library "kernel32.dll" ALIAS FOR "FindFirstFileExA;Ansi"
//function ulong GetTempFileName(ref string lpszPath,ref string lpPrefixString,ulong wUnique,ref string lpTempFileName) library "kernel32.dll" ALIAS FOR "GetTempFileNameA;Ansi"
//function ulong GetTempPath(ulong nBufferLength,ref string lpBuffer) library "kernel32.dll" ALIAS FOR "GetTempPathA;Ansi"
////Drawing FUNCTIONs
//function boolean DrawEdge( long hdc, ref rect rc, long edge, long grflags ) library "USER32.DLL" alias for "DrawEdge;Ansi" 
//function Ulong BeginPaint(long hwnd, ref PAINTSTRUCT pstr) library "USER32.DLL" alias for "BeginPaint;Ansi" 
//function Boolean EndPaint(long hwnd, ref PAINTSTRUCT pstr) library "USER32.DLL" alias for "EndPaint;Ansi" 
//function Boolean Polygon(ulong hdc, ref POINT ppoint[], int count) library "GDI32.DLL"
//function ulong CreatePolygonRgn(ref POINT ppoint[], int count, int fillMode) library "GDI32.DLL"
//function long SelectClipRgn(ulong hdc, ulong hrgn) library "GDI32.DLL"
//// Window FUNCTIONs
//function ulong InvalidateRect(ulong hwnd,ref RECT lpRect,boolean bErase) library "user32.dll" alias for "InvalidateRect;Ansi"
//function ulong InvalidateRect(ulong hwnd,ref long lpRect,boolean bErase) library "user32.dll"
//function ulong MoveWindow(ulong hwnd,ulong x,ulong y,ulong nWidth,ulong nHeight,ulong bRepaint) library "user32.dll"
//function long SendMessageString( long hWindow, uint Msg, ulong wParam, Ref string szText ) library 'user32' alias for 'SendMessageA;Ansi'
//function long GetDC (ulong hWnd) library "USER32.DLL"
//function int ReleaseDC (ulong hWnd, ulong hDC) library "USER32.DLL"
//function ulong IsWindow(ulong hwnd) library "user32.dll"
//function ulong FindWindow ( ref string lpClassName, ref string lpWindowName) library "USER32.DLL" Alias for "FindWindowA;Ansi"
//function ulong GetWindowRect ( ulong hwnd, ref rect lprect) library "USER32.DLL" alias for "GetWindowRect;Ansi" 
//function boolean GetClientRect (ulong hWnd, ref RECT lpRect) library "USER32.DLL" alias for "GetClientRect;Ansi"
//function ulong GetSystemMetrics(ulong nIndex) library "user32.dll"
//function long SetWindowLong(long hwnd,long nIndex,long dwNewLong) library "user32.dll" ALIAS FOR "SetWindowLongA"
//function long GetWindowLong(long hwnd,long nIndex) library "user32.dll" ALIAS FOR "GetWindowLongA"
//function ulong SetParent(ulong hWndChild,ulong hWndNewParent) library "user32.dll"
//function long CreateWindowEx( ulong dwExStyle, string lpClassName, string lpWindowName, ulong dwStyle, long xPos, long yPos, long nWidth, long nHeight, long hWndParent, long hMenu, long hInstance, long lpParam ) library "user32" ALIAS FOR "CreateWindowExA;Ansi"
//function boolean DestroyWindow( long hWnd ) library "user32"
//function boolean ShowWindow (ulong hWnd, int nCmdShow) library "USER32.DLL"
//function long MapWindowPoints(long hwndFrom,long hwndTo,ref rect lppt,long cPoints) library "user32.dll" alias for "MapWindowPoints;Ansi"
//function ulong MoveWindow(ulong hwnd,ulong x,ulong y,ulong nWidth,ulong nHeight,Boolean bRepaint) library "user32.dll"
//function ulong UpdateWindow(ulong hwnd) library "user32.dll"
//function ulong GetStockObject(ulong nIndex) library "gdi32.dll"
//function ulong CreateFontIndirect(ref LOGFONT lpLogFont) library "gdi32.dll" ALIAS FOR "CreateFontIndirectA;Ansi"
//function Boolean ClientToScreen(ulong hWnd, Ref POINT lpPoint) library "USER32.DLL" alias for "ClientToScreen;Ansi"
//
////Menu FUNCTIONs
//function ulong GetSystemMenu(ulong hWnd, BOOLEAN bRevert)  library "USER32"
//function boolean DeleteMenu( ulong hMenu, uint uPosition, uint uFlags ) library "user32.dll"
//function boolean DrawMenuBar( ulong hWnd ) library "user32.dll"
////Common Controls
//subroutine InitCommonControls() library "comctl32.dll"
//function boolean InitCommonControlsEx( Ref INITCOMMONCONTROLS LPINITCOMMONCONTROLS) library "comctl32.dll" alias for "InitCommonControlsEx;Ansi"
////function long CreateWindowEx(ulong dwExStyle, string ClassName, long WindowName, ulong dwStyle, ulong X, ulong Y, ulong nWidth, ulong nHeight, ulong hWndParent, ulong hMenu, ulong hInstance, ulong lpParam) library "user32.dll" alias for "CreateWindowExA;Ansi"
//function integer ToolTipMsg(long hWnd, long uMsg, long wParam, REF TOOLINFO ToolInfo) library "user32.dll" Alias For "SendMessageA;Ansi"
//function integer RelayMsg(long hWnd, long uMsg, long wParam, REF MSG Msg) library "user32.dll" Alias For "SendMessageA;Ansi"
//function integer SendPoint(long hWnd, long uMsg, long wParam, REF POINT pt) library "user32.dll" Alias For "SendMessageA;Ansi"
//function integer SendRect(long hWnd, long uMsg, long wParam, REF RECT rt) library "user32.dll" Alias For "SendMessageA;Ansi"
//function integer SendButtonImageList(long hWnd, long uMsg, long wParam, REF BUTTON_IMAGELIST  rt) library "user32.dll" Alias For "SendMessageA;Ansi"
//function integer SendBalloontip(long hWnd, long uMsg, long wParam, REF EDITBALLOONTIP  rt) library "user32.dll" Alias For "SendMessageA;Ansi"
//subroutine GetNMHDR( ref NMHDR d, long s, long l ) library 'kernel32.dll' alias for "RtlMoveMemory"
//subroutine GetNMClick( ref NMMOUSE d, long s, long l ) library 'kernel32.dll' alias for "RtlMoveMemory"
//function long SendMessageItems( long hWnd, long uMsg, long wParam, Ref tbbutton lpst[] ) library "user32" Alias For "SendMessageA;Ansi"
//function long GetButton( long hWnd, long uMsg, long wParam, Ref tbbutton lpst ) library "user32" Alias For "SendMessageA;Ansi"
//function long SendMessageInfo( long hWnd, long uMsg, long wParam, Ref tbbuttoninfo lpst ) library "user32" Alias For "SendMessageA;Ansi"
//function long SendMessageRECT( long hWnd, long uMsg, long wParam, Ref RECT lpst ) library "user32" Alias For "SendMessageA;Ansi"
//function long SendBoolean( long hWnd, long uMsg, long wParam,  Boolean lpst ) library "user32" Alias For "SendMessageA"
//function long SendMessageCharBuffer( long hWnd, long uMsg, long wParam,  ref char lc[]) library "user32" Alias For "SendMessageA;Ansi"
//function long SendMessageSize( long hWnd, long uMsg, long wParam, ref tagsize lpst ) library "user32" Alias For "SendMessageA;Ansi"
//function long SendMessageBand( long hWnd, long uMsg, long wParam, Ref REBARBANDINFO lpst ) library "user32" Alias For "SendMessageA;Ansi"
//function long SendMessageImage( long hWnd, long uMsg, long wParam, Ref lvbkimage lpst ) library "user32" Alias For "SendMessageA;Ansi"
//function long SendMessageNumber( long hWindow, uint Msg, ulong wParam, ulong lParam ) library 'user32' alias for 'SendMessageA'
//function long PtInRect(ref rect rc, point pt) library "user32.dll"
//function long PtInRegion(ulong hrgn, int x, int y) library "GDI32.dll"
////Listview
//function long Sendlvref( long hWnd, long uMsg, long wParam,  ref lvitem lpst ) library "user32" Alias For "SendMessageA;Ansi"
//function long Sendlv( long hWnd, long uMsg, long wParam,  lvitem lpst ) library "user32" Alias For "SendMessageA;Ansi"
//function long SendlvFindInfo( long hWnd, long uMsg, long wParam,  ref lvfindinfo lpst ) library "user32" Alias For "SendMessageA;Ansi"
//// Treeview
//function Long HitMsg(Long hWindow, UInt Msg, Long wParam,  Ref tvhittestinfo lParam) library 'user32.dll' Alias for "SendMessageA;Ansi"
//// Mouse FUNCTIONs
//function ulong SetCapture(ulong hwnd) library "user32.dll"
//function ulong ReleaseCapture() library "user32.dll"
////Path Fucntions
//function Boolean PathCompactPath(long hdc, ref string lpszpath, uint dx) library "shlwapi.dll" ALIAS FOR "PathCompactPathA;Ansi"
//// System FUNCTIONs
//function ulong GetSysColor(ulong nIndex) library "user32.dll"
//subroutine Sleep(ulong dwMilliseconds) library "kernel32.dll"
//// Image/Icon FUNCTIONs
//function ulong ExtractIcon(ulong hInst,string lpszExeFileName,ulong nIconIndex) library "shell32.dll" ALIAS FOR "ExtractIconA;Ansi"
//function long ExtractIconEx( String lpszFile, long nIconIndex, Ref Long phIconLarge[], Ref Long phIconSmall[], long nIcons ) library "shell32.dll" Alias For "ExtractIconExA;Ansi"
//function long DrawIcon(long hdc,long x,long y,long hIcon) library "user32.dll"
//function boolean DrawIconEx(ulong hdc,ulong xLeft,ulong yTop,ulong hIcon,ulong cxWidth,ulong cyWidth,ulong istepIfAniCur,ulong hbrFlickerFreeDraw,ulong diFlags) library "user32.dll"
//function ulong LoadIcon(long hInstance,long lpIconName) library "user32.dll" ALIAS FOR "LoadIconA"
//function ulong DestroyIcon(ulong hIcon) library "user32.dll"
//function ulong LoadImage(ulong hInst,ref string lpsz,ulong un1,ulong n1,ulong n2,ulong un2) library "user32.dll" ALIAS FOR "LoadImageA;Ansi"
//function ulong LoadImage(ulong hInst,long lpsz,ulong un1,ulong n1,ulong n2,ulong un2) library "user32.dll" ALIAS FOR "LoadImageA;Ansi"
//function ulong MAKEINTRESOURCE(int res)  library "user32.dll"
////toolbar FUNCTIONs
//subroutine GetDISP( ref NMTTDISPINFO d, long s, long l ) library 'kernel32.dll' alias for "RtlMoveMemory"
//subroutine SetDISP( long s, ref NMTTDISPINFO d,  long l ) library 'kernel32.dll' alias for "RtlMoveMemory"
//subroutine GetTOOL( ref NMTOOLBAR d, long s, long l ) library 'kernel32.dll' alias for "RtlMoveMemory"
//subroutine SetTOOL( long s, ref NMTOOLBAR d,  long l ) library 'kernel32.dll' alias for "RtlMoveMemory"
////drawing and bitmap FUNCTIONs
//function Boolean GetTextExtentPoint32(ulong hdc, string text, long textLen, ref tagSize lstr) library "gdi32.dll" alias for "GetTextExtentPoint32A;Ansi"
//function Long MulDiv( Long nNumber, Long nNumerator, Long nDenominator ) library "kernel32.dll"
//function ulong MoveToEx(ulong hdc,ulong x,ulong y,ref POINT lpPoint) library "gdi32.dll" alias for "MoveToEx;Ansi"
//function ulong LineTo(ulong hdc,ulong x,ulong y) library "gdi32.dll"
//function ulong CreatePen(ulong nPenStyle,ulong nWidth,ulong crColor) library "gdi32.dll"
//function ulong SelectObject(ulong hdc,ulong hObject) library "gdi32.dll"
//function ulong DeleteObject(ulong hObject) library "gdi32.dll"
//subroutine CopyBitmap( blob b, ulong s, long l ) alias for "RtlMoveMemory;Ansi" library "kernel32.dll"
//subroutine CopyBitmapFileHeader( ref blob b, bitmapheader b, long l ) alias for "RtlMoveMemory;Ansi" library "kernel32.dll"
//subroutine CopyBitmapInfoHeader( ref blob b, bitmapinfoheader b, long l ) alias for "RtlMoveMemory;Ansi" library "kernel32.dll"
//subroutine CopyBitmapInfo( ref blob b, bitmapinfo b, long l ) alias for "RtlMoveMemory;Ansi" library "kernel32.dll"
//function long GetDIBits(ulong hdc, ulong bitmap, ulong start, ulong lines, ref blob bits, ref bitmapinfo i, ulong pallete ) library "gdi32.dll" alias for "GetDIBits;Ansi"
//function long GetDIBits(ulong hdc, ulong bitmap, ulong start, ulong lines, long bits, ref bitmapinfo i, ulong pallete ) library "gdi32.dll" alias for "GetDIBits;Ansi"
//function ulong GetDesktopWindow( ) library "User32.dll"
//function int DeleteDC(ulong hDC) library "Gdi32.dll"
//function int BitBlt(ulong hDC, int num, int num, int num, int num, ulong hDC, int num, int num, ulong lParam) library "Gdi32.dll"
//function ulong CreateDC(ref string str, ref string str, ref string str, ref string str) library "Gdi32.dll" ALIAS FOR "CreateDCA;Ansi"
//function ulong CreateCompatibleDC(ulong hDC) library "Gdi32.dll"
//function ulong CreateCompatibleBitmap(ulong hDC, int num, int num) library "Gdi32.dll"
//function boolean GradientFill( Long hdc , trivertex pvertex[],  long dwnumvertices, ref gradient_rect pmesh[], long dwnummwesh, long dwmmode) library "msimg32.dll" alias for "GradientFill;Ansi"
//function boolean GradientFill( Long hdc , trivertex pvertex[],  long dwnumvertices, ref gradient_rect pmesh, long dwnummwesh, long dwmmode) library "msimg32.dll" alias for "GradientFill;Ansi"
//function ulong DrawText(ulong hdc,ref string lpStr,ulong nCount,ref RECT lpRect,ulong wFormat) library "user32.dll" ALIAS FOR "DrawTextA;Ansi"
//function ulong SetBkMode(ulong hdc,ulong nBkMode) library "gdi32.dll"
//function long SetDCPenColor(ulong hdc,ulong color) library "gdi32.dll"
//function long SetDCBrushColor(ulong hdc,ulong color) library "gdi32.dll"
//function ulong TextOut(ulong hdc,ulong x,ulong y,ref string lpString,ulong nCount) library "gdi32.dll" ALIAS FOR "TextOutA;Ansi"
//function ulong Rectangle(ulong hdc,ulong X1,ulong Y1,ulong X2,ulong Y2) library "gdi32.dll"
//function ulong BeginPath(ulong hdc) library "gdi32.dll"
//function ulong EndPath(ulong hdc) library "gdi32.dll"
//function ulong SetTextColor(ulong hdc,ulong crColor) library "gdi32.dll"
//function long FillRect(ulong hdc, ref RECT rc, ulong hBrush) library "user32.dll"
//function long CreateSolidBrush(long color) library "gdi32.dll"
//function long SetDCPenColor(ulong hdc, long color) library "gdi32.dll"
//// Common Dialog External FUNCTIONs
//function long GetOpenFileName(REF OPENFILENAME OpenFileName) library "comdlg32.dll" ALIAS FOR "GetOpenFileNameA;Ansi"
//function long GetSaveFileName(REF OPENFILENAME SaveFileName) library "comdlg32.dll" ALIAS FOR "GetSaveFileNameA;Ansi"
//function long PrintDlg(REF PRINTDLG PrintDlg) library "comdlg32.dll" ALIAS FOR "PrintDlgA;Ansi"
//function long ChooseFont(REF CHOOSEFONT ChooseFont) library "comdlg32.dll" ALIAS FOR "ChooseFontA;Ansi"
//function BOOLEAN ChooseColor(ref CHOOSECOLOR pChoosecolor) library "comdlg32.dll" ALIAS FOR "ChooseColorA;Ansi"
//subroutine InitCustomColors ( long d, long custom[16], long l ) library 'kernel32.dll' alias for RtlMoveMemory
////Cursor
//function BOOLEAN ClipCursor(REF RECT lprect) library 'user32.dll' alias for "ClipCursor;Ansi"
//function BOOLEAN GetClipCursor(REF RECT lprect) library 'user32.dll' alias for "GetClipCursor;Ansi"
////Timer
//function ULONG SetTimer(long hwnd, ULONG nIDEvent, ULONG elapse, long zero) library "USER32.DLL"
//function BOOLEAN KillTimer(long hwnd, ULONG nIDEvent) library "USER32.DLL"

end prototypes

type variables
protected:
	string is_powerframetemppath

end variables

forward prototypes
public function string of_getpowerframetemppath ()
public function string of_getsystemtemppath ()
public function boolean of_getfilewritetime (string as_filepath, ref string as_writetime)
public function boolean of_setfilewritetime (string as_filepath, string as_writetime)
public function string of_pathstrippath (string as_filepath)
public function string of_pathremovefilespec (string as_filepath)
public function integer of_compositebackgroundimage (string as_sourceimagepath, string as_outputimagepath, string as_backgroundimagepath, long al_cropxpos, long al_cropypos)
public function long of_cropimage (string as_sourcefilepath, string as_outputfilepath, long al_left, long al_top, long al_width, long al_height)
public function long of_extendimage (string as_sourcefilepath, string as_targetfilepath, long al_basexpos, long al_baseypos, long al_extendwidth, long al_extendheight)
public function string of_getclassname (powerobject lpo_target)
public function boolean of_getparentbackgroundimage (readonly graphicobject apo_control, string as_targetpath)
public function string of_getuniqpicturename (powerobject apo_object)
public function long of_createcommandbuttonoverlayimage (readonly commandbutton acb_button, string as_sourceimage, string as_targetimage, unsignedlong aul_fontcolor)
public function long of_urldownloadtofile (string as_url, string as_localfile)
public function integer of_getappeonimagefile (string as_filename)
public function integer of_gettextsize (unsignedlong al_hwnd, string as_text, integer ai_fontsize, integer ai_fontweight, fontfamily aenum_fontfamily, fontpitch aenum_fontpitch, fontcharset aenum_fontcharset, string as_fontface, ref pf_s_size astr_textsize)
public function string of_uridecode (string as_source, encoding ae_encode)
public function string of_uriencode (string as_source, encoding ae_encode)
public function boolean of_shellexecute (string as_file, string as_extension)
public function long of_shellexecute (string as_file)
public function integer of_setsystemcolor (pf_s_syscolor astr_parm)
public function integer of_setopacity (long al_handle)
public function long of_makeclickedbuttonimage (string as_source_img_path, string as_target_img_path)
public function long of_makedisabledbuttonimage (string as_source_img_path, string as_target_img_path)
public function long of_makemouseoverbuttonimage (string as_source_img_path, string as_target_img_path)
public function long of_makepicturebuttonimage (string as_icon_name, string as_target_img_path, long al_button_width, long al_button_height, boolean ab_enabled)
public function boolean of_makebackgroundtransparent (readonly picture ap_target, readonly string as_targetpath)
public function boolean of_getpbcontrolbackgroundimage (readonly dragobject ado_target, readonly string as_targetpath)
public function string of_getlasterror ()
public function string of_formatmessage (unsignedlong aul_error)
public function string of_typeof_str (powerobject apo_object)
public function string of_gethostname ()
public function string of_getipaddress ()
public function string of_getmacaddress ()
public function integer of_getimagesize (string as_filename, ref pf_s_size astr_imagesize)
public function integer of_centerpopupwindow (readonly window aw_popup)
public function long of_createcommandbuttonoverlayimage (readonly commandbutton acb_button, string as_sourceimage, string as_targetimage, unsignedlong aul_fontcolor, string as_iconfile)
public function unsignedlong of_uncompress (ref blob ablb_src, ref blob ablb_rslt)
public function string of_uncompress (ref blob ablb_src)
public function blob of_compress (readonly string as_source)
public function unsignedlong of_compress (ref blob ablb_src, ref blob ablb_rslt)
public function integer of_uncompressfile (ref string as_source, ref string as_destination)
public function boolean of_setfilewritetime (string as_filepath, datetime adtm_writetime)
public function boolean of_getfilewritetime (string as_filename, ref datetime adtm_writetime)
public function integer of_compressfile (string as_source, string as_destination)
public function integer of_toggle_koreng (readonly window aw_inputwin, string as_mode)
public function string of_pathgetfileext (string as_filepath)
end prototypes

public function string of_getpowerframetemppath ();return is_powerframetemppath

end function

public function string of_getsystemtemppath ();// get system temporary path
constant long MAX_PATH = 256

long ll_bufflen
string ls_shortpath, ls_longpath

ll_bufflen = MAX_PATH
ls_shortpath = space(MAX_PATH)

if GetTempPath(ll_bufflen, ls_shortpath) > 0 then
	ls_longpath = space(MAX_PATH)
	GetLongPathName(ls_shortpath, ls_longpath, MAX_PATH)
end if

return ls_longpath

end function

public function boolean of_getfilewritetime (string as_filepath, ref string as_writetime);boolean lb_retval

if isnull(as_filepath) then return false
as_writetime = space(23)

// Return Format = %04d/%02d/%02d %02d:%02d:%02d
lb_retval = pf_GetFileWriteTime(as_filepath, as_writetime)

return lb_retval

end function

public function boolean of_setfilewritetime (string as_filepath, string as_writetime);boolean lb_retval

// WriteTime Format = %04d/%02d/%02d %02d:%02d:%02d
lb_retval = pf_SetFileWriteTime(as_filepath, as_writetime)

return lb_retval

end function

public function string of_pathstrippath (string as_filepath);string	ls_filename

ls_filename = as_filepath
PathStripPath(ls_filename)

return ls_filename

end function

public function string of_pathremovefilespec (string as_filepath);string ls_pathonly

ls_pathonly = as_filepath
PathRemoveFileSpec(ls_pathonly)

return ls_pathonly

end function

public function integer of_compositebackgroundimage (string as_sourceimagepath, string as_outputimagepath, string as_backgroundimagepath, long al_cropxpos, long al_cropypos);long ll_retval
long ll_cropxpos, ll_cropypos

ll_cropxpos = unitstopixels(al_cropxpos, xunitstopixels!)
ll_cropypos = unitstopixels(al_cropypos, yunitstopixels!)

ll_retval = pf_compositebackgroundImage(as_sourceimagepath, as_outputimagepath, as_backgroundimagepath, ll_cropxpos, ll_cropypos)

return ll_retval

end function

public function long of_cropimage (string as_sourcefilepath, string as_outputfilepath, long al_left, long al_top, long al_width, long al_height);long ll_retval
long ll_left, ll_top
long ll_width, ll_height

ll_left = unitstopixels(al_left, xunitstopixels!)
ll_top = unitstopixels(al_top, yunitstopixels!)
ll_width = unitstopixels(al_width, xunitstopixels!)
ll_height = unitstopixels(al_height, yunitstopixels!)

ll_retval = pf_CropImage(as_sourcefilepath, as_outputfilepath, ll_left, ll_top, ll_width, ll_height)

return ll_retval

end function

public function long of_extendimage (string as_sourcefilepath, string as_targetfilepath, long al_basexpos, long al_baseypos, long al_extendwidth, long al_extendheight);long ll_basexpos, ll_baseypos
long ll_extendwidth, ll_extendheight
long ll_retval

ll_basexpos = unitstopixels(al_basexpos, xunitstopixels!)
ll_baseypos = unitstopixels(al_baseypos, yunitstopixels!)
ll_extendwidth = unitstopixels(al_extendwidth, xunitstopixels!)
ll_extendheight = unitstopixels(al_extendheight, yunitstopixels!)

ll_retval = pf_ResizeImage4PB(as_sourcefilepath, as_targetfilepath, ll_basexpos, ll_baseypos, ll_extendwidth, ll_extendheight)

return ll_retval

end function

public function string of_getclassname (powerobject lpo_target);string ls_classname
long ll_retval
ulong ll_handle

ll_handle = handle(lpo_target)
ls_classname = space(256)
ll_retval = GetClassName(ll_handle, ls_classname, 256)
return ls_classname

end function

public function boolean of_getparentbackgroundimage (readonly graphicobject apo_control, string as_targetpath);boolean lb_retval
//graphicobject lgo_parent

//lgo_parent = apo_control.getparent()
//if isvalid(lgo_parent) then
if isvalid(apo_control) then
	//lb_retval = pf_GetPBControlBackgroundImage(handle(apo_control), as_targetpath)
end if
//end if

return lb_retval

end function

public function string of_getuniqpicturename (powerobject apo_object);powerobject lpo_parent
string ls_retval

ls_retval = apo_object.classname()

lpo_parent = apo_object.GetParent()
Do While IsValid (lpo_parent)
	ls_retval = lpo_parent.classname() + "_" + ls_retval
	lpo_parent = lpo_parent.GetParent()
Loop

return ls_retval

end function

public function long of_createcommandbuttonoverlayimage (readonly commandbutton acb_button, string as_sourceimage, string as_targetimage, unsignedlong aul_fontcolor);// FONT PITCH
constant ulong DEFAULT_PITCH = 0
constant ulong FIXED_PITCH = 1
constant ulong VARIABLE_PITCH = 2
constant ulong MONO_FONT = 8

// FONT FAMILY
constant ulong FF_DONTCARE = 0
constant ulong FF_ROMAN = 1
constant ulong FF_SWISS = 2
constant ulong FF_MODERN = 3
constant ulong FF_SCRIPT = 4
constant ulong FF_DECORATIVE = 5

// FONT CHARSET
constant ulong ANSI_CHARSET = 0
constant ulong DEFAULT_CHARSET = 1
constant ulong SYMBOL_CHARSET = 2
constant ulong SHIFTJIS_CHARSET = 128
constant ulong HANGEUL_CHARSET = 129
constant ulong HANGUL_CHARSET = 129
constant ulong GB2312_CHARSET = 134
constant ulong CHINESEBIG5_CHARSET = 136
constant ulong OEM_CHARSET = 255
constant ulong JOHAB_CHARSET = 130
constant ulong HEBREW_CHARSET = 177
constant ulong ARABIC_CHARSET = 178
constant ulong GREEK_CHARSET = 161
constant ulong TURKISH_CHARSET = 162
constant ulong VIETNAMESE_CHARSET = 163
constant ulong THAI_CHARSET = 222
constant ulong EASTEUROPE_CHARSET = 238
constant ulong RUSSIAN_CHARSET = 204
constant ulong MAC_CHARSET = 77
constant ulong BALTIC_CHARSET = 186

long ll_retval, ll_fontsize
long ll_width, ll_height, ll_fontweight
long ll_charset, ll_fontpitch, ll_fontfamily
string ls_text, ls_fontface
long ll_italic, ll_underline

ll_width = unitstopixels(acb_button.width, xunitstopixels!) - 1
ll_height = unitstopixels(acb_button.height, yunitstopixels!) - 1
ls_text = acb_button.text
ls_fontface = acb_button.facename
ll_fontsize = abs(acb_button.textsize)
ll_fontweight = acb_button.weight

if acb_button.italic = true then
	ll_italic = 1
else
	ll_italic = 0
end if

if acb_button.underline = true then
	ll_underline = 1
else
	ll_underline = 0
end if

choose case acb_button.FontPitch
	case Default!
		ll_fontpitch = DEFAULT_PITCH
	case Fixed!
		ll_fontpitch = FIXED_PITCH
	case Variable!
		ll_fontpitch = VARIABLE_PITCH
end choose

choose case acb_button.FontFamily
	case AnyFont!
		ll_fontfamily = FF_DONTCARE
	case Decorative!
		ll_fontfamily = FF_DECORATIVE
	case Modern!
		ll_fontfamily = FF_MODERN
	case Roman!
		ll_fontfamily = FF_ROMAN
	case Script!
		ll_fontfamily = FF_SCRIPT
	case Swiss!
		ll_fontfamily = FF_SWISS
end choose

choose case acb_button.FontCharSet
	case ansi!
		ll_charset = ANSI_CHARSET
	case arabiccharset!
		ll_charset = ARABIC_CHARSET
	case balticcharset!
		ll_charset = BALTIC_CHARSET
	case chinesebig5!
		ll_charset = CHINESEBIG5_CHARSET
	case defaultcharset!
		ll_charset = DEFAULT_CHARSET
	case easteuropecharset!
		ll_charset = EASTEUROPE_CHARSET
	case gb2312charset!
		ll_charset = GB2312_CHARSET
	case greekcharset!
		ll_charset = GREEK_CHARSET
	case hangeul!
		ll_charset = HANGEUL_CHARSET
	case hebrewcharset!
		ll_charset = HEBREW_CHARSET
	case johabcharset!
		ll_charset = JOHAB_CHARSET
	case maccharset!
		ll_charset = MAC_CHARSET
	case oem!
		ll_charset = OEM_CHARSET
	case russiancharset!
		ll_charset = RUSSIAN_CHARSET
	case shiftjis!
		ll_charset = SHIFTJIS_CHARSET
	case symbol!
		ll_charset = SYMBOL_CHARSET
	case thaicharset!
		ll_charset = THAI_CHARSET
	case turkishcharset!
		ll_charset = TURKISH_CHARSET
	case vietnamesecharset!
		ll_charset = VIETNAMESE_CHARSET
end choose

ll_retval = pf_MakeCommandButtonOverlayImageW(as_sourceimage, as_targetimage, ll_width, ll_height, ls_text, &
											  ll_fontsize, ll_fontweight, aul_fontcolor, ll_italic, ll_underline, &
											  ll_charset, ll_fontpitch, ll_fontfamily, ls_fontface)

if ll_retval < 0 then
	choose case ll_retval
		case -99
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$84bcbcd2a9c6200074c7f8bbc0c920000cd37cc744c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + as_sourceimage)
		case else
	end choose
end if

return ll_retval

end function

public function long of_urldownloadtofile (string as_url, string as_localfile);long ll_ret

ll_ret = pf_URLDownloadToFile(as_url, as_localfile)
return ll_ret

end function

public function integer of_getappeonimagefile (string as_filename);// S_OK
// The download started successfully.
//
// E_OUTOFMEMORY
// The buffer length is invalid, or there is insufficient memory to complete the operation.
//
// INET_E_DOWNLOAD_FAILURE
// The specified resource or callback interface was invalid.

string ls_cachedir
string ls_fname, ls_url, ls_localfile
long ll_ret

ls_cachedir = appeongetcachedir() + "\images\"
ls_fname = this.of_pathstrippath(as_filename)
ls_localfile = ls_cachedir + ls_fname
if not fileexists(ls_localfile) then
	ls_url = appeongetieurl() + "images/" + lower(ls_fname)
	ll_ret = this.of_urldownloadtofile(ls_url, ls_localfile)
end if

return ll_ret

end function

public function integer of_gettextsize (unsignedlong al_hwnd, string as_text, integer ai_fontsize, integer ai_fontweight, fontfamily aenum_fontfamily, fontpitch aenum_fontpitch, fontcharset aenum_fontcharset, string as_fontface, ref pf_s_size astr_textsize);// FONT PITCH
constant ulong DEFAULT_PITCH = 0
constant ulong FIXED_PITCH = 1
constant ulong VARIABLE_PITCH = 2
constant ulong MONO_FONT = 8

// FONT FAMILY
constant ulong FF_DONTCARE = 0
constant ulong FF_ROMAN = 1
constant ulong FF_SWISS = 2
constant ulong FF_MODERN = 3
constant ulong FF_SCRIPT = 4
constant ulong FF_DECORATIVE = 5

// FONT CHARSET
constant ulong ANSI_CHARSET = 0
constant ulong DEFAULT_CHARSET = 1
constant ulong SYMBOL_CHARSET = 2
constant ulong SHIFTJIS_CHARSET = 128
constant ulong HANGEUL_CHARSET = 129
constant ulong HANGUL_CHARSET = 129
constant ulong GB2312_CHARSET = 134
constant ulong CHINESEBIG5_CHARSET = 136
constant ulong OEM_CHARSET = 255
constant ulong JOHAB_CHARSET = 130
constant ulong HEBREW_CHARSET = 177
constant ulong ARABIC_CHARSET = 178
constant ulong GREEK_CHARSET = 161
constant ulong TURKISH_CHARSET = 162
constant ulong VIETNAMESE_CHARSET = 163
constant ulong THAI_CHARSET = 222
constant ulong EASTEUROPE_CHARSET = 238
constant ulong RUSSIAN_CHARSET = 204
constant ulong MAC_CHARSET = 77
constant ulong BALTIC_CHARSET = 186

long ll_retval
long ll_charset, ll_fontpitch, ll_fontfamily

ai_fontsize = abs(ai_fontsize)

choose case aenum_fontpitch
	case Default!
		ll_fontpitch = DEFAULT_PITCH
	case Fixed!
		ll_fontpitch = FIXED_PITCH
	case Variable!
		ll_fontpitch = VARIABLE_PITCH
end choose

choose case aenum_fontfamily
	case AnyFont!
		ll_fontfamily = FF_DONTCARE
	case Decorative!
		ll_fontfamily = FF_DECORATIVE
	case Modern!
		ll_fontfamily = FF_MODERN
	case Roman!
		ll_fontfamily = FF_ROMAN
	case Script!
		ll_fontfamily = FF_SCRIPT
	case Swiss!
		ll_fontfamily = FF_SWISS
end choose

choose case aenum_fontcharset
	case ansi!
		ll_charset = ANSI_CHARSET
	case arabiccharset!
		ll_charset = ARABIC_CHARSET
	case balticcharset!
		ll_charset = BALTIC_CHARSET
	case chinesebig5!
		ll_charset = CHINESEBIG5_CHARSET
	case defaultcharset!
		ll_charset = DEFAULT_CHARSET
	case easteuropecharset!
		ll_charset = EASTEUROPE_CHARSET
	case gb2312charset!
		ll_charset = GB2312_CHARSET
	case greekcharset!
		ll_charset = GREEK_CHARSET
	case hangeul!
		ll_charset = HANGEUL_CHARSET
	case hebrewcharset!
		ll_charset = HEBREW_CHARSET
	case johabcharset!
		ll_charset = JOHAB_CHARSET
	case maccharset!
		ll_charset = MAC_CHARSET
	case oem!
		ll_charset = OEM_CHARSET
	case russiancharset!
		ll_charset = RUSSIAN_CHARSET
	case shiftjis!
		ll_charset = SHIFTJIS_CHARSET
	case symbol!
		ll_charset = SYMBOL_CHARSET
	case thaicharset!
		ll_charset = THAI_CHARSET
	case turkishcharset!
		ll_charset = TURKISH_CHARSET
	case vietnamesecharset!
		ll_charset = VIETNAMESE_CHARSET
end choose
if ASCA( LeftA(as_text,1) ) > 0 then
	ll_retval = pf_GetTextSizeEX(al_hwnd, as_text, as_fontface, ai_fontsize, ai_fontweight, ll_fontfamily, ll_fontpitch, ll_charset, astr_textsize)
	//l_retval = pf_GetTextSizeEX(al_hwnd, blob(as_text, encodingansi!), blob(as_fontface, encodingansi!), ai_fontsize, ai_fontweight, ll_fontfamily, ll_fontpitch, ll_charset, astr_textsize)
else
   ll_retval = pf_GetTextSizeW(al_hwnd, as_text, as_fontface, ai_fontsize, ai_fontweight, astr_textsize)
end if

return ll_retval

end function

public function string of_uridecode (string as_source, encoding ae_encode);long ll_strlen, ll_retval
blob lb_result
string ls_result

ll_strlen = lena(as_source)
lb_result = blob(space(ll_strlen))
ll_retval = this.pf_UriDecode(as_source, lb_result)
ls_result = string(blobmid(lb_result, 1, ll_retval), ae_encode)

return ls_result

end function

public function string of_uriencode (string as_source, encoding ae_encode);long ll_strlen, ll_retval
string ls_result
blob lb_source

ll_strlen = lena(as_source)
ls_result = space(ll_strlen * 4)
lb_source = blob(space(lena(as_source)))
blobedit(lb_source, 1, as_source, ae_encode)
ll_retval = this.pf_UriEncode(lb_source, ls_result)
ls_result = lefta(ls_result, ll_retval)

return ls_result

end function

public function boolean of_shellexecute (string as_file, string as_extension);CONSTANT long SEE_MASK_CLASSNAME = 1
CONSTANT long SW_NORMAL = 1

string ls_class
long ll_ret
pf_s_shellexecuteinfo lnvos_shellexecuteinfo
Inet l_Inet

IF lower(as_extension) = "htm" OR lower(as_extension) = "html" THEN
   // Open html file with HyperlinkToURL
   // So, a new browser is launched
   // (with the code using ShellExecuteEx, it is not sure)
   GetContextService("Internet", l_Inet)
   ll_ret = l_Inet.HyperlinkToURL(as_file)
   IF ll_ret = 1 THEN
      RETURN true
   END IF
   RETURN false
END IF

// Search for the classname associated with extension
RegistryGet("HKEY_CLASSES_ROOT\." + as_extension, "", ls_class)
IF isNull(ls_class) OR trim(ls_class) = "" THEN
   // The class is not found, try with .txt (why not ?)
   RegistryGet("HKEY_CLASSES_ROOT\.txt", "", ls_class)
END IF

IF isNull(ls_class) OR Trim(ls_class) = "" THEN
   // No class : error
   RETURN false
END IF

lnvos_shellexecuteinfo.cbsize = 60
lnvos_shellexecuteinfo.fMask = SEE_MASK_CLASSNAME  // Use classname
lnvos_shellexecuteinfo.hwnd = 0
lnvos_shellexecuteinfo.lpVerb = "open"
lnvos_shellexecuteinfo.lpfile = as_file
lnvos_shellexecuteinfo.lpClass = ls_class
lnvos_shellexecuteinfo.nShow = SW_NORMAL

ll_ret = ShellExecuteEx(lnvos_shellexecuteinfo)
IF ll_ret = 0 THEN
   // Error
   RETURN false
END IF

RETURN true
end function

public function long of_shellexecute (string as_file);string ls_Null
long   ll_rc

SetNull(ls_Null)
ll_rc = ShellExecute( handle( this ), "open", as_file, ls_Null, ls_Null, 1)
return ll_rc

end function

public function integer of_setsystemcolor (pf_s_syscolor astr_parm);return this.pf_SetSystemColor( &
		astr_parm.color_scrollbar, &
		astr_parm.color_desktop, &
		astr_parm.color_activecaption, &
		astr_parm.color_inactivecaption, &
		astr_parm.color_menu, &
		astr_parm.color_window, &
		astr_parm.color_windowframe, &
		astr_parm.color_menutext, &
		astr_parm.color_windowtext, &
		astr_parm.color_captiontext, &
		astr_parm.color_activeborder, &
		astr_parm.color_inactiveborder, &
		astr_parm.color_appworkspace, &
		astr_parm.color_highlight, &
		astr_parm.color_highlighttext, &
		astr_parm.color_btnface, &
		astr_parm.color_btnshadow, &
		astr_parm.color_graytext, &
		astr_parm.color_btntext, &
		astr_parm.color_inactivecaptiontext, &
		astr_parm.color_btnhilight, &
		astr_parm.color_3ddkshadow, &
		astr_parm.color_3dlight, &
		astr_parm.color_infotext, &
		astr_parm.color_infobk, &
		astr_parm.color_hotlight, &
		astr_parm.color_gradientactivecaptio, &
		astr_parm.color_gradientinactivecapt, &
		astr_parm.color_menuhilight, &
		astr_parm.color_menubar )

end function

public function integer of_setopacity (long al_handle);CONSTANT long LWA_COLORKEY = 1, LWA_ALPHA = 2
CONSTANT long GWL_EXSTYLE = -20
CONSTANT long WS_EX_LAYERED = 524288 //2^19

long ll_Ret, ll_handle

// or-bitwise function
OleObject wsh
wsh = CREATE OleObject
wsh.ConnectToNewObject( "MSScriptControl.ScriptControl" )
wsh.language = "vbscript"

//ll_handle = Handle (this)  // handle of the window
ll_handle = al_handle
ll_Ret = GetWindowLong(ll_handle, GWL_EXSTYLE)
ll_Ret = wsh.Eval(string(ll_ret) + " or " + string(WS_EX_LAYERED))
SetWindowLong (ll_handle, GWL_EXSTYLE, ll_Ret)

// Set the opacity of the layered window to 128 (transparent)
SetLayeredWindowAttributes (ll_handle, 0, char(128), LWA_ALPHA)

// Set the opacity of the layered window to 255 (opaque)
// SetLayeredWindowAttributes (ll_handle, 0, char(255),LWA_ALPHA)

return 0

end function

public function long of_makeclickedbuttonimage (string as_source_img_path, string as_target_img_path);return pf_MakeClickedButtonImage(as_source_img_path, as_target_img_path)

end function

public function long of_makedisabledbuttonimage (string as_source_img_path, string as_target_img_path);return pf_MakeDisabledButtonImage(as_source_img_path, as_target_img_path)

end function

public function long of_makemouseoverbuttonimage (string as_source_img_path, string as_target_img_path);return pf_MakeMouseoverButtonImage(as_source_img_path, as_target_img_path)

end function

public function long of_makepicturebuttonimage (string as_icon_name, string as_target_img_path, long al_button_width, long al_button_height, boolean ab_enabled);return pf_MakePictureButtonImage(as_icon_name, as_target_img_path, al_button_width, al_button_height, ab_enabled)

end function

public function boolean of_makebackgroundtransparent (readonly picture ap_target, readonly string as_targetpath);pf_s_rect lstr_rect
boolean lb_rv
string ls_sourcepath

lstr_rect.left = unitstopixels(ap_target.x, xunitstopixels!)
lstr_rect.top = unitstopixels(ap_target.y, yunitstopixels!)
lstr_rect.right = lstr_rect.left + unitstopixels(ap_target.width, xunitstopixels!)
lstr_rect.bottom = lstr_rect.top + unitstopixels(ap_target.height, yunitstopixels!)

ls_sourcepath = ap_target.picturename

lb_rv = pf_MakeBackgroundTransparent(handle(ap_target), lstr_rect, ls_sourcepath, as_targetpath)
if lb_rv = true then
	ap_target.picturename = as_targetpath
	ap_target.visible = true
end if

return lb_rv

end function

public function boolean of_getpbcontrolbackgroundimage (readonly dragobject ado_target, readonly string as_targetpath);pf_s_rect lstr_rect
boolean lb_rv

lstr_rect.left = unitstopixels(ado_target.x, xunitstopixels!)
lstr_rect.top = unitstopixels(ado_target.y, yunitstopixels!)
lstr_rect.right = lstr_rect.left + unitstopixels(ado_target.width, xunitstopixels!)
lstr_rect.bottom = lstr_rect.top + unitstopixels(ado_target.height, yunitstopixels!)

lb_rv = pf_GetPBControlBackgroundImage(handle(ado_target), lstr_rect, as_targetpath)

return lb_rv

end function

public function string of_getlasterror ();// -----------------------------------------------------------------------------
// FUNCTION:	n_ping.of_GetLastError
//
// PURPOSE:		This function returns the message text for
//					the most recent system error.
//
// RETURN:		Counter value
//
// DATE			PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	--------		-----------------------------------------------------
// 03/23/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_error
String ls_errmsg

lul_error = GetLastError()

If lul_error = 0 Then
	ls_errmsg = "An unknown error has occurred!"
Else
	ls_errmsg = of_FormatMessage(lul_error)
End If

Return ls_errmsg

end function

public function string of_formatmessage (unsignedlong aul_error);// -----------------------------------------------------------------------------
// FUNCTION:	n_ping.of_FormatMessage
//
// PURPOSE:		This function returns the message text for
//					the given system error code.
//
// ARGUMENTS:	aul_error	- Error code
//
// RETURN:		Message text
//
// DATE			PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	--------		-----------------------------------------------------
// 03/23/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
String ls_buffer, ls_errmsg

ls_buffer = Space(200)

FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
		aul_error, LANG_NEUTRAL, ls_buffer, 200, 0)

ls_errmsg = "Error# " + String(aul_error) + "~r~n~r~n" + ls_buffer

Return ls_errmsg

end function

public function string of_typeof_str (powerobject apo_object);// $$HEX5$$0cd3ccc64cbe54b32000$$ENDHEX$$TypeOf $$HEX4$$68d518c258c72000$$ENDHEX$$Enum $$HEX5$$acb934d112ac44c72000$$ENDHEX$$String $$HEX14$$15d6dcd05cb82000c0bcbdac74d51cc12000acb934d169d5c8b2e4b2$$ENDHEX$$.

string ls_typeof

choose case apo_object.typeof()
	case adoresultset! ; ls_typeof = 'adoresultset'
	case animation! ; ls_typeof = 'animation'
	case any! ; ls_typeof = 'any'
	case application! ; ls_typeof = 'application'
	case arraybounds! ; ls_typeof = 'arraybounds'
	case blob! ; ls_typeof = 'blob'
	case boolean! ; ls_typeof = 'boolean'
	case character! ; ls_typeof = 'character'
	case checkbox! ; ls_typeof = 'checkbox'
	case classdefinition! ; ls_typeof = 'classdefinition'
	case classdefinitionobject! ; ls_typeof = 'classdefinitionobject'
	case commandbutton! ; ls_typeof = 'commandbutton'
	case connection! ; ls_typeof = 'connection'
	case connectioninfo! ; ls_typeof = 'connectioninfo'
	case connectobject! ; ls_typeof = 'connectobject'
	case contextinformation! ; ls_typeof = 'contextinformation'
	case contextkeyword! ; ls_typeof = 'contextkeyword'
	case corbacurrent! ; ls_typeof = 'corbacurrent'
	case corbaobject! ; ls_typeof = 'corbaobject'
	case corbaunion! ; ls_typeof = 'corbaunion'
	case cplusplus! ; ls_typeof = 'cplusplus'
	case datastore! ; ls_typeof = 'datastore'
	case datawindow! ; ls_typeof = 'datawindow'
	case datawindowchild! ; ls_typeof = 'datawindowchild'
	case date! ; ls_typeof = 'date'
	case datepicker! ; ls_typeof = 'datepicker'
	case datetime! ; ls_typeof = 'datetime'
	case decimal! ; ls_typeof = 'decimal'
	case double! ; ls_typeof = 'double'
	case dragobject! ; ls_typeof = 'dragobject'
	case drawobject! ; ls_typeof = 'drawobject'
	case dropdownlistbox! ; ls_typeof = 'dropdownlistbox'
	case dropdownpicturelistbox! ; ls_typeof = 'dropdownpicturelistbox'
	case dwobject! ; ls_typeof = 'dwobject'
	case dynamicdescriptionarea! ; ls_typeof = 'dynamicdescriptionarea'
	case dynamicstagingarea! ; ls_typeof = 'dynamicstagingarea'
	case editmask! ; ls_typeof = 'editmask'
	case enumerationdefinition! ; ls_typeof = 'enumerationdefinition'
	case enumerationitemdefinition! ; ls_typeof = 'enumerationitemdefinition'
	case environment! ; ls_typeof = 'environment'
	case error! ; ls_typeof = 'error'
	case errorlogging! ; ls_typeof = 'errorlogging'
	case extobject! ; ls_typeof = 'extobject'
	case functionobject! ; ls_typeof = 'functionobject'
	case graph! ; ls_typeof = 'graph'
	case graphicobject! ; ls_typeof = 'graphicobject'
	case graxis! ; ls_typeof = 'graxis'
	case grdispattr! ; ls_typeof = 'grdispattr'
	case groupbox! ; ls_typeof = 'groupbox'
	case hprogressbar! ; ls_typeof = 'hprogressbar'
	case hscrollbar! ; ls_typeof = 'hscrollbar'
	case htrackbar! ; ls_typeof = 'htrackbar'
	case inet! ; ls_typeof = 'inet'
	case inkedit! ; ls_typeof = 'inkedit'
	case inkpicture! ; ls_typeof = 'inkpicture'
	case integer! ; ls_typeof = 'integer'
	case internetresult! ; ls_typeof = 'internetresult'
	case jaguarorb! ; ls_typeof = 'jaguarorb'
	case line! ; ls_typeof = 'line'
	case listbox! ; ls_typeof = 'listbox'
	case listview! ; ls_typeof = 'listview'
	case listviewitem! ; ls_typeof = 'listviewitem'
	case long! ; ls_typeof = 'long'
	case mailfiledescription! ; ls_typeof = 'mailfiledescription'
	case mailmessage! ; ls_typeof = 'mailmessage'
	case mailrecipient! ; ls_typeof = 'mailrecipient'
	case mailsession! ; ls_typeof = 'mailsession'
	case mdiclient! ; ls_typeof = 'mdiclient'
	case menu! ; ls_typeof = 'menu'
	case menucascade! ; ls_typeof = 'menucascade'
	case message! ; ls_typeof = 'message'
	case monthcalendar! ; ls_typeof = 'monthcalendar'
	case multilineedit! ; ls_typeof = 'multilineedit'
	case nonvisualobject! ; ls_typeof = 'nonvisualobject'
	case notype! ; ls_typeof = 'notype'
	case objhandle! ; ls_typeof = 'objhandle'
	case olecontrol! ; ls_typeof = 'olecontrol'
	case olecustomcontrol! ; ls_typeof = 'olecustomcontrol'
	case oleobject! ; ls_typeof = 'oleobject'
	case olestorage! ; ls_typeof = 'olestorage'
	case olestream! ; ls_typeof = 'olestream'
	case oletxnobject! ; ls_typeof = 'oletxnobject'
	case omcontrol! ; ls_typeof = 'omcontrol'
	case omcustomcontrol! ; ls_typeof = 'omcustomcontrol'
	case omembeddedcontrol! ; ls_typeof = 'omembeddedcontrol'
	case omobject! ; ls_typeof = 'omobject'
	case omstorage! ; ls_typeof = 'omstorage'
	case omstream! ; ls_typeof = 'omstream'
	case orb! ; ls_typeof = 'orb'
	case oval! ; ls_typeof = 'oval'
	case pbtocppobject! ; ls_typeof = 'pbtocppobject'
	case picture! ; ls_typeof = 'picture'
	case picturebutton! ; ls_typeof = 'picturebutton'
	case picturehyperlink! ; ls_typeof = 'picturehyperlink'
	case picturelistbox! ; ls_typeof = 'picturelistbox'
	case pipeline! ; ls_typeof = 'pipeline'
	case powerobject! ; ls_typeof = 'powerobject'
	case profilecall! ; ls_typeof = 'profilecall'
	case profileclass! ; ls_typeof = 'profileclass'
	case profileline! ; ls_typeof = 'profileline'
	case profileroutine! ; ls_typeof = 'profileroutine'
	case profiling! ; ls_typeof = 'profiling'
	case radiobutton! ; ls_typeof = 'radiobutton'
	case real! ; ls_typeof = 'real'
	case rectangle! ; ls_typeof = 'rectangle'
	case remoteobject! ; ls_typeof = 'remoteobject'
	case resultset! ; ls_typeof = 'resultset'
	case resultsets! ; ls_typeof = 'resultsets'
	case richtextedit! ; ls_typeof = 'richtextedit'
	case roundrectangle! ; ls_typeof = 'roundrectangle'
	case scriptdefinition! ; ls_typeof = 'scriptdefinition'
	case service! ; ls_typeof = 'service'
	case simpletypedefinition! ; ls_typeof = 'simpletypedefinition'
	case singlelineedit! ; ls_typeof = 'singlelineedit'
	case sslcallback! ; ls_typeof = 'sslcallback'
	case sslserviceprovider! ; ls_typeof = 'sslserviceprovider'
	case statichyperlink! ; ls_typeof = 'statichyperlink'
	case statictext! ; ls_typeof = 'statictext'
	case string! ; ls_typeof = 'string'
	case structure! ; ls_typeof = 'structure'
	case systemfunctions! ; ls_typeof = 'systemfunctions'
	case tab! ; ls_typeof = 'tab'
	case time! ; ls_typeof = 'time'
	case timing! ; ls_typeof = 'timing'
	case traceactivitynode! ; ls_typeof = 'traceactivitynode'
	case tracebeginend! ; ls_typeof = 'tracebeginend'
	case traceerror! ; ls_typeof = 'traceerror'
	case traceesql! ; ls_typeof = 'traceesql'
	case tracefile! ; ls_typeof = 'tracefile'
	case tracegarbagecollect! ; ls_typeof = 'tracegarbagecollect'
	case traceline! ; ls_typeof = 'traceline'
	case traceobject! ; ls_typeof = 'traceobject'
	case traceroutine! ; ls_typeof = 'traceroutine'
	case tracetree! ; ls_typeof = 'tracetree'
	case tracetreeerror! ; ls_typeof = 'tracetreeerror'
	case tracetreeesql! ; ls_typeof = 'tracetreeesql'
	case tracetreegarbagecollect! ; ls_typeof = 'tracetreegarbagecollect'
	case tracetreeline! ; ls_typeof = 'tracetreeline'
	case tracetreenode! ; ls_typeof = 'tracetreenode'
	case tracetreeobject! ; ls_typeof = 'tracetreeobject'
	case tracetreeroutine! ; ls_typeof = 'tracetreeroutine'
	case tracetreeuser! ; ls_typeof = 'tracetreeuser'
	case traceuser! ; ls_typeof = 'traceuser'
	case transaction! ; ls_typeof = 'transaction'
	case transactionserver! ; ls_typeof = 'transactionserver'
	case treeview! ; ls_typeof = 'treeview'
	case treeviewitem! ; ls_typeof = 'treeviewitem'
	case typedefinition! ; ls_typeof = 'typedefinition'
	case unsignedinteger! ; ls_typeof = 'unsignedinteger'
	case unsignedlong! ; ls_typeof = 'unsignedlong'
	case userobject! ; ls_typeof = 'userobject'
	case variablecardinalitydefinition! ; ls_typeof = 'variablecardinalitydefinition'
	case variabledefinition! ; ls_typeof = 'variabledefinition'
	case vprogressbar! ; ls_typeof = 'vprogressbar'
	case vscrollbar! ; ls_typeof = 'vscrollbar'
	case vtrackbar! ; ls_typeof = 'vtrackbar'
	case window! ; ls_typeof = 'window'
	case windowobject! ; ls_typeof = 'windowobject'
	case else ; ls_typeof = 'unknown'
end choose

return ls_typeof

end function

public function string of_gethostname ();string ls_hostname

ls_hostname = space(512)
if this.pf_gethostname(ls_hostname, len(ls_hostname)) = 1 then
	return ls_hostname
else
	return ''
end if

end function

public function string of_getipaddress ();string ls_ipaddress

ls_ipaddress = space(512)
if this.pf_getipaddress(ls_ipaddress, len(ls_ipaddress)) = 1 then
	return ls_ipaddress
else
	return ''
end if

end function

public function string of_getmacaddress ();string ls_macaddress

ls_macaddress = space(512)
if this.pf_getmacaddress(ls_macaddress, len(ls_macaddress)) = 1 then
	return ls_macaddress
else
	return ''
end if

end function

public function integer of_getimagesize (string as_filename, ref pf_s_size astr_imagesize);// $$HEX18$$74c7f8bbc0c920000cd37cc758c72000acc074c788c97cb920006cad74d535c6c8b2e4b2$$ENDHEX$$
// $$HEX4$$acc074c788c92000$$ENDHEX$$Unit = PBUnit

if isnull(as_filename) or len(trim(as_filename)) = 0 then return 0

if not fileexists(as_filename) then
	if appeongetclienttype() = 'PB' then
		return -1
	else
		as_filename = appeongetcachedir() + "\images\" + this.of_pathstrippath(as_filename)
		if not fileexists(as_filename) then return -1
	end if
end if

this.pf_GetImageSize(as_filename, astr_imagesize)
astr_imagesize.width = pixelstounits(astr_imagesize.width, xpixelstounits!)
astr_imagesize.height = pixelstounits(astr_imagesize.height, ypixelstounits!)

return 1

end function

public function integer of_centerpopupwindow (readonly window aw_popup);// $$HEX28$$0cd3ccc64cbe54b394b220001dd3c5c508c7c4b3b0c67cb920006dd5c1c02000fcc8a8bac8b230d1d0c51cc1200024c608d569d5c8b2e4b2$$ENDHEX$$.
// $$HEX32$$1dd3c5c508c7c4b3b0c620008cc85cd47cb9200080bda8ba08c7c4b3b0c62000a8bac8b230d15cb82000c0bcbdac74d5fcc894b2200068d518c285c7c8b2e4b2$$ENDHEX$$.

constant integer SM_CMONITORS  = 80
constant integer MONITOR_DEFAULTTONULL = 0

long ll_parent_hndl, ll_popup_hndl
window lw_parent
pf_s_tagMonitorInfo lstr_tmi

// $$HEX15$$80bda8ba200008c7c4b3b0c6200008b87cd3f0b7a4c220006cad58d530ae$$ENDHEX$$
lw_parent = aw_popup.parentwindow()

// $$HEX10$$1dd3c5c508c7c4b3b0c62000c0d085c774c72000$$ENDHEX$$mdi, main $$HEX6$$78c72000bdacb0c694b22000$$ENDHEX$$parentwindow$$HEX4$$00ac2000c6c54cc7$$ENDHEX$$
if isnull(lw_parent) or not isvalid(lw_parent) then return -1

// $$HEX8$$a8bac8b230d120002fac18c200ac2000$$ENDHEX$$2$$HEX12$$1cac200074c7c1c078c72000bdacb0c6ccb92000c4c989d5$$ENDHEX$$
if GetSystemMetrics(SM_CMONITORS) <= 1 then return 0

// $$HEX17$$80bda8ba08c7c4b3b0c62000a8bac8b230d1200078d5e4b412ac20006cad58d530ae$$ENDHEX$$
ll_parent_hndl = MonitorFromWindow(handle(lw_parent), MONITOR_DEFAULTTONULL)

// $$HEX16$$1dd3c5c5c4b3b0c62000a8bac8b230d1200078d5e4b412ac20006cad58d530ae$$ENDHEX$$
ll_popup_hndl = MonitorFromWindow(handle(aw_popup), MONITOR_DEFAULTTONULL)

// $$HEX24$$78d5e4b474c7200019ac3cc774ba2000d9b37cc75cd52000a8bac8b230d1d0c51cc12000f4bcecc5c0c994b2200011c9$$ENDHEX$$
if isnull(ll_parent_hndl) or isnull(ll_popup_hndl) then return 0
if ll_parent_hndl = ll_popup_hndl then return 0

// $$HEX11$$a8bac8b230d1200074d5c1c0c4b320006cad58d530ae$$ENDHEX$$
lstr_tmi.cbSize = 72	// Size in bytes of TAGMONITORINFO
GetMonitorInfo(ll_parent_hndl, lstr_tmi)

// $$HEX18$$1dd3c5c508c7c4b3b0c62000a8bac8b230d1200011c959c5d0c5200004c758ce58d530ae$$ENDHEX$$
long ll_xpos, ll_ypos

lstr_tmi.rcMonitor.left = pixelstounits(lstr_tmi.rcMonitor.left, xpixelstounits!)
lstr_tmi.rcMonitor.right = pixelstounits(lstr_tmi.rcMonitor.right, xpixelstounits!)
lstr_tmi.rcMonitor.top = pixelstounits(lstr_tmi.rcMonitor.top, ypixelstounits!)
lstr_tmi.rcMonitor.bottom = pixelstounits(lstr_tmi.rcMonitor.bottom, ypixelstounits!)

ll_xpos = lstr_tmi.rcMonitor.left + ((lstr_tmi.rcMonitor.right - lstr_tmi.rcMonitor.left - aw_popup.width) / 2)
ll_ypos = lstr_tmi.rcMonitor.top + ((lstr_tmi.rcMonitor.bottom - lstr_tmi.rcMonitor.top - aw_popup.height) / 2)

aw_popup.center = false
aw_popup.move(ll_xpos, ll_ypos)
return 1

end function

public function long of_createcommandbuttonoverlayimage (readonly commandbutton acb_button, string as_sourceimage, string as_targetimage, unsignedlong aul_fontcolor, string as_iconfile);// FONT PITCH
constant ulong DEFAULT_PITCH = 0
constant ulong FIXED_PITCH = 1
constant ulong VARIABLE_PITCH = 2
constant ulong MONO_FONT = 8

// FONT FAMILY
constant ulong FF_DONTCARE = 0
constant ulong FF_ROMAN = 1
constant ulong FF_SWISS = 2
constant ulong FF_MODERN = 3
constant ulong FF_SCRIPT = 4
constant ulong FF_DECORATIVE = 5

// FONT CHARSET
constant ulong ANSI_CHARSET = 0
constant ulong DEFAULT_CHARSET = 1
constant ulong SYMBOL_CHARSET = 2
constant ulong SHIFTJIS_CHARSET = 128
constant ulong HANGEUL_CHARSET = 129
constant ulong HANGUL_CHARSET = 129
constant ulong GB2312_CHARSET = 134
constant ulong CHINESEBIG5_CHARSET = 136
constant ulong OEM_CHARSET = 255
constant ulong JOHAB_CHARSET = 130
constant ulong HEBREW_CHARSET = 177
constant ulong ARABIC_CHARSET = 178
constant ulong GREEK_CHARSET = 161
constant ulong TURKISH_CHARSET = 162
constant ulong VIETNAMESE_CHARSET = 163
constant ulong THAI_CHARSET = 222
constant ulong EASTEUROPE_CHARSET = 238
constant ulong RUSSIAN_CHARSET = 204
constant ulong MAC_CHARSET = 77
constant ulong BALTIC_CHARSET = 186

long ll_retval, ll_fontsize
long ll_width, ll_height, ll_fontweight
long ll_charset, ll_fontpitch, ll_fontfamily
string ls_text, ls_fontface
long ll_italic, ll_underline

ll_width = unitstopixels(acb_button.width, xunitstopixels!) - 1
ll_height = unitstopixels(acb_button.height, yunitstopixels!) - 1
ls_text = acb_button.text
ls_fontface = acb_button.facename
ll_fontsize = abs(acb_button.textsize)
ll_fontweight = acb_button.weight

if acb_button.italic = true then
	ll_italic = 1
else
	ll_italic = 0
end if

if acb_button.underline = true then
	ll_underline = 1
else
	ll_underline = 0
end if

choose case acb_button.FontPitch
	case Default!
		ll_fontpitch = DEFAULT_PITCH
	case Fixed!
		ll_fontpitch = FIXED_PITCH
	case Variable!
		ll_fontpitch = VARIABLE_PITCH
end choose

choose case acb_button.FontFamily
	case AnyFont!
		ll_fontfamily = FF_DONTCARE
	case Decorative!
		ll_fontfamily = FF_DECORATIVE
	case Modern!
		ll_fontfamily = FF_MODERN
	case Roman!
		ll_fontfamily = FF_ROMAN
	case Script!
		ll_fontfamily = FF_SCRIPT
	case Swiss!
		ll_fontfamily = FF_SWISS
end choose

choose case acb_button.FontCharSet
	case ansi!
		ll_charset = ANSI_CHARSET
	case arabiccharset!
		ll_charset = ARABIC_CHARSET
	case balticcharset!
		ll_charset = BALTIC_CHARSET
	case chinesebig5!
		ll_charset = CHINESEBIG5_CHARSET
	case defaultcharset!
		ll_charset = DEFAULT_CHARSET
	case easteuropecharset!
		ll_charset = EASTEUROPE_CHARSET
	case gb2312charset!
		ll_charset = GB2312_CHARSET
	case greekcharset!
		ll_charset = GREEK_CHARSET
	case hangeul!
		ll_charset = HANGEUL_CHARSET
	case hebrewcharset!
		ll_charset = HEBREW_CHARSET
	case johabcharset!
		ll_charset = JOHAB_CHARSET
	case maccharset!
		ll_charset = MAC_CHARSET
	case oem!
		ll_charset = OEM_CHARSET
	case russiancharset!
		ll_charset = RUSSIAN_CHARSET
	case shiftjis!
		ll_charset = SHIFTJIS_CHARSET
	case symbol!
		ll_charset = SYMBOL_CHARSET
	case thaicharset!
		ll_charset = THAI_CHARSET
	case turkishcharset!
		ll_charset = TURKISH_CHARSET
	case vietnamesecharset!
		ll_charset = VIETNAMESE_CHARSET
end choose

if isnull(as_iconfile) or as_iconfile = '' then
	ll_retval = pf_MakeCommandButtonOverlayImageW(as_sourceimage, as_targetimage, ll_width, ll_height, ls_text, &
												  ll_fontsize, ll_fontweight, aul_fontcolor, ll_italic, ll_underline, &
												  ll_charset, ll_fontpitch, ll_fontfamily, ls_fontface)
else
	ll_retval = pf_MakeCommandButtonImageW(as_sourceimage, as_targetimage, ll_width, ll_height, ls_text, &
												  ll_fontsize, ll_fontweight, aul_fontcolor, ll_italic, ll_underline, &
												  ll_charset, ll_fontpitch, ll_fontfamily, ls_fontface, as_iconfile)
end if

if ll_retval < 0 then
	choose case ll_retval
		case -99
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$84bcbcd2a9c6200074c7f8bbc0c920000cd37cc744c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.~r~nSource Image: ' + as_sourceimage + '~r~nIcon Image: ' + as_iconfile)
		case else
	end choose
end if

return ll_retval

end function

public function unsignedlong of_uncompress (ref blob ablb_src, ref blob ablb_rslt);// Description:
// $$HEX18$$14bc74c708b1acb9200070b374c730d17cb9200055c595cd200074d51cc869d5c8b2e4b2$$ENDHEX$$(UNZIP)
// Parameters:
// ablb_src = $$HEX18$$55c595cd1cb4200070b374c730d17cb92000f4b2e0ac88c794b2200014bc74c708b1acb9$$ENDHEX$$
// ablb_rslt = $$HEX21$$55c595cd74d51cc81cb4200070b374c730d17cb92000f4b244c7200014bc74c708b1acb92000c0bc18c2$$ENDHEX$$
// Return:
// $$HEX16$$55c595cd74d51cc81cb4200070b374c730d158c7200014bc74c7b8d2200018c2$$ENDHEX$$
// $$HEX7$$3b20200055c595cd74d51cc82000$$ENDHEX$$BUFFER $$HEX8$$acc074c788c97cb920005ccd00b32000$$ENDHEX$$10$$HEX9$$30bc5cb8200024c115c8200088d53cc798b0$$ENDHEX$$
// $$HEX27$$f8ad200074c7c1c0200028cc74c700ac200098b094b22000bdacb0c600ac20001cbcddc0200020b4200018c2200088c7b5c2c8b2e4b2$$ENDHEX$$.
// $$HEX6$$74c7f4b72000bdacb0c62000$$ENDHEX$$of_compressfile / of_uncompressfile$$HEX7$$44c72000acc0a9c658d538c194c6$$ENDHEX$$.

ulong lul_srclen, lul_destlen, lul_rsltlen
blob lblb_dest

lul_srclen = len(ablb_src)
lul_destlen = lul_srclen * 10
lblb_dest = blob(space(lul_destlen), encodingansi!)

lul_rsltlen = pf_uncompress(lblb_dest, lul_destlen, ablb_src, lul_srclen)
if lul_rsltlen > 0 then
	ablb_rslt = blobmid(lblb_dest, 1, lul_rsltlen)
end if

return lul_rsltlen

end function

public function string of_uncompress (ref blob ablb_src);// Description:
// $$HEX13$$38bb90c7f4c544c7200055c595cd200074d51cc869d5c8b2e4b2$$ENDHEX$$(UNZIP)
// Parameters:
// ablb_src = $$HEX18$$55c595cd1cb4200070b374c730d17cb92000f4b2e0ac88c794b2200014bc74c708b1acb9$$ENDHEX$$
// Return:
// $$HEX11$$55c595cd74c7200074d51cc81cb4200038bb90c7f4c5$$ENDHEX$$

blob lblb_rslt
string ls_rslt

this.of_uncompress(ablb_src, lblb_rslt)
ls_rslt = string(lblb_rslt)
return ls_rslt

end function

public function blob of_compress (readonly string as_source);// Description:
// $$HEX10$$38bb90c7f4c544c7200055c595cd69d5c8b2e4b2$$ENDHEX$$(ZIP)
// Parameters:
// as_source = $$HEX7$$55c595cd60d5200038bb90c7f4c5$$ENDHEX$$
// Return:
// as_source$$HEX14$$00ac200055c595cd1cb4200014bc74c708b1acb9200070b374c730d1$$ENDHEX$$

blob lblb_src, lblb_rslt

lblb_src = blob(as_source)
this.of_compress(lblb_src, lblb_rslt)
return lblb_rslt

end function

public function unsignedlong of_compress (ref blob ablb_src, ref blob ablb_rslt);// Description:
// $$HEX15$$14bc74c708b1acb9200070b374c730d17cb9200055c595cd69d5c8b2e4b2$$ENDHEX$$(ZIP)
// Parameter:
// ablb_src = $$HEX12$$55c595cd60d5200014bc74c708b1acb9200070b374c730d1$$ENDHEX$$
// ablb_rslt = $$HEX12$$55c595cd1cb4200014bc74c708b1acb9200070b374c730d1$$ENDHEX$$
// Return:
// $$HEX14$$55c595cd1cb4200070b374c730d158c7200014bc74c7b8d2200018c2$$ENDHEX$$

ulong lul_srclen, lul_destlen, lul_rsltlen
blob lblb_dest

lul_srclen = len(ablb_src)
lul_destlen = (lul_srclen * 1.01) + 12
lblb_dest = blob(space(lul_destlen), encodingansi!)

lul_rsltlen = pf_compress(lblb_dest, lul_destlen, ablb_src, lul_srclen)
if lul_rsltlen > 0 then
	ablb_rslt = blobmid(lblb_dest, 1, lul_rsltlen)
end if

return lul_rsltlen

end function

public function integer of_uncompressfile (ref string as_source, ref string as_destination);// Description:
// as_source $$HEX11$$0cd37cc744c7200055c595cd74d51cc874d51cc12000$$ENDHEX$$as_destination $$HEX11$$0cd37cc785ba3cc75cb8200000c8a5c769d5c8b2e4b2$$ENDHEX$$.
// Parameter:
// as_source = $$HEX9$$55c595cd74d51cc860d520000cd37cc785ba$$ENDHEX$$
// as_destination = $$HEX9$$55c595cd74d51cc81cb420000cd37cc785ba$$ENDHEX$$
// Return:
// 0 = $$HEX2$$31c1f5ac$$ENDHEX$$, $$HEX5$$c8b974c708b1a4c22000$$ENDHEX$$= $$HEX2$$e4c228d3$$ENDHEX$$

integer li_rc

li_rc = pf_uncompressfile(as_source, as_destination)
return li_rc

end function

public function boolean of_setfilewritetime (string as_filepath, datetime adtm_writetime);boolean lb_retval
string ls_writetime

ls_writetime = string(adtm_writetime, 'yyyy/mm/dd hh:mm:ss')
// WriteTime Format = %04d/%02d/%02d %02d:%02d:%02d
lb_retval = pf_SetFileWriteTime(as_filepath, ls_writetime)

return lb_retval

end function

public function boolean of_getfilewritetime (string as_filename, ref datetime adtm_writetime);// $$HEX21$$74d5f9b220000cd37cc758c720005ccd85c8200018c215c87cc7dcc27cb920006cad74d535c6c8b2e4b2$$ENDHEX$$

string ls_writetime
boolean lb_rc

ls_writetime = space(23)
lb_rc = this.pf_getfilewritetime(as_filename, ls_writetime)
if lb_rc = true then
	adtm_writetime = datetime(ls_writetime)
end if

return lb_rc

end function

public function integer of_compressfile (string as_source, string as_destination);// Description:
// as_source $$HEX9$$0cd37cc744c7200055c595cd74d51cc12000$$ENDHEX$$as_destination $$HEX11$$0cd37cc785ba3cc75cb8200000c8a5c769d5c8b2e4b2$$ENDHEX$$.
// Parameter:
// as_source = $$HEX7$$55c595cd60d520000cd37cc785ba$$ENDHEX$$
// as_destination = $$HEX7$$55c595cd1cb420000cd37cc785ba$$ENDHEX$$
// Return:
// 0 = $$HEX2$$31c1f5ac$$ENDHEX$$, $$HEX5$$c8b974c708b1a4c22000$$ENDHEX$$= $$HEX2$$e4c228d3$$ENDHEX$$

integer li_rc

li_rc = pf_compressfile(as_source, as_destination)
return li_rc

end function

public function integer of_toggle_koreng (readonly window aw_inputwin, string as_mode);// $$HEX1$$5cd5$$ENDHEX$$,$$HEX13$$01c62000a8badcb4200004c858d6200068d518c285c7c8b2e4b2$$ENDHEX$$.
// Arguments
// apo_window : $$HEX1$$5cd5$$ENDHEX$$,$$HEX14$$01c6200004c858d660d5200008c7c4b3b0c6200024c60cbe1dc8b8d2$$ENDHEX$$
// as_mode : $$HEX5$$c0bcbdac60d520005cd5$$ENDHEX$$,$$HEX11$$01c62000a8badcb47cb9200030ae20c269d5c8b2e4b2$$ENDHEX$$.
// $$HEX8$$5cd500aea8badcb42000c0bc58d62000$$ENDHEX$$->  'k', 'kor', 'korean', '1', '$$HEX1$$5cd5$$ENDHEX$$', '$$HEX2$$5cd500ae$$ENDHEX$$'
// $$HEX8$$01c638bba8badcb42000c0bc58d62000$$ENDHEX$$-> 'e', 'eng', 'english', '0', '$$HEX1$$01c6$$ENDHEX$$', '$$HEX2$$01c6b4c5$$ENDHEX$$'
// Return
// 0 = $$HEX2$$e4c228d3$$ENDHEX$$
// 1 = $$HEX2$$31c1f5ac$$ENDHEX$$

if isnull(aw_inputwin) then return -1
if not isvalid(aw_inputwin)  then return -1

constant long IME_CMODE_ALPHANUMERIC = 0
constant long IME_CMODE_HANGEUL = 1
constant long IME_SMODE_NONE = 0

ulong lul_hndl, lul_imctx
long ll_cmode, ll_smode

lul_hndl = handle(aw_inputwin)
lul_imctx = ImmGetContext(lul_hndl)

choose case lower(as_mode)
	// change keyboard layout to korean
	case 'k', 'kor', 'korean', '1', '$$HEX1$$5cd5$$ENDHEX$$', '$$HEX2$$5cd500ae$$ENDHEX$$'
		ll_cmode = 1
	// change keyboard layout to english
	case 'e', 'eng', 'english', '0', '$$HEX1$$01c6$$ENDHEX$$', '$$HEX2$$01c6b4c5$$ENDHEX$$'
		ll_cmode = 0
	case else
		return 0
end choose

ll_smode = 0
ImmSetConversionStatus(lul_imctx, ll_cmode, ll_smode)

return 1

end function

public function string of_pathgetfileext (string as_filepath);// $$HEX4$$0cd37cc7bdac5cb8$$ENDHEX$$($$HEX1$$85ba$$ENDHEX$$)$$HEX13$$d0c51cc120000cd37cc7200055d6a5c790c720006cad58d530ae$$ENDHEX$$
long ll_lastpos
string ls_extension

ll_lastpos = lastpos(as_filepath, ".")
if ll_lastpos > 0 then
	ls_extension = mid(as_filepath, ll_lastpos + 1)
end if

return ls_extension

end function

on pf_n_pentalibrary.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_pentalibrary.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_powerframetemppath = this.of_getsystemtemppath() + 'pentalib\'
if not directoryexists(is_powerframetemppath) then
	createdirectory(is_powerframetemppath)
end if

end event


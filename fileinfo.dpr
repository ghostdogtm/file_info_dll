library fileinfo;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils, Classes, Windows;

{$R *.res}

function GetFileEditDate(FileName: PChar):PChar; cdecl;
var
  IntFileAge: LongInt;
begin
  IntFileAge:= FileAge(FileName);
  if (IntFileAge = -1) then
    Result:='0'
  else
    Result:=PChar(FormatDateTime('dd.mm.yyyy', FileDateToDateTime(IntFileAge)))
end;

function GetFileCreateDate(FileName: PChar):PChar; cdecl;
var
  FileHandle: THandle;
  FileCreate: TFileTime;
  SystemTime: TSystemTime;
begin
  FileHandle:=CreateFile(PChar(FileName), 0, 0, nil, OPEN_EXISTING,
                         FILE_FLAG_BACKUP_SEMANTICS, 0);
  if (FileHandle<>INVALID_HANDLE_VALUE) then
  begin
    GetFileTime(FileHandle, @FileCreate, nil, nil);
    FileTimeToLocalFileTime(FileCreate, FileCreate);
    FileTimeToSystemTime(FileCreate, SystemTime);
    Result:=PChar(FormatDateTime('dd.mm.yyyy',
                                  SystemTimeToDateTime(SystemTime)));
  end
  else
    Result:='0'
end;

exports GetFileCreateDate, GetFileEditDate;

begin
end.

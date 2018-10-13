#define init_fileinfo_dll
/*
init_fileinfo_dll();

Arguments:
-None-

Return Value:
-None-

Description:
Must be called somewhere BEFORE any other fileinfo related function is called.
*/

dllname = "fileinfo.dll";

global.get_file_create_date = external_define(dllname, "GetFileCreateDate", dll_cdecl, ty_string, 1, ty_string);
global.get_file_edit_date = external_define(dllname, "GetFileEditDate", dll_cdecl, ty_string, 1, ty_string);

#define fileinfo_get_create_date
/*
fileinfo_get_create_date(filename);

Arguments:
[0]filename:String = The name of the file

Return Value:
returns create date of file
*/

return external_call(global.get_file_create_date, argument0);

#define fileinfo_get_edit_date
/*
fileinfo_get_edit_date(filename);

Arguments:
[0]filename:String = The name of the file

Return Value:
returns edit date of file
*/

return external_call(global.get_file_edit_date, argument0);


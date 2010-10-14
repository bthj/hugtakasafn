set db [ns_db gethandle]
set sql_query "select enska from stopplisti order by enska asc"
set selection [ns_db select $db $sql_query]
set arr_enska ""
while { [ns_db getrow $db $selection] } {
  set_variables_after_query
  append arr_enska "\"$enska\", "
}
set arr_enska [string range $arr_enska 0 end-2]

ns_return 200 "text/html" "doStopList(new Array($arr_enska));"

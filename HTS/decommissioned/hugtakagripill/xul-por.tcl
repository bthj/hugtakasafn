set_the_usual_form_variables 0
if { [info exists skjal] } {
  set db [ns_db gethandle]
  set sql_query "select nr, skrarheiti, enska, islenska from hugtakagripill_por where skrarheiti = '$skjal'"
  set selection [ns_db select $db $sql_query]
  set skrarheiti $skjal
  set arr_nr ""
  set arr_enska ""
  set arr_islenska ""
  while { [ns_db getrow $db $selection] } {
    set_variables_after_query
    append arr_nr "\"$nr\", "
    # gæsalappir hreinsağar, ætti kannski şegar ağ vera búiğ ağ şví í gagnagrunni?
    regsub -all "\"" $enska "\\\"" enska
    regsub -all "\"" $islenska "\\\"" islenska
    append arr_enska "\"$enska\", "
    append arr_islenska "\"$islenska\", "
  }
  set arr_nr [string range $arr_nr 0 end-2]
  set arr_enska [string range $arr_enska 0 end-2]
  set arr_islenska [string range $arr_islenska 0 end-2]
  ns_return 200 "text/html" "doPairTree(new Array($arr_nr), \"$skrarheiti\", new Array($arr_enska), new Array($arr_islenska));"
}
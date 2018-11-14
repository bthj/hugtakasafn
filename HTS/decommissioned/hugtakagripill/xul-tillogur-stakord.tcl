set_the_usual_form_variables 0
if { [info exists skjal] && [info exists parnr]} {
  set db [ns_db gethandle]
  set sql_query "select ord, idx_start, idx_end from hugtakagripill_tillogur_stakord where par_skrarheiti = '$skjal' and par_nr = '$parnr'"
  set selection [ns_db select $db $sql_query]
  set arr_tillaga ""
  set arr_idx_start ""
  set arr_idx_end ""
  while { [ns_db getrow $db $selection] } {
    set_variables_after_query
    append arr_tillaga "\"$ord\", "
    append arr_idx_start "\"$idx_start\", "
    append arr_idx_end "\"$idx_end\", "
  }
  set arr_tillaga [string range $arr_tillaga 0 end-2]
  set arr_idx_start [string range $arr_idx_start 0 end-2]
  set arr_idx_end [string range $arr_idx_end 0 end-2]
  ns_return 200 "text/html" "doSuggestionsListbox(new Array($arr_tillaga), new Array($arr_idx_start), new Array($arr_idx_end));"
}

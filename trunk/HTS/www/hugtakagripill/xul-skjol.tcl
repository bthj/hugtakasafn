set db [ns_db gethandle]
set sql_query "select skrarheiti, flokkun, rit, bls, dags from hugtakagripill_skjol order by skrarheiti"
set selection [ns_db select $db $sql_query]
set arr_skrarheiti ""
set arr_flokkun ""
set arr_rit ""
set arr_bls ""
set arr_dags ""
while { [ns_db getrow $db $selection] } {
  set_variables_after_query
  append arr_skrarheiti "\"$skrarheiti\", "
  append arr_flokkun "\"[string range $flokkun 0 4]\", "
  append arr_rit "\"$rit\", "
  append arr_bls "\"$bls\", "
  append arr_dags "\"$dags\", "
}
set arr_skrarheiti [string range $arr_skrarheiti 0 end-2]
set arr_flokkun [string range $arr_flokkun 0 end-2]
set arr_rit [string range $arr_rit 0 end-2]
set arr_bls [string range $arr_bls 0 end-2]
set arr_dags [string range $arr_dags 0 end-2]
ns_return 200 "text/html" "doBakDocTree(new Array($arr_skrarheiti), new Array($arr_flokkun), new Array($arr_rit), new Array($arr_bls), new Array($arr_dags));"

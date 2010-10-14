set db [ns_db gethandle]
set sql_query "select id, dags, enska, islenska, daemi_enska, daemi_islenska, rit, skjal_nr, samheiti, svid, uppruni_skjals, heimild, athugasemd, adalord, ordflokkur, kyn, onnur_malfraedi, skammstofun, skilgreining, nafn_ordtaka from hugtakagripill_hugtok where hidden = 'f' order by dags desc"
set selection [ns_db select $db $sql_query]
set arr_id ""
set arr_dags ""
set arr_enska ""
set arr_islenska ""
set arr_daemi_enska ""
set arr_daemi_islenska ""
set arr_rit ""
set arr_skjal_nr ""
set arr_samheiti ""
set arr_svid ""
set arr_uppruni_skjals ""
set arr_heimild ""
set arr_athugasemd ""
set arr_adalord ""
set arr_ordflokkur ""
set arr_kyn ""
set arr_onnur_malfraedi ""
set arr_skammstofun ""
set arr_skilgreining ""
set arr_nafn_ordtaka ""
while { [ns_db getrow $db $selection] } {
  set_variables_after_query
  append arr_id "\"$id\", "
  append arr_dags "\"$dags\", "
  	regsub -all "\"" $enska "\\\"" enska
  append arr_enska "\"$enska\", "
  	regsub -all "\"" $islenska "\\\"" islenska
  append arr_islenska "\"$islenska\", "
  	regsub -all "\"" $daemi_enska "\\\"" daemi_enska
        regsub -all "\[^a-zA-Z \]" $daemi_enska "-" daemi_enska
  append arr_daemi_enska "\"$daemi_enska\", "
  	regsub -all "\"" $daemi_islenska "\\\"" daemi_islenska
	regsub -all "\[^a-zA-Z \]" $daemi_islenska "-" daemi_islenska
  append arr_daemi_islenska "\"$daemi_islenska\", "
  append arr_rit "\"$rit\", "
  append arr_skjal_nr "\"$skjal_nr\", "
  append arr_samheiti "\"$samheiti\", "
  append arr_svid "\"$svid\", "
  append arr_uppruni_skjals "\"$uppruni_skjals\", "
  append arr_heimild "\"$heimild\", "
	regsub -all "\[^a-zA-Z \]" $athugasemd "" athugasemd
  append arr_athugasemd "\"$athugasemd\", "
  append arr_adalord "\"$adalord\", "
  append arr_ordflokkur "\"$ordflokkur\", "
  append arr_kyn "\"$kyn\", "
  append arr_onnur_malfraedi "\"$onnur_malfraedi\", "
  append arr_skammstofun "\"$skammstofun\", "
  append arr_skilgreining "\"$skilgreining\", "
  append arr_nafn_ordtaka "\"$nafn_ordtaka\", "
}
set arr_id [string range $arr_id 0 end-2]
set arr_dags [string range $arr_dags 0 end-2]
set arr_enska [string range $arr_enska 0 end-2]
#      regsub -all " $arr_enska "" arr_enska
set arr_islenska [string range $arr_islenska 0 end-2]
set arr_daemi_enska [string range $arr_daemi_enska 0 end-2]
      regsub -all "\\(" $arr_daemi_enska "\\(" arr_daemi_enska
      regsub -all "\\)" $arr_daemi_enska "\\)" arr_daemi_enska
      regsub -all "\\]" $arr_daemi_enska "" arr_daemi_enska
      regsub -all "\\\[" $arr_daemi_enska "" arr_daemi_enska
      regsub -all "\'" $arr_daemi_enska "" arr_daemi_enska
      regsub -all ";" $arr_daemi_enska "" arr_daemi_enska
set arr_daemi_islenska [string range $arr_daemi_islenska 0 end-2]
      regsub -all "\\(" $arr_daemi_islenska "\\(" arr_daemi_islenska
      regsub -all "\\)" $arr_daemi_islenska "\\)" arr_daemi_islenska
set arr_rit [string range $arr_rit 0 end-2]
set arr_skjal_nr [string range $arr_skjal_nr 0 end-2]
set arr_samheiti [string range $arr_samheiti 0 end-2]
set arr_svid [string range $arr_svid 0 end-2]
set arr_uppruni_skjals [string range $arr_uppruni_skjals 0 end-2]
set arr_heimild [string range $arr_heimild 0 end-2]
set arr_athugasemd [string range $arr_athugasemd 0 end-2]
set arr_adalord [string range $arr_adalord 0 end-2]
set arr_ordflokkur [string range $arr_ordflokkur 0 end-2]
set arr_kyn [string range $arr_kyn 0 end-2]
set arr_onnur_malfraedi [string range $arr_onnur_malfraedi 0 end-2]
set arr_skammstofun [string range $arr_skammstofun 0 end-2]
set arr_skilgreining [string range $arr_skilgreining 0 end-2]
set arr_nafn_ordtaka [string range $arr_nafn_ordtaka 0 end-2]

ns_return 200 "text/html" "doHugtokList(new Array($arr_id), new Array($arr_dags), new Array($arr_enska), new Array($arr_islenska), new Array($arr_daemi_enska), new Array($arr_daemi_islenska), new Array($arr_rit), new Array($arr_skjal_nr), new Array($arr_samheiti), new Array($arr_svid), new Array($arr_uppruni_skjals), new Array($arr_heimild), new Array($arr_athugasemd), new Array($arr_adalord), new Array($arr_ordflokkur), new Array($arr_kyn), new Array($arr_onnur_malfraedi), new Array($arr_skammstofun), new Array($arr_skilgreining), new Array($arr_nafn_ordtaka));"

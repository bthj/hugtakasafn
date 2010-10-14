set_the_usual_form_variables 0
if { [info exists id] } {
  set db [ns_db gethandle]
  set sql_query "select id, dags, enska, islenska, daemi_enska, daemi_islenska, rit, skjal_nr, samheiti, svid, heimild, athugasemd, adalord, ordflokkur, kyn, onnur_malfraedi, skammstofun, skilgreining, nafn_ordtaka, gilding, enska_skammstofun, islenska_annar_rith, enska_annar_rith, da_no_sae, de, fr, la from hugtakagripill_hugtok where id = '$id'"
  set selection [ns_db select $db $sql_query]
  ns_db getrow $db $selection
  set_variables_after_query
  ns_return 200 "text/html" "doInsertHugtakData(\"$id\", \"$dags\", \"$enska\", \"$islenska\", \"$daemi_enska\", \"$daemi_islenska\", \"$rit\", \"$skjal_nr\", \"$samheiti\", \"$svid\", \"$heimild\", \"$athugasemd\", \"$adalord\", \"$ordflokkur\", \"$kyn\", \"$onnur_malfraedi\", \"$skammstofun\", \"$skilgreining\", \"$nafn_ordtaka\", \"$gilding\", \"$enska_skammstofun\", \"$islenska_annar_rith\", \"$enska_annar_rith\", \"$da_no_sae\", \"$de\", \"$fr\", \"$la\")"
}
ns_write "HTTP/1.0 200 OK
#Content-Type: text/plain; charset=utf-8
Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
pragma: no-cache
Server: AOLserver/3.3.1+ad13

"

set db [ns_db gethandle]
set sql_query "select to_char(dags, 'DD.MM.YYYY - HH24:MI:SS') as dagsconverted, nafn_ordtaka, enska, islenska, adalord, ordflokkur, kyn, 
		onnur_malfraedi, svid, skilgreining, daemi_enska, daemi_islenska, rit, 
		enska_skammstofun, enska_annar_rith, skammstofun, islenska_annar_rith, 
		da_no_sae, de, fr, la, heimild, skjal_nr from hugtakagripill_hugtok where hidden = 'f' order by dags desc"
set selection [ns_db select $db $sql_query]
while { [ns_db getrow $db $selection] } {
  set_variables_after_query
  ns_write "**\n"
  ns_write "<Creation Date>$dagsconverted\n"
  ns_write "<Created By>$nafn_ordtaka\n"
  ns_write "<Change Date>$dagsconverted\n"
  ns_write "<Changed By>$nafn_ordtaka\n"
  ns_write "<Entry Class>1\n"
  ns_write "<EN>$enska\n"
  ns_write "<IS>$islenska\n"
  ns_write "<aðalorð>$adalord\n"
  ns_write "<orðfl.>$ordflokkur\n"
  ns_write "<kyn>$kyn\n"
  ns_write "<önnur málfr.>$onnur_malfraedi\n"
  ns_write "<svið>$svid\n"
  ns_write "<skilgr.>$skilgreining\n"
  ns_write "<dæmi>$daemi_enska \n $daemi_islenska\n"
  ns_write "<rit>$rit\n"
  ns_write "<heimild>$heimild\n"
  ns_write "<skjal nr.>$skjal_nr\n"
  ns_write "<EN skst.>$enska_skammstofun\n"
  ns_write "<EN annar rith.>$enska_annar_rith\n"
  ns_write "<IS skst.>$skammstofun\n"
  ns_write "<IS annar rith.>$islenska_annar_rith\n"
  ns_write "<DA/NO/SÆ>$da_no_sae\n"
  ns_write "<DE>$de\n"
  ns_write "<FR>$fr\n"
  ns_write "<LA>$la\n"
}

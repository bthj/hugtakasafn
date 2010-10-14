ns_write "HTTP/1.0 200 OK
Content-Type: text/html; charset=iso-8859-1
MIME-Version: 1.0
pragma: no-cache
Server: AOLserver/3.3.1+ad13

"

set sed_file "/home/hugtakasafn/bakfix.sed"

set where_the_data_is [ns_queryget clientfile.tmpfile]
#ns_write "where_the_data_is: $where_the_data_is"

exec /bin/sed -f $sed_file $where_the_data_is > "$where_the_data_is.fix"

set filefix [open "$where_the_data_is.fix"]
set data [read $filefix]
close $filefix

set db [ns_db gethandle]

regsub "\.BAK" [ns_queryget clientfile] "" skrarheiti
ns_write "<b>Skjal n�mer:</b> $skrarheiti<br/>"
set selection [ns_db select $db "select skrarheiti from hugtakagripill_skjol where skrarheiti ilike '$skrarheiti'"]
if { [ns_db getrow $db $selection] } {
  ns_write "<p>Skjal er �egar � skr�.</p><p><a href=\"fileuploadb.html\">Hla�a inn annarri .BAK skr�</a></p>"
  ns_conn close
  return
}
# rit og dags.
regexp {byrjunrrriiittt(.*?)rrriiitttendirdddaaagggsssbyrjun(.*?)dddaaagggsssendir} $data ritdags_matchvar rit dags
if { ![info exists rit] } {
  set rit ""
}
if { ![info exists dags] } {
  set dags [clock format [clock seconds] -format %Y-%m-%d]
} else {
  set list_dags [split $dags "."]
  if [catch {set dags [clock format [clock scan [lindex $list_dags 2]-[lindex $list_dags 1]-[lindex $list_dags 0]] -format %Y-%m-%d]} result] {
    ns_write "<p style=\"color:red;\">Villa kom upp vi� a� lesa �r dagsetningu skjals; dags. � dag notu� ($result).</p>"
    set dags [clock format [clock seconds] -format %Y-%m-%d]    
  } else {
  
  }
}
ns_write "<b>rit:</b> $rit<br/>"
ns_write "<b>dags:</b> $dags<br/>"
# flokkun
regexp {floookkkuuunnnbyrjun(.*?)floookkkuuunnnendir} $data flokkun_matchvar flokkun
if { ![info exists flokkun] } {
  set flokkun ""
}
regsub "/$" $flokkun "" flokkun
ns_write "<b>flokkun:</b> $flokkun<br/>"
# bladsida
set index 0
list lBladsidur
while { [regexp -start $index {blaaadddsssiiidabyrjun(.*?)blaaadddsssiiidaendir} $data bladsidu_matchvar bls] } {
  regexp -start $index -indices {blaaadddsssiiidabyrjun(.*?)blaaadddsssiiidaendir} $data matchvar_placeholder idx_bls
  ns_write "bls: $bls ($idx_bls) <br/>"
  lappend lBladsidur $bls
  set index [lindex $idx_bls 1]
}
if { [info exists lBladsidur] } {
  set lBladsidur [lsort $lBladsidur]
  ns_write "<b>bls ra�a�:</b> $lBladsidur"
} else {
  set lBladsidur ""
}
ns_write "<p>skr�i skjal"
ns_db dml $db "insert into hugtakagripill_skjol 
		(skrarheiti, flokkun, rit, bls, dags, processed) 
		values 
		('$skrarheiti', '[DoubleApos [string trim $flokkun]]', '[DoubleApos [string trim $rit]]', '[DoubleApos [string trim $lBladsidur]]', '[DoubleApos [string trim $dags]]', 'f')"
ns_write " - loki�</p>"

set index 0
set termColorIndex 0
set par_nr 0

while { [regexp -start $index {\{0>(.*?)<\}.*?\{>(.*?)<0\}} $data par par_eng par_isl] } {
  regexp -start $index -indices {\{0>(.*?)<\}.*?\{>(.*?)<0\}} $data matchvar_placeholder idx_eng idx_isl
  set index [lindex $idx_isl 1]
  
  incr par_nr
ns_write "<p>par $par_nr skr��"
  ns_db dml $db "insert into hugtakagripill_por 
  		(nr, skrarheiti, enska, islenska, processed) 
  		values 
  		($par_nr, '$skrarheiti', '[DoubleApos [string trim $par_eng]]', '[DoubleApos [string trim $par_isl]]', 'f')"
ns_write " - loki�</p>"
  # Vinnsla stakor�a �r enskum hluta pars
  set par_eng_stakord [split $par_eng]
  set tillogur ""
  set idx_start 0
  set idx_end 0
ns_write "<ul>"
  foreach stakord $par_eng_stakord {
    if {[string match -nocase {[A-z]*} $stakord]} {
      set stakord [string trim $stakord ".,;\'\":?"]

      regsub -all "\\(" $stakord "" stakord
      regsub -all "\\)" $stakord "" stakord
      regsub -all "\\{" $stakord "" stakord
      regsub -all "\\}" $stakord "" stakord
      regsub -all "\\'" $stakord "" stakord
      set selection [ns_db select $db "select enska from stopplisti where enska ilike '$stakord'"]
      # er stakor� � stopplista?
      if { ![ns_db getrow $db $selection] } {
        set selection [ns_db select $db "select enska from hugtakagripill_hugtok where enska ilike '$stakord'"]
        # er stakor� � hugtakalista gripils?
        if { ![ns_db getrow $db $selection] } {
	  set selection [ns_db select $db "select lang_en from hugtakasafn where lang_en ilike '$stakord'"]
	  # er stakor� til � hugtakasafni?
	  if { ![ns_db getrow $db $selection] } {
	    # finna upphafs og enda index stakor�s � pari, og skr� � grunn
	    regexp -indices "\\m($stakord)\\M" $par_eng matchvar_placeholder stakord_idx
	    set idx_start -1
	    set idx_end -1
	    if { [info exists stakord_idx] } {
	      set idx_start [lindex $stakord_idx 0]
	      set idx_end [lindex $stakord_idx 1]
	    } else {
	      set idx_start -1
	      set idx_end -1
	      ns_write "<li>upphafs- og endapunktar stakor�s finnast ekki, settir sem -1</li>"
	    }

  ns_write "<li>set inn or� $stakord, byrjar � $idx_start og endar � $idx_end</li>"
	    ns_db dml $db "insert into hugtakagripill_tillogur_stakord 
			  (par_nr, par_skrarheiti, ord, idx_start, idx_end) 
			  values 
			  ($par_nr, '$skrarheiti', '[DoubleApos [string trim $stakord]]', $idx_start, $idx_end)"

	  }
	}
      }
    }
  }
ns_write "</ul>"
ns_write "<p>skr�i par sem unni�</p>"
  # par hefur veri� unni�
  ns_db dml $db "update hugtakagripill_por set processed = 't' where nr = $par_nr and skrarheiti = '$skrarheiti'"

  
}
ns_write "<p>skr�i skjal sem unni�</p>"
# �ll p�r � skjali hafa veri� unnin
ns_db dml $db "update hugtakagripill_skjol set processed = 't' where skrarheiti = '$skrarheiti'"

ns_write "<p><a href=\"fileuploadb.html\">Hla�a inn annarri .BAK skr�</a></p>"

ns_conn close


exec /bin/rm "$where_the_data_is.fix"

#ns_returnredirect ./hugtakagripill.tcl
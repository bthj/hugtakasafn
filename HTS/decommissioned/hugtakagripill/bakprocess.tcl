ns_write "HTTP/1.0 200 OK
Content-Type: text/html; charset=utf-8
MIME-Version: 1.0
pragma: no-cache
Server: AOLserver/3.3.1+ad13

"

set sed_file "/home/hugtakasafn/bakfix.sed"
set termColor [list "yellow" "lightpink" "aquamarine" "darkgoldenrod" "darkseagreen" "lightgreen" "rosybrown" "seagreen" "chocolate" "violet"]

set where_the_data_is [ns_queryget clientfile.tmpfile]
#ns_write "where_the_data_is: $where_the_data_is"

exec /bin/sed -f $sed_file $where_the_data_is > "$where_the_data_is.fix"

set filefix [open "$where_the_data_is.fix"]
set data [read $filefix]
close $filefix

set skrarheiti [ns_queryget clientfile]
set index 0
set termColorIndex 0
set db [ns_db gethandle]
while { [regexp -start $index {\{0>(.*?)<\}.*?\{>(.*?)<0\}} $data par par_eng par_isl] } {
  regexp -start $index -indices {\{0>(.*?)<\}.*?\{>(.*?)<0\}} $data matchvar_placeholder idx_eng idx_isl
  set index [lindex $idx_isl 1]
  set par_eng_stakord [split $par_eng]
  set tillogur ""
  foreach stakord $par_eng_stakord {
    if {[string match -nocase {[A-z]*} $stakord]} {
      set stakord [string trim $stakord ".,;\'\":?"]
      regsub -all "\\(" $stakord "" stakord
      regsub -all "\\)" $stakord "" stakord
      regsub -all "\\{" $stakord "" stakord
      regsub -all "\\}" $stakord "" stakord
      regsub -all "\\'" $stakord "" stakord
      set selection [ns_db select $db "select enska from stopplisti where enska ilike '$stakord'"]
      if { ![ns_db getrow $db $selection] } {
	set selection [ns_db select $db "select lang_en from hugtakasafn where lang_en ilike '$stakord'"]
	if { ![ns_db getrow $db $selection] } {
	  append tillogur "$stakord<br/>"
	  regsub -nocase "\\m$stakord\\M" $par_eng "<b style=\"color:black;background-color:[lindex $termColor $termColorIndex]\">&</b>" par_eng
	  incr termColorIndex
	  if {!([llength $termColor] > $termColorIndex)} {
	    set termColorIndex 0
	  }
	}
      }
    }
  }
  set termColorIndex 0
  ns_write "<b>par:</b> $par <br/><b>par_eng:</b> $par_eng <b>$idx_eng</b><br/> <b>par_isl:</b> $par_isl <b>$idx_isl</b><br/><b>Tillögur</b><br/>$tillogur<hr/>"
  
#  ns_db dml $db "insert into por (enska, islenska, skrarheiti) values ('[DoubleApos [string trim $par_eng]]', '[DoubleApos [string trim $par_isl]]', '$skrarheiti')"
  
}
# rit og dags.
regexp {byrjunrrriiittt(.*?)rrriiitttendirdddaaagggsssbyrjun(.*?)dddaaagggsssendir} $data ritdags_matchvar rit dags
if { ![info exists rit] } {
  set rit ""
}
if { ![info exists dags] } {
  set dags ""
}
ns_write "<b>rit:</b> $rit<br/>"
ns_write "<b>dags:</b> $dags<br/>"

# flokkun
regexp {floookkkuuunnnbyrjun(.*?)floookkkuuunnnendir} $data flokkun_matchvar flokkun
if { ![info exists flokkun] } {
  set flokkun ""
}
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
  ns_write "<b>bls raðað:</b> $lBladsidur"
}

#exec /bin/rm "$where_the_data_is.fix"

#ns_returnredirect ./hugtakagripill.tcl
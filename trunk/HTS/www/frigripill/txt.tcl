ns_write "HTTP/1.0 200 OK
Content-Type: text/html; charset=iso-8859-1
MIME-Version: 1.0
pragma: no-cache
Server: AOLserver/3.3.1+ad13

"

ns_write "<html><body><ul>"

set where_the_data_is [ns_queryget clientfile.tmpfile]

exec /usr/bin/abiword --to=txt $where_the_data_is > "$where_the_data_is.txt"

set filetxt [open "$where_the_data_is.txt"]
set data [read $filetxt]
close $filetxt

set db [ns_db gethandle]

set stakord_data [split $data]

list lStakord
foreach stakord $stakord_data {
	if {[string is alpha $stakord]} {
		set stakord [string trim $stakord ".,;\'\":?"]
		regsub -all "\\(" $stakord "" stakord
		regsub -all "\\)" $stakord "" stakord
		regsub -all "\\{" $stakord "" stakord
		regsub -all "\\}" $stakord "" stakord
		regsub -all "\\'" $stakord "" stakord
		
		set selection [ns_db select $db "select enska from stopplisti where enska ilike '$stakord'"]
		# er stakorð á stopplista?
		if { ![ns_db getrow $db $selection] } {
			set selection [ns_db select $db "select enska from hugtakagripill_hugtok where enska ilike '$stakord' or islenska ilike '$stakord'"]
			# er stakorð í hugtakalista gripils?
			if { ![ns_db getrow $db $selection] } {
				set selection [ns_db select $db "select lang_en from hugtakasafn where lang_en ilike '$stakord' or lang_is ilike '$stakord'"]
				# er stakorð til í hugtakasafni?
				if { ![ns_db getrow $db $selection] } {
					#ns_write "<li>$stakord</li>"
					if { ![info exists lStakord] } {
						lappend lStakord $stakord
					} else {
						if [lsearch $lStakord $stakord]<0 {
							lappend lStakord $stakord
						}
					}
				}
			}
		}
	}
}
foreach stakord $lStakord {
	ns_write "<li>$stakord</li>"
}
ns_write "</ul><p><em>Keyslu lokið</em> <a href=\"./\">Lesa úr annari skrá</a></p></body></html>"


exec /bin/rm "$where_the_data_is.txt"

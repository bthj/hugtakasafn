ns_write "HTTP/1.0 200 OK
Content-Type: text/html; charset=utf-8
MIME-Version: 1.0
pragma: no-cache
Server: AOLserver/3.3.1+ad13

"

set where_the_data_is [ns_queryget clientfile.tmpfile]

exec /usr/bin/abiword --to=txt $where_the_data_is > "$where_the_data_is.txt"
set filetxt [open "$where_the_data_is.txt"]
set data [read $filetxt]
close $filetxt

exec /usr/bin/abiword --to=html $where_the_data_is > "$where_the_data_is.html"
set filehtml [open "$where_the_data_is.html"]
set datahtml [read $filehtml]
close $filehtml

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
					regsub -all $stakord $datahtml "<b style=\"color:black;background-color:#ffff66\">&</b>" datahtml
				}
			}
		}
	}
}


ns_write $datahtml


exec /bin/rm "$where_the_data_is.txt"
exec /bin/rm "$where_the_data_is.html"
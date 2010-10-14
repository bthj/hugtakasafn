# bangsi@bthj.is 2005-05-05
# Setur stakorð á stopplista og eyðir tillögum um það orð í öllum pörum

set_the_usual_form_variables

if { [info exists tillaga] && ![empty_string_p $tillaga] } {
  set db [ns_db gethandle]
  ns_db dml $db "insert into stopplisti
  		(enska)
  		values
  		('$QQtillaga')
  		"
  # eyða öllum tillögum
  ns_db dml $db "delete from hugtakagripill_tillogur_stakord where ord = '$QQtillaga'"
}

ns_return 200 "text/plain" "success"
# bangsi@bthj.is 2005-10-06
# Eyðir færslu hugtaks

set_the_usual_form_variables

set db [ns_db gethandle]

set sql "delete from hugtakagripill_hugtok where id = '$id'"

ns_db dml $db $sql

ns_return 200 "text/plain" "success"

# bangsi@bthj.is 2006-05-08
# Flaggar öll hugtök sem falin

set db [ns_db gethandle]

set sql "update hugtakagripill_hugtok set hidden = 't'"

ns_db dml $db $sql

ns_return 200 "text/html" "<html><head><title>Borð hreinsað</title></head><body><strong>Öll hugtök merkt sem falin - borðið hreinsað</strong></body></html>"



# bangsi@bthj.is 2006-05-08
# Flaggar �ll hugt�k sem falin

set db [ns_db gethandle]

set sql "update hugtakagripill_hugtok set hidden = 't'"

ns_db dml $db $sql

ns_return 200 "text/html" "<html><head><title>Bor� hreinsa�</title></head><body><strong>�ll hugt�k merkt sem falin - bor�i� hreinsa�</strong></body></html>"



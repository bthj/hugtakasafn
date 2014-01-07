ns_write "HTTP/1.0 200 OK
Content-Type: text/html; charset=utf-8
MIME-Version: 1.0
pragma: no-cache
Server: AOLserver/3.3.1+ad13

"

set doc [dom parse "<?xml version=\"1.0\" encoding=\"UTF-8\"?><descrip><descripText>Sjá einnig <xref>adopt</xref>, <xref>prepare</xref>, <xref>introduce</xref> og <xref>lay down</xref>.</descripText></descrip>"]
set root [$doc documentElement]
#set descrip [$root child 1 descrip]
set descriptext [$root descendant 1 descripText]
set tekst [$descriptext asXML -indent none]
ns_write $tekst
ns_write "hallo"




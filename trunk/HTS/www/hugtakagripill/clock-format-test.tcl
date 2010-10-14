 
#set dags [clock format [clock seconds] -format %Y-%m-%d]

set dags "16.12.2002"
set list_dags [split $dags "."]

set dags [clock format [clock scan [lindex $list_dags 2]-[lindex $list_dags 1]-[lindex $list_dags 0]] -format %Y-%m-%d]
 
ns_return 200 text/plain $dags
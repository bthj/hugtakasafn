#set sed_file "/home/hugtakasafn/bakfix.sed"

#set where_the_data_is [ns_queryget clientfile.tmpfile]
#ns_write "where_the_data_is: $where_the_data_is"

#exec /bin/sed -f $sed_file $where_the_data_is > "$where_the_data_is.fix"

#set filefix [open "$where_the_data_is.fix"]
#set data [read $filefix]
#close $filefix

#set skrarheiti [ns_queryget clientfile]

#set formset [ns_getform]

#ns_log Notice [ns_set value [ns_getform] 0]

#ns_log Notice [ns_queryget clientfile]

set chan [open /tmp/xmlhttpskra.txt a]
puts $chan "[ns_set value [ns_getform] 0]"
close $chan

ns_return 200 "text/plain" "[ns_set value [ns_getform] 0]"
regsub -all "/$" "L 2/87/" "" skrarheiti
ns_return 200 "text/plain" "$skrarheiti"
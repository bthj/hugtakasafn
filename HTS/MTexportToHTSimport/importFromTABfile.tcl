#!/usr/bin/tclsh
#


#if { $argc != 1 } {
#    puts "Engin export skra tiltekin"
#} else {
    set this_path [file dirname $argv0]
#    set file_name [file rootname [lindex $argv 0]]
    set file_name "exportCombined"

    set export_dir "$this_path/../import/"
    set import_dir "/tmp/"
    set import_file_name "$file_name.tab"

    exec /bin/cp "$export_dir$import_file_name" "$import_dir"
    # hack around SELinux restrictions - https://stackoverflow.com/a/28595245/169858
    exec /usr/bin/chcon -t postgresql_tmp_t "$import_dir$import_file_name"
    exec /usr/bin/psql -c "delete from hugtakasafn" hugtakasafn
    puts "Les inn i gagnagrunn ur $import_dir$import_file_name"
    exec /usr/bin/psql -c "copy hugtakasafn from '$import_dir$import_file_name'" hugtakasafn
    exec /usr/bin/psql -c "insert into hugtakasafn_updated (updated) values (current_timestamp)" hugtakasafn
    puts "Hreinsa til i gagnagrunni og uppfaeri tolfraediupplysingar um gogn..."
    if [catch {exec /usr/bin/vacuumdb "-q" "-z" "hugtakasafn"} errmsg] {
      puts "Villa: $errmsg"
    }

    #puts "Eydi $import_dir$import_file_name"
    #exec /bin/rm "$import_dir$import_file_name"

    puts "Keyrslu lokid."

#}

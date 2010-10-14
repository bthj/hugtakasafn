#!/usr/bin/tclsh
#

set import_dir "/tmp/"
set import_file_name "051010.tab"

exec /usr/local/pgsql/bin/psql -c "delete from hugtakasafn" hugtakasafn
puts "Les inn i gagnagrunn ur $import_dir$import_file_name"
exec /usr/local/pgsql/bin/psql -c "copy hugtakasafn from '$import_dir$import_file_name'" hugtakasafn
exec /usr/local/pgsql/bin/psql -c "insert into hugtakasafn_updated (updated) values (current_timestamp)" hugtakasafn
puts "Hreinsa til i gagnagrunni og uppfaeri tolfraediupplysingar um gogn..."
if [catch {exec /usr/local/pgsql/bin/vacuumdb "-q" "-z" "hugtakasafn"} errmsg] {
  puts "Villa: $errmsg"
}

#puts "Eydi $import_dir$import_file_name"
#exec /bin/rm "$import_dir$import_file_name"

puts "Keyrslu lokid."


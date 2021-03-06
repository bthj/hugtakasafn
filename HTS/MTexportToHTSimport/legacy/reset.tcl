ns_write "HTTP/1.0 200 OK
Content-Type: text/html; charset=iso-8859-1
MIME-Version: 1.0
pragma: no-cache
Server: AOLserver/3.3.1+ad13

"

ns_write "<p><b>Innlestur SGML gagna hugtakasafns ���ingami�st��var utanr�kisr��uneytis</b></p>"
ns_write "<p>Ath. a� innlestrarskr�r mega hvorki hafa endinguna .sgml n� .xml</p>"

set work_dir "/home/hugtakasafn/import"
set sed_file "/home/hugtakasafn/mtsgmlfix.sed"

if [catch {set file_list [glob [file join $work_dir *]]}] {
  ns_write "<p>Engar skr�r fundust</p>"
} else {
  ns_write "<p>Fann �essa(r) skr�(r) til innlestrar:</p>"
  ns_write "<ul>"
  foreach file $file_list {
    ns_write "<li>"
    ns_write $file
    ns_write "</li>"
  }
  ns_write "</ul>"
  set db [ns_db gethandle]
  foreach file $file_list {
    ns_write "<p>Hef vinnu vi� <b>[file tail $file]</b>:</p>"
    ns_write "<ul>"
    ns_write "<li>Hreinsa og geri l�glegt SGML (skrifast � [file rootname [file tail $file]].sgml)</li>"
    ns_write "<ul>"
    if { [file exists "[file rootname $file].sgml"] } {
      ns_write "<li>[file rootname [file tail $file]].sgml er �egar til, ger�i ekkert.</li>"
    } else {
      exec /bin/sed -f $sed_file $file > "[file rootname $file].sgml"
    }
    ns_write "<li>Loki�</li>"
    ns_write "</ul>"
    ns_write "<li>Breyti SGML � XML (skrifast � [file rootname [file tail $file]].xml)</li>"
    ns_write "<ul>"
    if { [file exists "[file rootname $file].xml"] } {
      ns_write "<li>[file rootname [file tail $file]].xml er �egar til, ger�i ekkert.</li>"
    } else {
      ns_write "<li>"
      if [catch {exec /usr/local/bin/osx "[file rootname $file].sgml" > "[file rootname $file].xml"} errmsg] {
        ns_write $errmsg
      }
    }
    ns_write "</li>"
    ns_write "<li>Loki�</li>"
    ns_write "</ul>"
    ns_write "<li>��tta inn XML tr� �r [file rootname [file tail $file]].xml</li>"
    set in [open "[file rootname $file].xml"]
    set doc [dom parse [read $in]]
    ns_write "<li>Les �r ��ttunartr�</li>"
    set root [$doc documentElement]
    set count 0
    ns_write "<li>Skrifa �r ��ttunartr� � skr� me� TAB a�skildum gildum til innlestrar � gagnagrunn (skrifast � /tmp/[file rootname [file tail $file]].tab)</li>"
    set out [open "/tmp/[file rootname [file tail $file]].tab" w+]
#    fconfigure $out -encoding iso8859-1
    foreach term_entry [$root child all TERMENTRY] {
      set term_entrynumber [[$term_entry descendant 1 ENTRYNUMBER] text]
      set term_en [$term_entry descendant 1 TERM LANG EN]
      if [catch {set term_en_text [$term_en text]}] {
        set term_en_text ""
        set term_en_ordfl_text ""
      } else {
        set term_en_ordfl [$term_en child 1 DESCRIP TYPE ordfl]
        if [catch {set term_en_ordfl_text [$term_en_ordfl text]}] {
          set term_en_ordfl_text ""
        }
      }
      set term_is [$term_entry descendant 1 TERM LANG IS]
      set term_is_xref_text ""
      if { [catch {set term_is_xref_text [[$term_is child 1 XREF] text]}] && [catch {set term_is_text [$term_is text]}] } {
        set term_is_text ""
        set term_is_samh_text ""
        set term_is_svid_text ""
        set term_is_skjalnr_text ""
        set term_is_daemi_text ""
        set term_is_skilgr_text ""
        set term_is_rit_text ""
        set term_is_efnisfl_text ""
        set term_is_onnurmalfr_text ""
          set term_is_adalord_text ""
          set term_is_adalord_ordfl_text ""
          set term_is_adalord_kyn_text ""
      } else {
        if { ![empty_string_p $term_is_xref_text] } {
          set term_is_text $term_is_xref_text
        }
        set term_is_samh [$term_is child 1 DESCRIP TYPE samh.]
        if [catch {set term_is_samh_text [[$term_is_samh child 1 DESCRIPTEXT] text]}] {
          set term_is_samh_text ""
        }
        set term_is_svid [$term_is child 1 DESCRIP TYPE svid]
        if [catch {set term_is_svid_text [[$term_is_svid child 1 DESCRIPTEXT] text]}] {
          set term_is_svid_text ""
        }
        
        set term_is_skjalnr [$term_is child 1 DESCRIP TYPE skjalnr]
        if [catch {set term_is_skjalnr_text [[$term_is_skjalnr child 1 DESCRIPTEXT] text]}] {
          set term_is_skjalnr_text ""
        }
        
        set term_is_daemi [$term_is child 1 DESCRIP TYPE daemi]
        if [catch {set term_is_daemi_text [[$term_is_daemi child 1 DESCRIPTEXT] text]}] {
          set term_is_daemi_text ""
        }
        set term_is_skilgr [$term_is child 1 DESCRIP TYPE skilgr.]
        if [catch {set term_is_skilgr_text [[$term_is_skilgr child 1 DESCRIPTEXT] text]}] {
          set term_is_skilgr_text ""
        }
        set term_is_rit [$term_is child 1 DESCRIP TYPE rit]
        if [catch {set term_is_rit_text [[$term_is_rit child 1 DESCRIPTEXT] text]}] {
          set term_is_rit_text ""
        }
        set term_is_efnisfl [$term_is child 1 DESCRIP TYPE efnisfl.]
        if [catch {set term_is_efnisfl_text [[$term_is_efnisfl child 1 DESCRIPTEXT] text]}] {
          set term_is_efnisfl_text ""
        }
        set term_is_onnurmalfr [$term_is child 1 DESCRIP TYPE onnurmalfr.]
        if [catch {set term_is_onnurmalfr_text [[$term_is_onnurmalfr child 1 DESCRIPTEXT] text]}] {
          set term_is_onnurmalfr_text ""
        }
        set term_is_adalord [$term_is child 1 DESCRIP TYPE adalord]
        if [catch {set term_is_adalord_text [[$term_is_adalord child 1 DESCRIPTEXT] text]}] {
          set term_is_adalord_text ""
        } 
        if [catch {set term_is_adalord_ordfl_text [[$term_is descendant 1 DESCRIPREF TYPE ordfl] text]}] {
          if [catch {set term_is_adalord_ordfl_text [[$term_is descendant 1 DESCRIP TYPE ordfl] text]}] {
            set term_is_adalord_ordfl_text ""
          }
        }
        if [catch {set term_is_adalord_kyn_text [[$term_is descendant 1 DESCRIPREF TYPE kyn] text]}] {
          if [catch {set term_is_adalord_kyn_text [[$term_is descendant 1 DESCRIP TYPE kyn] text]}] {
            set term_is_adalord_kyn_text ""
          }
        }
        set term_is_heimild [$term_is child 1 DESCRIP TYPE heimild]
        if [catch {set term_is_heimild_text [[$term_is_heimild child 1 DESCRIPTEXT] text]}] {
          set term_is_heimild_text ""
        }
        set term_is_aths [$term_is child 1 DESCRIP TYPE aths.]
        if [catch {set term_is_aths_text [[$term_is_aths child 1 DESCRIPTEXT] asXML -indent none]}] {
          set term_is_aths_text ""
        }
      }
      set term_danosae [$term_entry descendant 1 TERM LANG DANOSAE]
      if [catch {set term_danosae_text [$term_danosae text]}] {
        set term_danosae_text ""
      }
      set term_fr [$term_entry descendant 1 TERM LANG FR]
      if [catch {set term_fr_text [$term_fr text]}] {
        set term_fr_text ""
      }
      set term_de [$term_entry descendant 1 TERM LANG DE]
      if [catch {set term_de_text [$term_de text]}] {
        set term_de_text ""
      }
      set term_la [$term_entry descendant 1 TERM LANG LA]
      if [catch {set term_la_text [$term_la text]}] {
        set term_la_text ""
      }
      set term_enskst [$term_entry descendant 1 TERM LANG ENskst]
      if [catch {set term_enskst_text [$term_enskst text]}] {
        set term_enskst_text ""
      }
      set term_enannarrith [$term_entry descendant 1 TERM LANG ENannarrith]
      if [catch {set term_enannarrith_text [$term_enannarrith text]}] {
        set term_enannarrith_text ""
      }
      set term_isskst [$term_entry descendant 1 TERM LANG ISskst]
      if [catch {set term_isskst_text [$term_isskst text]}] {
        set term_isskst_text ""
      }
      set term_isannarrith [$term_entry descendant 1 TERM LANG ISannarrith]
      if [catch {set term_isannarrith_text [$term_isannarrith text]}] {
        set term_isannarrith_text ""
      }
      
      regsub -all "\n" $term_en_text "" term_en_text
      regsub -all "\n" $term_en_ordfl_text "<br/>" term_en_ordfl_text
      regsub -all "\n" $term_is_text "" term_is_text
      regsub -all "\n" $term_is_samh_text "<br/>" term_is_samh_text
      regsub -all "\n" $term_is_svid_text "<br/>" term_is_svid_text
      regsub -all "\n" $term_is_skjalnr_text "<br/>" term_is_skjalnr_text
      regsub -all "\n" $term_is_daemi_text "<br/>" term_is_daemi_text
      regsub -all "\n" $term_is_skilgr_text "<br/>" term_is_skilgr_text
      regsub -all "\n" $term_is_rit_text "<br/>" term_is_rit_text
      regsub -all "\n" $term_is_efnisfl_text "<br/>" term_is_efnisfl_text
      regsub -all "\n" $term_is_onnurmalfr_text "<br/>" term_is_onnurmalfr_text
      regsub -all "\n" $term_is_adalord_text "<br/>" term_is_adalord_text
      regsub -all "\n" $term_is_adalord_ordfl_text "<br/>" term_is_adalord_ordfl_text
      regsub -all "\n" $term_is_adalord_kyn_text "<br/>" term_is_adalord_kyn_text
      regsub -all "\n" $term_danosae_text "" term_danosae_text
      regsub -all "\n" $term_fr_text "" term_fr_text
      regsub -all "\n" $term_de_text "" term_de_text
      regsub -all "\n" $term_la_text "" term_la_text
      regsub -all "\n" $term_enskst_text "<br/>" term_enskst_text
      regsub -all "\n" $term_enannarrith_text "<br/>" term_enannarrith_text
      regsub -all "\n" $term_isskst_text "<br/>" term_isskst_text
      regsub -all "\n" $term_isannarrith_text "<br/>" term_isannarrith_text
      regsub -all "\n" $term_is_heimild_text "<br/>" term_is_heimild_text
      regsub -all "\n" $term_is_aths_text "<br/>" term_is_aths_text
      
      puts $out "$term_entrynumber\t[DoubleApos [string trim $term_is_text]]\t[DoubleApos [string trim $term_en_text]]\t[DoubleApos [string trim $term_danosae_text]]\t[DoubleApos [string trim $term_fr_text]]\t[DoubleApos [string trim $term_de_text]]\t[DoubleApos [string trim $term_la_text]]\t[DoubleApos [string trim $term_is_samh_text]]\t[DoubleApos [string trim $term_is_svid_text]]\t[DoubleApos [string trim $term_is_daemi_text]]\t[DoubleApos [string trim $term_is_skilgr_text]]\t[DoubleApos [string trim $term_is_rit_text]]\t[DoubleApos [string trim $term_is_efnisfl_text]]\t[DoubleApos [string trim $term_is_adalord_text]]\t[DoubleApos [string trim $term_is_adalord_ordfl_text]]\t[DoubleApos [string trim $term_is_adalord_kyn_text]]\t[DoubleApos [string trim $term_is_onnurmalfr_text]]\t[DoubleApos [string trim $term_en_ordfl_text]]\t[DoubleApos [string trim $term_enskst_text]]\t[DoubleApos [string trim $term_enannarrith_text]]\t[DoubleApos [string trim $term_isskst_text]]\t[DoubleApos [string trim $term_isannarrith_text]]\t[DoubleApos [string trim $term_is_heimild_text]]\t[DoubleApos [string trim $term_is_aths_text]]\t[DoubleApos [string trim $term_is_skjalnr_text]]"
      
      incr count
    }
    puts $out "\\."
    flush $out
    close $out
#    exec /bin/chmod 777 "/tmp/[file rootname [file tail $file]].tab"
    ns_write "<ul>"
    ns_write "<li>$count f�rslur skrifa�ar</li>"
    ns_write "</ul>"
    ns_write "<li>Ey�i �llum f�rslum �r gagnagrunni</li>"
    ns_db dml $db "delete from hugtakasafn"
    ns_write "<li>Les inn � gagnagrunn �r /tmp/[file rootname [file tail $file]].tab</li>"
    ns_db dml $db "copy hugtakasafn from '/tmp/[file rootname [file tail $file]].tab'"
    ns_db dml $db "insert into hugtakasafn_updated (updated) values (current_timestamp)"
    ns_write "<li>Hreinsa til � gagnagrunni og uppf�ri t�lfr��iuppl�singar um g�gn...</li>"
    if [catch {exec /usr/local/pgsql/bin/vacuumdb "-q" "-z" "hugtakasafn"} errmsg] {
      ns_write "<li>$errmsg</li>"
    }
    ns_write "<li>Ey�i /tmp/[file rootname [file tail $file]].tab</li>"
    exec /bin/rm "/tmp/[file rootname [file tail $file]].tab"
    ns_write "<li>Ey�i [file rootname $file].xml</li>"
#    exec /bin/rm "[file rootname $file].xml"
    ns_write "<li>Ey�i [file rootname $file].sgml</li>"
    exec /bin/rm "[file rootname $file].sgml"
    ns_write "<li>Eftir stendur upphafleg innlestrarskr�, $file, og �arf a� ey�a henni s�rstaklega.</li>"
    ns_write "</ul>"
  }
  ns_write "<b>Keyrslu loki�.</b>"
}

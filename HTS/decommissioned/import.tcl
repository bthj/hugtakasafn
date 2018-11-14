ns_write "HTTP/1.0 200 OK
Content-Type: text/html; charset=utf-8
MIME-Version: 1.0
pragma: no-cache
Server: AOLserver/3.3.1+ad13

"

ns_write "<p><b>Innlestur SGML gagna hugtakasafns Þýðingamiðstöðvar utanríkisráðuneytis</b></p>"
ns_write "<p>Ath. að innlestrarskrár mega hvorki hafa endinguna .sgml né .xml</p>"

set work_dir "/home/hugtakasafn/import"
set sed_file "/home/hugtakasafn/mtsgmlfix.sed"

if [catch {set file_list [glob [file join $work_dir *]]}] {
  ns_write "<p>Engar skrár fundust</p>"
} else {
  ns_write "<p>Fann þessa(r) skrá(r) til innlestrar:</p>"
  ns_write "<ul>"
  foreach file $file_list {
    ns_write "<li>"
    ns_write $file
    ns_write "</li>"
  }
  ns_write "</ul>"
  set db [ns_db gethandle]
  foreach file $file_list {
    ns_write "<p>Hef vinnu við <b>[file tail $file]</b>:</p>"
    ns_write "<ul>"
    ns_write "<li>Hreinsa og geri löglegt SGML (skrifast í [file rootname [file tail $file]].sgml)</li>"
    ns_write "<ul>"
    if { [file exists "[file rootname $file].sgml"] } {
      ns_write "<li>[file rootname [file tail $file]].sgml er þegar til, gerði ekkert.</li>"
    } else {
      exec /bin/sed -f $sed_file $file > "[file rootname $file].sgml"
    }
    ns_write "<li>Lokið</li>"
    ns_write "</ul>"
    ns_write "<li>Breyti SGML í XML (skrifast í [file rootname [file tail $file]].xml)</li>"
    ns_write "<ul>"
    if { [file exists "[file rootname $file].xml"] } {
      ns_write "<li>[file rootname [file tail $file]].xml er þegar til, gerði ekkert.</li>"
    } else {
      ns_write "<li>"
      if [catch {exec /usr/local/bin/osx "[file rootname $file].sgml" > "[file rootname $file].xml"} errmsg] {
        ns_write $errmsg
      }
    }
    ns_write "</li>"
    ns_write "<li>Lokið</li>"
    ns_write "</ul>"
    ns_write "<li>Þátta inn XML tré úr [file rootname [file tail $file]].xml</li>"
    set in [open "[file rootname $file].xml"]
    set doc [dom parse [read $in]]
    ns_write "<li>Les úr þáttunartré og flyt inn í gagnagrunn</li>"
    set root [$doc documentElement]
    set updateCount 0
    set insertCount 0
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
          set term_is_adalord_ordfl_text ""
          set term_is_adalord_kyn_text ""
        } else {
          if [catch {set term_is_adalord_ordfl_text [[$term_is_adalord child 1 DESCRIPREF TYPE ordfl] text]}] {
            set term_is_adalord_ordfl_text ""
          }
          if [catch {set term_is_adalord_kyn_text [[$term_is_adalord child 1 DESCRIPREF TYPE kyn] text]}] {
            set term_is_adalord_kyn_text ""
          }
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
      set selection [ns_db select $db "select entrynumber from hugtakasafn where entrynumber = $term_entrynumber"]
      if { [ns_db getrow $db $selection] } {
        # færsla er til, uppfærum hana
        ns_db dml $db "update hugtakasafn
                         set entrynumber = $term_entrynumber, 
                             lang_is = '[DoubleApos [string trim $term_is_text]]', 
                             lang_en = '[DoubleApos [string trim $term_en_text]]', 
                             lang_danosae = '[DoubleApos [string trim $term_danosae_text]]',
                             lang_fr = '[DoubleApos [string trim $term_fr_text]]',
                             lang_de = '[DoubleApos [string trim $term_de_text]]',
                             lang_la = '[DoubleApos [string trim $term_la_text]]',
                             is_samh = '[DoubleApos [string trim $term_is_samh_text]]',
                             is_svid = '[DoubleApos [string trim $term_is_svid_text]]',
                             is_daemi = '[DoubleApos [string trim $term_is_daemi_text]]',
                             is_skilgr = '[DoubleApos [string trim $term_is_skilgr_text]]',
                             is_rit = '[DoubleApos [string trim $term_is_rit_text]]',
                             is_efnisfl = '[DoubleApos [string trim $term_is_efnisfl_text]]',
                             is_adalord = '[DoubleApos [string trim $term_is_adalord_text]]',
                             is_adalord_ordfl = '[DoubleApos [string trim $term_is_adalord_ordfl_text]]',
                             is_adalord_kyn = '[DoubleApos [string trim $term_is_adalord_kyn_text]]',
                             is_onnurmalfr = '[DoubleApos [string trim $term_is_onnurmalfr_text]]',
                             en_ordfl = '[DoubleApos [string trim $term_en_ordfl_text]]',
                             en_skst = '[DoubleApos [string trim $term_enskst_text]]',
                             en_annar_rith = '[DoubleApos [string trim $term_enannarrith_text]]',
                             is_skst = '[DoubleApos [string trim $term_isskst_text]]',
                             is_annar_rith = '[DoubleApos [string trim $term_isannarrith_text]]'
                           where entrynumber = $term_entrynumber"
        incr updateCount
      } else {
        # setjum inn nýja færslu
        ns_db dml $db "insert into hugtakasafn (
                         entrynumber,
                         lang_is,
                         lang_en,
                         lang_danosae,
                         lang_fr,
                         lang_de,
                         lang_la,
                         is_samh,
                         is_svid,
                         is_daemi,
                         is_skilgr,
                         is_rit,
                         is_efnisfl,
                         is_adalord,
                         is_adalord_ordfl,
                         is_adalord_kyn,
                         is_onnurmalfr,
                         en_ordfl,
                         en_skst,
                         en_annar_rith,
                         is_skst,
                         is_annar_rith
                       ) values (
                         $term_entrynumber, 
                         '[DoubleApos [string trim $term_is_text]]', 
                         '[DoubleApos [string trim $term_en_text]]', 
                         '[DoubleApos [string trim $term_danosae_text]]', 
                         '[DoubleApos [string trim $term_fr_text]]', 
                         '[DoubleApos [string trim $term_de_text]]', 
                         '[DoubleApos [string trim $term_la_text]]', 
                         '[DoubleApos [string trim $term_is_samh_text]]', 
                         '[DoubleApos [string trim $term_is_svid_text]]', 
                         '[DoubleApos [string trim $term_is_daemi_text]]', 
                         '[DoubleApos [string trim $term_is_skilgr_text]]', 
                         '[DoubleApos [string trim $term_is_rit_text]]', 
                         '[DoubleApos [string trim $term_is_efnisfl_text]]', 
                         '[DoubleApos [string trim $term_is_adalord_text]]', 
                         '[DoubleApos [string trim $term_is_adalord_ordfl_text]]', 
                         '[DoubleApos [string trim $term_is_adalord_kyn_text]]', 
                         '[DoubleApos [string trim $term_is_onnurmalfr_text]]', 
                         '[DoubleApos [string trim $term_en_ordfl_text]]', 
                         '[DoubleApos [string trim $term_enskst_text]]', 
                         '[DoubleApos [string trim $term_enannarrith_text]]', 
                         '[DoubleApos [string trim $term_isskst_text]]', 
                         '[DoubleApos [string trim $term_isannarrith_text]]'
                       )
                      "
        incr insertCount
      }
      if { ![expr $updateCount % 1000] && 0 < $updateCount } {
        ns_write "<li>$updateCount færslur hafa verið uppfærðar...</li>"
      }
      if { ![expr $insertCount % 1000] && 0 < $insertCount } {
        ns_write "<li>$insertCount færslum hefur verið bætt við...</li>"
      }
    }
    ns_write "<li>Uppfærði $updateCount færslur og bætti við $insertCount færslum.</li>"
    ns_write "<li>Hreinsa til í gagnagrunni og uppfæri tölfræðiupplýsingar um gögn...</li>"
    if [catch {exec /usr/local/pgsql/bin/vacuumdb "-q" "-z" "hugtakasafn"} errmsg] {
      ns_write "<li>$errmsg</li>"
    }
    ns_write "</ul>"
  }
  ns_write "<b>Keyrslu lokið.</b>"
}

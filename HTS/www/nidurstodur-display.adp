<%
upvar leitarord leitarord
if { ![info exists leitarord] } {
  set leitarord ""
}
upvar hugtak hugtak
if { ![info exists hugtak] } {
  set hugtak ""
}
upvar tungumal tungumal
upvar sql_query sql_query
upvar hugtakUrlLeitarParam hugtakUrlLeitarParam
if { [info exists sql_query] } {
if { ![empty_string_p $sql_query] } {
  set db [ns_db gethandle]
  set selection [ns_db select $db $sql_query]
  ns_adp_puts "<dl>"
  set count 0
  set list_leitarord [list]
  if { ![empty_string_p $leitarord] } {
  	set list_leitarord [split $leitarord]
  } elseif { ![empty_string_p $hugtak] } {
  	set list_leitarord [split $hugtak]
  }
  while { [ns_db getrow $db $selection] } {
    ns_adp_puts "<div class=\"term\">"
    set_variables_after_query
    switch $tungumal {
      "oll" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_is "<b>&</b>" lang_is
        }
        ns_adp_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_is</a>"
        if { ![empty_string_p $is_annar_rith] } {
          set is_annar_rith_parts [split $is_annar_rith ";"]
          foreach is_annar_rith_part $is_annar_rith_parts {
          	foreach eitt_leitarord $list_leitarord {
              regsub -all -nocase $eitt_leitarord $is_annar_rith_part "<b>&</b>" is_annar_rith_part
            }
            ns_adp_puts "<br />$is_annar_rith_part"
          }
        }
        ns_adp_puts "</dt>"
      }
      "is" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_is "<b>&</b>" lang_is
        }
        ns_adp_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_is</a>"
        if { ![empty_string_p $is_annar_rith] } {
          set is_annar_rith_parts [split $is_annar_rith ";"]
          foreach is_annar_rith_part $is_annar_rith_parts {
            foreach eitt_leitarord $list_leitarord {
              regsub -all -nocase $eitt_leitarord $is_annar_rith_part "<b>&</b>" is_annar_rith_part
            }
            ns_adp_puts "<br />$is_annar_rith_part"
          }
        }
        ns_adp_puts "</dt>"
      }
      "en" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_en "<b>&</b>" lang_en
        }
        ns_adp_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_en</a>"
        if { ![empty_string_p $en_annar_rith] } {
          set en_annar_rith_parts [split $en_annar_rith ";"]
          foreach en_annar_rith_part $en_annar_rith_parts {
            foreach eitt_leitarord $list_leitarord {
              regsub -all -nocase $eitt_leitarord $en_annar_rith_part "<b>&</b>" en_annar_rith_part
            }
            ns_adp_puts "<br />$en_annar_rith_part"
          }
        }
        ns_adp_puts "</dt>"
      }
      "danosae" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_danosae "<b>&</b>" lang_danosae
        }
        ns_adp_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_danosae</a></dt>"
      }
      "fr" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_fr "<b>&</b>" lang_fr
        }
        ns_adp_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_fr</a></dt>"
      }
      "de" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_de "<b>&</b>" lang_de
        }
        ns_adp_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_de</a></dt>"
      }
      "la" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_la "<b>&</b>" lang_la
        }
        ns_adp_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_la</a></dt>"
      }
    }
    if { ![empty_string_p $lang_is] && [string compare $tungumal "is"] != 0 && [string compare $tungumal "oll"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_is "<b>&</b>" lang_is
      }
      ns_adp_puts "<dd>$lang_is \[is\]"
      if { ![empty_string_p $is_annar_rith] } {
        set is_annar_rith_parts [split $is_annar_rith ";"]
        foreach is_annar_rith_part $is_annar_rith_parts {
          foreach eitt_leitarord $list_leitarord {
            regsub -all -nocase $eitt_leitarord $is_annar_rith_part "<b>&</b>" is_annar_rith_part
          }
          ns_adp_puts "<br />$is_annar_rith_part \[is\]"
        }
      }
      ns_adp_puts "</dd>"
    }
    if { ![empty_string_p $lang_en] && [string compare $tungumal "en"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_en "<b>&</b>" lang_en
      }
      ns_adp_puts "<dd>$lang_en \[en\]"
      if { ![empty_string_p $en_annar_rith] } {
        set en_annar_rith_parts [split $en_annar_rith ";"]
        foreach en_annar_rith_part $en_annar_rith_parts {
          foreach eitt_leitarord $list_leitarord {
            regsub -all -nocase $eitt_leitarord $en_annar_rith_part "<b>&</b>" en_annar_rith_part
          }
          ns_adp_puts "<br />$en_annar_rith_part \[en\]"
        }
      }
      ns_adp_puts "</dd>"
    }

    if { ![empty_string_p $lang_danosae] && [string compare $tungumal "danosae"] != 0 } {
	    set danosae_parts [split $lang_danosae ";"]
	    if { ![empty_string_p [lindex $danosae_parts 0]] } {
	      set lang_da [lindex $danosae_parts 0]
	      regsub -all " \\(da.\\)" $lang_da "" lang_da
	      foreach eitt_leitarord $list_leitarord {
	        regsub -all -nocase $eitt_leitarord $lang_da "<b>&</b>" lang_da
	      }
	      ns_adp_puts "<dd>$lang_da \[da\]</dd>"
	    }
	    if { ![empty_string_p [lindex $danosae_parts 1]] } {
	      set lang_se [lindex $danosae_parts 1]
	      regsub -all " \\(s�.\\)" $lang_se "" lang_se
	      foreach eitt_leitarord $list_leitarord {
	        regsub -all -nocase $eitt_leitarord $lang_se "<b>&</b>" lang_se
	      }
	      ns_adp_puts "<dd>$lang_se \[s�\]</dd>"
	    }
	    if { ![empty_string_p [lindex $danosae_parts 2]] } {
	      set lang_no [lindex $danosae_parts 2]
	      regsub -all " \\(no.\\)" $lang_no "" lang_no
	      foreach eitt_leitarord $list_leitarord {
	        regsub -all -nocase $eitt_leitarord $lang_no "<b>&</b>" lang_no
	      }
	      ns_adp_puts "<dd>$lang_no \[no\]</dd>"
	    }
    }

    if { ![empty_string_p $lang_fr] && [string compare $tungumal "fr"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_fr "<b>&</b>" lang_fr
      }
      ns_adp_puts "<dd>$lang_fr \[fr\]</dd>"
    }
    if { ![empty_string_p $lang_de] && [string compare $tungumal "de"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_de "<b>&</b>" lang_de
      }
      ns_adp_puts "<dd>$lang_de \[de\]</dd>"
    }
    if { ![empty_string_p $lang_la] && [string compare $tungumal "la"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_la "<b>&</b>" lang_la
      }
      ns_adp_puts "<dd>$lang_la \[la\]</dd>"
    }
    incr count
    ns_adp_puts "</div>"
  }
  ns_adp_puts "</dl>"
  if { $count > 0 } {
    if { $count % 10 == 1 } {
      if { [string range $count [expr [string length $count] - 2] end] == "11" } {
        ns_adp_puts "<p>$count ni�urst��ur fundust.</p>"
      } else {
        ns_adp_puts "<p>$count ni�ursta�a fannst.</p>"
      }
    } else {
      ns_adp_puts "<p>$count ni�urst��ur fundust.</p>"
    }
  } else {
    ns_adp_puts "<p>Ekkert fannst.</p><p>M� bj��a ��r a� leita � <a href=\"http://www.ordabanki.hi.is/wordbank/search\">Or�abanka �slenskrar m�lst��var</a> e�a � lagasafni ESB <a href=\"http://eur-lex.europa.eu/RECH_mot.do\">EURLEX</a> e�a � EES-vefsetrinu <a href=\"http://www.utanrikisraduneyti.is/samningar/ees/\">EES</a>?<a </p>"
  }
}
}
%>

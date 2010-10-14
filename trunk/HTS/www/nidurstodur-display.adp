<%
upvar leitarord leitarord
if { ![info exists leitarord] } {
  set leitarord ""
}
upvar tungumal tungumal
upvar sql_query sql_query
upvar hugtakUrlLeitarParam hugtakUrlLeitarParam
if { [info exists sql_query] } {
if { ![empty_string_p $sql_query] } {
  set db [ns_db gethandle]
  set selection [ns_db select $db $sql_query]
  ns_puts "<dl>"
  set count 0
  set list_leitarord [split $leitarord]
  while { [ns_db getrow $db $selection] } {
    set_variables_after_query
    switch $tungumal {
      "oll" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_is "<b>&</b>" lang_is
        }
        ns_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_is</a></dt>"
      }
      "is" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_is "<b>&</b>" lang_is
        }
        ns_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_is</a></dt>"
      }
      "en" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_en "<b>&</b>" lang_en
        }
        ns_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_en</a></dt>"
      }
      "danosae" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_danosae "<b>&</b>" lang_danosae
        }
        ns_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_danosae</a></dt>"
      }
      "fr" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_fr "<b>&</b>" lang_fr
        }
        ns_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_fr</a></dt>"
      }
      "de" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_de "<b>&</b>" lang_de
        }
        ns_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_de</a></dt>"
      }
      "la" {
        foreach eitt_leitarord $list_leitarord {
          regsub -all -nocase $eitt_leitarord $lang_la "<b>&</b>" lang_la
        }
        ns_puts "<dt><a href=\"hugtak.adp?id=$entrynumber$hugtakUrlLeitarParam\">$lang_la</a></dt>"
      }
    }
    if { ![empty_string_p $lang_is] && [string compare $tungumal "is"] != 0 && [string compare $tungumal "oll"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_is "<b>&</b>" lang_is
      }
      ns_puts "<dd>$lang_is \[is\]</dd>"
    }
    if { ![empty_string_p $lang_en] && [string compare $tungumal "en"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_en "<b>&</b>" lang_en
      }
      ns_puts "<dd>$lang_en \[en\]</dd>"
    }
    if { ![empty_string_p $lang_danosae] && [string compare $tungumal "danosae"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_danosae "<b>&</b>" lang_danosae
      }
      ns_puts "<dd>$lang_danosae \[da/no/sæ\]</dd>"
    }
    if { ![empty_string_p $lang_fr] && [string compare $tungumal "fr"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_fr "<b>&</b>" lang_fr
      }
      ns_puts "<dd>$lang_fr \[fr\]</dd>"
    }
    if { ![empty_string_p $lang_de] && [string compare $tungumal "de"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_de "<b>&</b>" lang_de
      }
      ns_puts "<dd>$lang_de \[de\]</dd>"
    }
    if { ![empty_string_p $lang_la] && [string compare $tungumal "la"] != 0 } {
      foreach eitt_leitarord $list_leitarord {
        regsub -all -nocase $eitt_leitarord $lang_la "<b>&</b>" lang_la
      }
      ns_puts "<dd>$lang_la \[la\]</dd>"
    }
    incr count
  }
  ns_puts "</dl>"
  if { $count > 0 } {
    if { $count % 10 == 1 } {
      if { [string range $count [expr [string length $count] - 2] end] == "11" } {
        ns_puts "<p>$count niðurstöður fundust.</p>"
      } else {
        ns_puts "<p>$count niðurstaða fannst.</p>"
      }
    } else {
      ns_puts "<p>$count niðurstöður fundust.</p>"
    }
  } else {
    ns_puts "<p>Ekkert fannst.</p><p>Má bjóða þér að leita í <a href=\"http://www.ordabanki.hi.is/wordbank/search\">Orðabanka Íslenskrar málstöðvar</a> eða í lagasafni ESB <a href=\"http://eur-lex.europa.eu/RECH_mot.do\">EURLEX</a> eða á EES-vefsetrinu <a href=\"http://www.utanrikisraduneyti.is/samningar/ees/\">EES</a> ?<a </p>."
  }
}
}
%>

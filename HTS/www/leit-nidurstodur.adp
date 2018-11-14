<% ns_adp_include stjrFyrir.adp %>
<% ns_adp_include heading1is.adp %>

<%
set_the_usual_form_variables 0
set leitarord [string trim $leitarord]
regsub -all {\s+} $leitarord " " leitarord
%>

<% ns_adp_include leit-einfold.adp %>

  <p><a href="/">Hugtakasafn</a> : Ni&eth;urst&ouml;&eth;ur leitar a&eth; "<b><%=$leitarord%></b>"</p>

<%
if { [empty_string_p $leitarord] } {
  ns_puts "<p>Engin leitarskilyr&eth;i gefin.</p>"
} else {
  set sql_query "select * from hugtakasafn where "
  set leitarord [DoubleApos $leitarord]
  set list_leitarord [split $leitarord]
  if { ![info exists ordrett] || [string compare $ordrett "o"] == 0 } {
    switch $tungumal {
      "oll" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_is ilike [ns_dbquotevalue %$eitt_leitarord%] or lang_en ilike [ns_dbquotevalue %$eitt_leitarord%] or lang_danosae ilike [ns_dbquotevalue %$eitt_leitarord%] or lang_fr ilike [ns_dbquotevalue %$eitt_leitarord%] or lang_de ilike [ns_dbquotevalue %$eitt_leitarord%] or lang_la ilike [ns_dbquotevalue %$eitt_leitarord%] or en_annar_rith ilike [ns_dbquotevalue %$eitt_leitarord%] or is_annar_rith ilike [ns_dbquotevalue %$eitt_leitarord%] or en_skst ilike [ns_dbquotevalue %$eitt_leitarord%] or is_skst ilike [ns_dbquotevalue %$eitt_leitarord%]) "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "is" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_is ilike [ns_dbquotevalue %$eitt_leitarord%] or is_annar_rith ilike [ns_dbquotevalue %$eitt_leitarord%] or is_skst ilike [ns_dbquotevalue %$eitt_leitarord%]) "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "en" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_en ilike [ns_dbquotevalue %$eitt_leitarord%] or en_annar_rith ilike [ns_dbquotevalue %$eitt_leitarord%] or en_skst ilike [ns_dbquotevalue %$eitt_leitarord%]) "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "danosae" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_danosae ilike [ns_dbquotevalue %$eitt_leitarord%]) "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "fr" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_fr ilike [ns_dbquotevalue %$eitt_leitarord%]) "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "de" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_de ilike [ns_dbquotevalue %$eitt_leitarord%]) "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "la" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_la ilike [ns_dbquotevalue %$eitt_leitarord%]) "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
    }
    set hugtakUrlLeitarParam "&leitarord=$leitarord&tungumal=$tungumal&ordrett=o"


  } elseif { [info exists ordrett] && [string compare $ordrett "s"] == 0 } {
    switch $tungumal {
      "oll" {
        append sql_query "lang_is ilike [ns_dbquotevalue $leitarord%] or lang_en ilike [ns_dbquotevalue $leitarord%] or lang_danosae ilike [ns_dbquotevalue $leitarord%] or lang_fr ilike [ns_dbquotevalue $leitarord%] or lang_de ilike [ns_dbquotevalue $leitarord%] or lang_la ilike [ns_dbquotevalue $leitarord%] or en_annar_rith ilike [ns_dbquotevalue $leitarord%] or is_annar_rith ilike [ns_dbquotevalue $leitarord%] or en_skst ilike [ns_dbquotevalue $leitarord%] or is_skst ilike [ns_dbquotevalue $leitarord%] "
      }
      "is" {
        append sql_query "lang_is ilike [ns_dbquotevalue $leitarord%] or is_annar_rith ilike [ns_dbquotevalue $leitarord%] or is_skst ilike [ns_dbquotevalue $leitarord%] "
      }
      "en" {
        append sql_query "lang_en ilike [ns_dbquotevalue $leitarord%] or en_annar_rith ilike [ns_dbquotevalue $leitarord%] or en_skst ilike [ns_dbquotevalue $leitarord%] "
      }
      "danosae" {
        append sql_query "lang_danosae ilike [ns_dbquotevalue $leitarord%] "
      }
      "fr" {
        append sql_query "lang_fr ilike [ns_dbquotevalue $leitarord%] "
      }
      "de" {
        append sql_query "lang_de ilike [ns_dbquotevalue $leitarord%] "
      }
      "la" {
        append sql_query "lang_la ilike [ns_dbquotevalue $leitarord%] "
      }
    }
    set hugtakUrlLeitarParam "&leitarord=$leitarord&tungumal=$tungumal&ordrett=s"

  } else {
    switch $tungumal {
      "oll" {
        append sql_query "lang_is ilike [ns_dbquotevalue $leitarord] or lang_en ilike [ns_dbquotevalue $leitarord] or lang_danosae ilike [ns_dbquotevalue $leitarord] or lang_fr ilike [ns_dbquotevalue $leitarord] or lang_de ilike [ns_dbquotevalue $leitarord] or lang_la ilike [ns_dbquotevalue $leitarord] or en_annar_rith ilike [ns_dbquotevalue $leitarord] or is_annar_rith ilike [ns_dbquotevalue $leitarord] or en_skst ilike [ns_dbquotevalue $leitarord] or is_skst ilike [ns_dbquotevalue $leitarord] "
      }
      "is" {
        append sql_query "lang_is ilike [ns_dbquotevalue $leitarord] or is_annar_rith ilike [ns_dbquotevalue $leitarord] or is_skst ilike [ns_dbquotevalue $leitarord] "
      }
      "en" {
        append sql_query "lang_en ilike [ns_dbquotevalue $leitarord] or en_annar_rith ilike [ns_dbquotevalue $leitarord] or en_skst ilike [ns_dbquotevalue $leitarord] "
      }
      "danosae" {
        append sql_query "lang_danosae ilike [ns_dbquotevalue $leitarord] "
      }
      "fr" {
        append sql_query "lang_fr ilike [ns_dbquotevalue $leitarord] "
      }
      "de" {
        append sql_query "lang_de ilike [ns_dbquotevalue $leitarord] "
      }
      "la" {
        append sql_query "lang_la ilike [ns_dbquotevalue $leitarord] "
      }
    }
    set hugtakUrlLeitarParam "&leitarord=$leitarord&tungumal=$tungumal&ordrett=t"
  }
  append sql_query "order by db_nr, lang_is"
}
%>

<% ns_adp_include nidurstodur-display.adp %>

<% ns_adp_include stjrEftir.adp %>

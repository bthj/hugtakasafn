<% ns_adp_include stjrFyrir.adp %>

<% 
set_the_usual_form_variables 0 
set leitarord [string trim $leitarord]
regsub -all {\s+} $leitarord " " leitarord
%>

<% ns_adp_include leit-einfold.adp %>

  <p><a href="/">Hugtakasafn</a> : Niðurstöður leitar að "<b><%=$leitarord%></b>"</p>

<%
if { [empty_string_p $leitarord] } {
  ns_puts "<p>Engin leitarskilyrði gefin.</p>"
} else {
  set sql_query "select * from hugtakasafn where "
  set leitarord [DoubleApos $leitarord]
  set list_leitarord [split $leitarord]
  if { ![info exists ordrett] || [empty_string_p $ordrett] } {
    switch $tungumal {
      "oll" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_is ilike '%$eitt_leitarord%' or lang_en ilike '%$eitt_leitarord%' or lang_danosae ilike '%$eitt_leitarord%' or lang_fr ilike '%$eitt_leitarord%' or lang_de ilike '%$eitt_leitarord%' or lang_la ilike '%$eitt_leitarord%' or en_annar_rith ilike '%$eitt_leitarord%' or is_annar_rith ilike '%$eitt_leitarord%' or en_skst ilike '%$eitt_leitarord%' or is_skst ilike '%$eitt_leitarord%') "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "is" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_is ilike '%$eitt_leitarord%' or is_annar_rith ilike '%$eitt_leitarord%' or is_skst ilike '%$eitt_leitarord%') "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "en" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_en ilike '%$eitt_leitarord%' or en_annar_rith ilike '%$eitt_leitarord%' or en_skst ilike '%$eitt_leitarord%') "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "danosae" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_danosae ilike '%$eitt_leitarord%') "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "fr" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_fr ilike '%$eitt_leitarord%') "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "de" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_de ilike '%$eitt_leitarord%') "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
      "la" {
        set i 0
        foreach eitt_leitarord $list_leitarord {
          append sql_query "(lang_la ilike '%$eitt_leitarord%') "
          incr i
          if {$i < [llength $list_leitarord]} {
            append sql_query "and "
          }
        }
      }
    }
    set hugtakUrlLeitarParam "&leitarord=$leitarord&tungumal=$tungumal"
  } else {
    switch $tungumal {
      "oll" {
        append sql_query "lang_is ilike '$leitarord' or lang_en ilike '$leitarord' or lang_danosae ilike '$leitarord' or lang_fr ilike '$leitarord' or lang_de ilike '$leitarord' or lang_la ilike '$leitarord' or en_annar_rith ilike '$leitarord' or is_annar_rith ilike '$leitarord' or en_skst ilike '$leitarord' or is_skst ilike '$leitarord' "
      }
      "is" {
        append sql_query "lang_is ilike '$leitarord' or is_annar_rith ilike '$leitarord' or is_skst ilike '$leitarord' "
      }
      "en" {
        append sql_query "lang_en ilike '$leitarord' or en_annar_rith ilike '$leitarord' or en_skst ilike '$leitarord' "
      }
      "danosae" {
        append sql_query "lang_danosae ilike '$leitarord' "
      }
      "fr" {
        append sql_query "lang_fr ilike '$leitarord' "
      }
      "de" {
        append sql_query "lang_de ilike '$leitarord' "
      }
      "la" {
        append sql_query "lang_la ilike '$leitarord' "
      }
    }
    set hugtakUrlLeitarParam "&leitarord=$leitarord&tungumal=$tungumal&ordrett=t"
  }
  append sql_query "order by lang_is"
}
%>

<% ns_adp_include nidurstodur-display.adp %>

<% ns_adp_include stjrEftir.adp %>

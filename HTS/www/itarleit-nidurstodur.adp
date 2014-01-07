<% ns_adp_include stjrFyrir.adp %>
<% ns_adp_include heading1is.adp %>

<% set_the_usual_form_variables 0 %>

<a href="/">Hugtakasafn</a> : <a href="itarleit.adp">�tarleg leit</a> : Ni�urst��ur

<%
set sql_query "select * from hugtakasafn "
set leitarskilyrdi "Leitarskilyr�i: "
if { ![empty_string_p $hugtak] } {
  set list_hugtak [split $hugtak]
  if { [string first "where" $sql_query] != -1 } {
    append sql_query "and "
  } else {
    append sql_query "where "
  }
  switch $tungumal {
    "oll" {
      set i 0
      foreach eitt_hugtak $list_hugtak {
        #set eitt_hugtak [ns_dbquotevalue $eitt_hugtak]
        append sql_query "(lang_is ilike '%$eitt_hugtak%' or lang_en ilike '%$eitt_hugtak%' or lang_danosae ilike '%$eitt_hugtak%' or lang_fr ilike '%$eitt_hugtak%' or lang_de ilike '%$eitt_hugtak%' or lang_la ilike '%$eitt_hugtak%') "
        incr i
        if {$i < [llength $list_hugtak]} {
          append sql_query "and "
        }
      }
    }
    "is" {
      set i 0
      foreach eitt_hugtak $list_hugtak {
        #set eitt_hugtak [ns_dbquotevalue $eitt_hugtak]
        append sql_query "lang_is ilike '%$eitt_hugtak%' "
        incr i
        if {$i < [llength $list_hugtak]} {
          append sql_query "and "
        }
      }
    }
    "en" {
      set i 0
      foreach eitt_hugtak $list_hugtak {
        #set eitt_hugtak [ns_dbquotevalue $eitt_hugtak]
        append sql_query "lang_en ilike '%$eitt_hugtak%' "
        incr i
        if {$i < [llength $list_hugtak]} {
          append sql_query "and "
        }
      }
    }
    "danosae" {
      set i 0
      foreach eitt_hugtak $list_hugtak {
        #set eitt_hugtak [ns_dbquotevalue $eitt_hugtak]
        append sql_query "lang_danosae ilike '%$eitt_hugtak%' "
        incr i
        if {$i < [llength $list_hugtak]} {
          append sql_query "and "
        }
      }
    }
    "fr" {
      set i 0
      foreach eitt_hugtak $list_hugtak {
        #set eitt_hugtak [ns_dbquotevalue $eitt_hugtak]
        append sql_query "lang_fr ilike '%$eitt_hugtak%' "
        incr i
        if {$i < [llength $list_hugtak]} {
          append sql_query "and "
        }
      }
    }
    "de" {
      set i 0
      foreach eitt_hugtak $list_hugtak {
        #set eitt_hugtak [ns_dbquotevalue $eitt_hugtak]
        append sql_query "lang_de ilike '%$eitt_hugtak%' "
        incr i
        if {$i < [llength $list_hugtak]} {
          append sql_query "and "
        }
      }
    }
    "la" {
      set i 0
      foreach eitt_hugtak $list_hugtak {
        #set eitt_hugtak [ns_dbquotevalue $eitt_hugtak]
        append sql_query "lang_la ilike '%$eitt_hugtak%' "
        incr i
        if {$i < [llength $list_hugtak]} {
          append sql_query "and "
        }
      }
    }
  }
  append leitarskilyrdi "Hugtak inniheldur \"$hugtak\" "
}
if { ![empty_string_p $samh] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $samh_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og samh. inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a samh. inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og samh. inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Samh. inniheldur "
  }
  append sql_query "is_samh ilike '%$samh%' "
  append leitarskilyrdi "\"$samh\" "
}
if { ![empty_string_p $svid] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $svid_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og svi� inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a svi� inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og svi� inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Svi� inniheldur "
  }
  append sql_query "is_svid ilike '%$svid%' "
  append leitarskilyrdi "\"$svid\" "
}
if { ![empty_string_p $daemi] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $daemi_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og d�mi inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a d�mi inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og d�mi inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "D�mi inniheldur "
  }
  append sql_query "is_daemi ilike '%$daemi%' "
  append leitarskilyrdi "\"$daemi\" "
}
if { ![empty_string_p $skilgr] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $skilgr_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og skilgr. inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a skilgr. inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og skilgr. inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Skilgr. inniheldur "
  }
  append sql_query "is_skilgr ilike '%$skilgr%' "
  append leitarskilyrdi "\"$skilgr\" "
}
if { ![empty_string_p $rit] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $rit_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og rit inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a rit inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og rit inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Rit inniheldur "
  }
  append sql_query "is_rit ilike '%$rit%' "
  append leitarskilyrdi "\"$rit\" "
}


if { ![empty_string_p $skjalnr] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $skjalnr_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og skjal nr. inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a skjal nr. inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og skjal nr inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Skjal nr. inniheldur "
  }
  append sql_query "is_skjalnr ilike '%$skjalnr%' "
  append leitarskilyrdi "\"$skjalnr\" "
}


if { ![empty_string_p $heimild] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $heimild_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og heimild inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a heimild inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og heimild inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Heimild inniheldur "
  }
  append sql_query "is_heimild ilike '%$heimild%' "
  append leitarskilyrdi "\"$heimild\" "
}
if { ![empty_string_p $aths] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $aths_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og athugasemd inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a athugasemd inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og athugasemd inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Athugasemd inniheldur "
  }
  append sql_query "is_aths ilike '%$aths%' "
  append leitarskilyrdi "\"$aths\" "
}
if { ![empty_string_p $adalord] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $adalord_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og a�alor� inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a a�alor� inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og a�alor� inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "A�alor� inniheldur "
  }
  append sql_query "is_adalord ilike '%$adalord%' "
  append leitarskilyrdi "\"$adalord\" "
}
if { ![empty_string_p $ordflokkur] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $ordflokkur_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og or�flokkur inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a or�flokkur inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og or�flokkur inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Or�flokkur inniheldur "
  }
  append sql_query "is_adalord_ordfl ilike '%$ordflokkur%' "
  append leitarskilyrdi "\"$ordflokkur\" "
}
if { ![empty_string_p $kyn] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $kyn_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og kyn inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a kyn inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og kyn inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Kyn inniheldur "
  }
  append sql_query "is_adalord_kyn ilike '%$kyn%' "
  append leitarskilyrdi "\"$kyn\" "
}
if { ![empty_string_p $onnurmalfr] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $onnurmalfr_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og �nnur m�lfr. inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a �nnur m�lfr. inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og �nnur m�lfr. inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "�nnur m�lfr. inniheldur "
  }
  append sql_query "is_onnurmalfr ilike '%$onnurmalfr%' "
  append leitarskilyrdi "\"$onnurmalfr\" "
}
if { ![empty_string_p $skst] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $skst_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og skammst�fun inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a skammst�fun inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og skammst�fun inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Skammst�fun inniheldur "
  }
  append sql_query "(en_skst ilike '%$skst%' or is_skst ilike '%$skst%') "
  append leitarskilyrdi "\"$skst\" "
}
if { ![empty_string_p $annarrh] } {
  if { [string first "where" $sql_query] != -1 } {
    switch $annarrh_op {
      "og" {
        append sql_query "and "
        append leitarskilyrdi "og annar rith�ttur inniheldur "
      }
      "eda" {
        append sql_query "or "
        append leitarskilyrdi "e�a annar rith�ttur inniheldur "
      }
      "ekki" {
        append sql_query "and not "
        append leitarskilyrdi "og annar rith�ttur inniheldur ekki "
      }
    }
  } else {
    append sql_query "where "
    append leitarskilyrdi "Annar rith�ttur inniheldur "
  }
  append sql_query "(en_annar_rith ilike '%$annarrh%' or is_annar_rith ilike '%$annarrh%') "
  append leitarskilyrdi "\"$annarrh\" "
}
append sql_query "order by lang_is"
set hugtakUrlLeitarParam ""
if { [string first "where" $sql_query] == -1 } {
  set sql_query ""
  ns_puts "<p>Engin leitarskilyr�i gefin.</p>"
} else {
  ns_puts "<br/><font color=\"gray\">$leitarskilyrdi</font><br/><br/>"
}
%>

<% ns_adp_include nidurstodur-display.adp %>

<% ns_adp_include stjrEftir.adp %>

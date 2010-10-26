<% ns_adp_include stjrFyrir.adp %>

<% 
set_the_usual_form_variables 0 
if { [info exists leitarord] } {
  set leitarord [string trim $leitarord]
  regsub -all {\s+} $leitarord " " leitarord
}
%>

<% ns_adp_include leit-einfold.adp %>

  <a href="/">Hugtakasafn</a> : Eitt hugtak

<%
set sql_query "select * from hugtakasafn where entrynumber = [ns_dbquotevalue $id]"
set db [ns_db gethandle]
set selection [ns_db select $db $sql_query]
ns_db getrow $db $selection
set_variables_after_query
if { [info exists leitarord] } {
  set list_leitarord [split $leitarord]
  foreach eitt_leitarord $list_leitarord {
    regsub -all -nocase $eitt_leitarord $lang_is "#####&bbbbb" lang_is
  }
  #hakk til að koma í veg fyrir að leitarorð stemmi við html/css stíl-texta; í leit eins og "body co" stemmdi co við background-color úr replace fyrra orðs...
  regsub -all "#####" $lang_is "<b style=\"color:black;background-color:#ffff66\">" lang_is
  regsub -all "bbbbb" $lang_is "</b>" lang_is
}
if { [empty_string_p $lang_is] } {
  if { [info exists leitarord] } {
    ns_returnerror 404 "Hugtak fannst ekki.  Leit a&eth;:  <a href=\"http://hugtakasafn.utn.stjr.is/leit-nidurstodur.adp?leitarord=$leitarord\">$leitarord</a>."
  } else {
    ns_returnerror 404 "Hugtak fannst ekki &iacute; <a href=\"http://hugtakasafn.utn.stjr.is\">Hugtakasafni</a>." 
  }
} else {
ns_puts "
  <dl>
    <dt><font color=\"gray\"><b>ÍSLENSKA</b></font></dt>
    <dd>$lang_is</dd>
"
if { ![empty_string_p $lang_en] } {
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $lang_en "#####&bbbbb" lang_en
    }
    regsub -all "#####" $lang_en "<b style=\"color:black;background-color:#ffff66\">" lang_en
    regsub -all "bbbbb" $lang_en "</b>" lang_en
  }
ns_puts "
    <dt><font color=\"gray\"><b>ENSKA</b></font></dt>
    <dd>$lang_en</dd>
"
}
if { ![empty_string_p $lang_danosae] } {
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $lang_danosae "#####&bbbbb" lang_danosae
    }
    regsub -all "#####" $lang_danosae "<b style=\"color:black;background-color:#ffff66\">" lang_danosae
    regsub -all "bbbbb" $lang_danosae "</b>" lang_danosae
  }
ns_puts "
    <dt><font color=\"gray\"><b>DANSKA / NORSKA / SÆNSKA</b></font></dt>
    <dd>$lang_danosae</dd>
"
}
if { ![empty_string_p $lang_fr] } {
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $lang_fr "#####&bbbbb" lang_fr
    }
    regsub -all "#####" $lang_fr "<b style=\"color:black;background-color:#ffff66\">" lang_fr
    regsub -all "bbbbb" $lang_fr "</b>" lang_fr
  }
ns_puts "
    <dt><font color=\"gray\"><b>FRANSKA</b></font></dt>
    <dd>$lang_fr</dd>
"
}
if { ![empty_string_p $lang_de] } {
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $lang_de "#####&bbbbb" lang_de
    }
    regsub -all "#####" $lang_de "<b style=\"color:black;background-color:#ffff66\">" lang_de
    regsub -all "bbbbb" $lang_de "</b>" lang_de
  }
ns_puts "
    <dt><font color=\"gray\"><b>ÞÝSKA</b></font></dt>
    <dd>$lang_de</dd>
"
}
if { ![empty_string_p $lang_la] } {
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $lang_la "#####&bbbbb" lang_la
    }
    regsub -all "#####" $lang_la "<b style=\"color:black;background-color:#ffff66\">" lang_la
    regsub -all "bbbbb" $lang_la "</b>" lang_la
  }
ns_puts "
    <dt><font color=\"gray\"><b>LATÍNA</b></font></dt>
    <dd>$lang_la</dd>
"
}
if { ![empty_string_p $is_samh] } {
ns_puts "
    <dt><font color=\"green\"><b>Samheiti</b></font></dt>
    <dd>$is_samh</dd>
"
}
if { ![empty_string_p $is_svid] } {
ns_puts "
    <dt><font color=\"green\"><b>Svið</b></font></dt>
    <dd>$is_svid</dd>
"
}
if { ![empty_string_p $is_daemi] } {
ns_puts "
    <dt><font color=\"green\"><b>Dæmi</b></font></dt>
    <dd>$is_daemi</dd>
"
}
if { ![empty_string_p $is_skilgr] } {
ns_puts "
    <dt><font color=\"green\"><b>Skilgreining</b></font></dt>
    <dd>$is_skilgr</dd>
"
}
if { ![empty_string_p $is_rit] } {
ns_puts "
    <dt><font color=\"green\"><b>Rit</b></font></dt>
    <dd>$is_rit</dd>
"
}

if { ![empty_string_p $is_skjalnr] } {
ns_puts "
    <dt><font color=\"green\"><b>Skjal nr.</b></font></dt>
    <dd>$is_skjalnr</dd>
"
}


if { ![empty_string_p $is_heimild] } {
ns_puts "
    <dt><font color=\"green\"><b>Heimild</b></font></dt>
    <dd>$is_heimild</dd>
"
}
if { ![empty_string_p $is_aths] } {
  regsub -all -nocase <XREF>(.*?)</XREF> $is_aths "<a href=\"http://hugtakasafn.utn.stjr.is/leit-nidurstodur.adp?leitarord=\\1\\&tungumal=en\\&ordrett=t\">\\1</a>" is_aths
  regsub -all -nocase (<DESCRIPTEXT>|</DESCRIPTEXT>) $is_aths "" is_aths
ns_puts "
    <dt><font color=\"green\"><b>Athugasemd</b></font></dt>
    <dd>$is_aths</dd>
"
}
if { ![empty_string_p $is_adalord] } {
ns_puts "
    <dt><font color=\"green\"><b>Aðalorð</b></font></dt>
    <dd>$is_adalord
"
  if { ![empty_string_p $is_adalord_ordfl] } {
    ns_puts " - <i>orðflokkur</i> $is_adalord_ordfl"
  }
  if { ![empty_string_p $is_adalord_kyn] } {
    ns_puts " <i>kyn</i> $is_adalord_kyn"
  }
  ns_puts "</dd>"
} else {
  if { ![empty_string_p $is_adalord_ordfl] } {
  ns_puts "
    <dt><font color=\"green\"><b>Orðflokkur</b></font></dt>
    <dd>$is_adalord_ordfl</dd>
  "
  }
  if { ![empty_string_p $is_adalord_kyn] } {
  ns_puts "
    <dt><font color=\"green\"><b>Kyn</b></font></dt>
    <dd>$is_adalord_kyn</dd>
  "
  }
}

if { ![empty_string_p $is_onnurmalfr] } {
ns_puts "
    <dt><font color=\"green\"><b>Önnur málfræði</b></font></dt>
    <dd>$is_onnurmalfr</dd>
"
}
if { ![empty_string_p $en_ordfl] } {
ns_puts "
    <dt><font color=\"green\"><b>ENSKUR orðflokkur</b></font></dt>
    <dd>$en_ordfl</dd>
"
}
if { ![empty_string_p $is_skst] } {
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $is_skst "#####&bbbbb" is_skst
    }
    regsub -all "#####" $is_skst "<b style=\"color:black;background-color:#ffff66\">" is_skst
    regsub -all "bbbbb" $is_skst "</b>" is_skst
  }
ns_puts "
    <dt><font color=\"gray\"><b>ÍSLENSK skammstöfun</b></font></dt>
    <dd>$is_skst</dd>
"
}
if { ![empty_string_p $is_annar_rith] } {
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $is_annar_rith "#####&bbbbb" is_annar_rith
    }
    regsub -all "#####" $is_annar_rith "<b style=\"color:black;background-color:#ffff66\">" is_annar_rith
    regsub -all "bbbbb" $is_annar_rith "</b>" is_annar_rith
  }
ns_puts "
    <dt><font color=\"gray\"><b>ÍSLENSKA annar ritháttur</b></font></dt>
    <dd>$is_annar_rith</dd>
"
}
if { ![empty_string_p $en_skst] } {
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $en_skst "#####&bbbbb" en_skst
    }
    regsub -all "#####" $en_skst "<b style=\"color:black;background-color:#ffff66\">" en_skst
    regsub -all "bbbbb" $en_skst "</b>" en_skst
  }
ns_puts "
    <dt><font color=\"gray\"><b>ENSK skammstöfun</b></font></dt>
    <dd>$en_skst</dd>
"
}
if { ![empty_string_p $en_annar_rith] } {
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $en_annar_rith "#####&bbbbb" en_annar_rith
    }
    regsub -all "#####" $en_annar_rith "<b style=\"color:black;background-color:#ffff66\">" en_annar_rith
    regsub -all "bbbbb" $en_annar_rith "</b>" en_annar_rith
  }
ns_puts "
    <dt><font color=\"gray\"><b>ENSKA annar ritháttur</b></font></dt>
    <dd>$en_annar_rith</dd>
"
}
ns_puts "</dl><br/>"

} 
# if empty lang_is
%>

<script>
<!--
document.leit.leitarord.focus(); document.leit.leitarord.select();
// -->
</script>

<% ns_adp_include stjrEftir.adp %>

<% ns_adp_include stjrFyrir.adp %>
<% ns_adp_include heading1is.adp %>

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
  #hakk til a� koma � veg fyrir a� leitaror� stemmi vi� html/css st�l-texta; � leit eins og "body co" stemmdi co vi� background-color �r replace fyrra or�s...
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
    <dt><font color=\"gray\"><b>�SLENSKA</b></font></dt>
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
set danosae_parts [split $lang_danosae ";"]
if { ![empty_string_p [lindex $danosae_parts 0]] } {
  set lang_da [lindex $danosae_parts 0]
  regsub -all " \\(da.\\)" $lang_da "" lang_da
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $lang_da "#####&bbbbb" lang_da
    }
    regsub -all "#####" $lang_da "<b style=\"color:black;background-color:#ffff66\">" lang_da
    regsub -all "bbbbb" $lang_da "</b>" lang_da
  }
  ns_puts "
    <dt><font color=\"gray\"><b>DANSKA</b></font></dt>
    <dd>$lang_da</dd>
  "
}
if { ![empty_string_p [lindex $danosae_parts 1]] } {
  set lang_se [lindex $danosae_parts 1]
  regsub -all " \\(s�.\\)" $lang_se "" lang_se
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $lang_se "#####&bbbbb" lang_se
    }
    regsub -all "#####" $lang_se "<b style=\"color:black;background-color:#ffff66\">" lang_se
    regsub -all "bbbbb" $lang_se "</b>" lang_se
  }
  ns_puts "
    <dt><font color=\"gray\"><b>S�NSKA</b></font></dt>
    <dd>$lang_se</dd>
  "
}
if { ![empty_string_p [lindex $danosae_parts 2]] } {
  set lang_no [lindex $danosae_parts 2]
  regsub -all " \\(no.\\)" $lang_no "" lang_no
  if { [info exists leitarord] } {
    foreach eitt_leitarord $list_leitarord {
      regsub -all -nocase $eitt_leitarord $lang_no "#####&bbbbb" lang_no
    }
    regsub -all "#####" $lang_no "<b style=\"color:black;background-color:#ffff66\">" lang_no
    regsub -all "bbbbb" $lang_no "</b>" lang_no
  }
  ns_puts "
    <dt><font color=\"gray\"><b>NORSKA</b></font></dt>
    <dd>$lang_no</dd>
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
    <dt><font color=\"gray\"><b>��SKA</b></font></dt>
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
    <dt><font color=\"gray\"><b>LAT�NA</b></font></dt>
    <dd>$lang_la</dd>
"
}


if { ![empty_string_p $is_samh] || ![empty_string_p $en_samh] } {
  ns_puts "
    <dt><font color=\"green\"><b>Samheiti</b></font></dt>
  "  
  if { ![empty_string_p $is_samh] } {
    ns_puts "<dd>"
    if { ![empty_string_p $en_samh] } {
      ns_puts "\[<strong>is</strong>\]"  
    }
    ns_puts "$is_samh</dd>"
  }
  if { ![empty_string_p $en_samh] } {
    ns_puts "<dd>\[<strong>en</strong>\]  $en_samh</dd>"
  }
}

if { ![empty_string_p $is_svid] } {
ns_puts "
    <dt><font color=\"green\"><b>Svi�</b></font></dt>
    <dd>$is_svid</dd>
"
}

if { ![empty_string_p $is_daemi] || ![empty_string_p $en_daemi] } {
ns_puts "
    <dt><font color=\"green\"><b>D�mi</b></font></dt>
"
  if { ![empty_string_p $is_daemi] } {
    ns_puts "<dd>"
    if { ![empty_string_p $en_daemi] } {
      ns_puts "\[<strong>is</strong>\]"  
    }
    ns_puts "$is_daemi</dd>"
  }
  if { ![empty_string_p $en_daemi] } {
    ns_puts "<dd>\[<strong>en</strong>\]  $en_daemi</dd>"
  }
}

if { ![empty_string_p $is_skilgr] || ![empty_string_p $en_skilgr] } {
  ns_puts "
    <dt><font color=\"green\"><b>Skilgreining</b></font></dt>
  "
  if { ![empty_string_p $is_skilgr] } {
    ns_puts "<dd>"
    if { ![empty_string_p $en_skilgr] } {
      ns_puts "\[<strong>is</strong>\]"  
    }
    ns_puts "$is_skilgr</dd>"
  }
  if { ![empty_string_p $en_skilgr] } {
    ns_puts "<dd>\[<strong>en</strong>\]  $en_skilgr</dd>"
  }
}

if { ![empty_string_p $is_rit] || ![empty_string_p $en_rit] } {
  ns_puts "
    <dt><font color=\"green\"><b>Rit</b></font></dt>
  "
  if { ![empty_string_p $is_rit] } {
    ns_puts "<dd>"
    if { ![empty_string_p $en_rit] } {
      ns_puts "\[<strong>is</strong>\]"  
    }
    ns_puts "$is_rit</dd>"
  }
  if { ![empty_string_p $en_rit] } {
    ns_puts "<dd>\[<strong>en</strong>\]  $en_rit</dd>"
  }
}

if { ![empty_string_p $is_skjalnr] } {
ns_puts "
    <dt><font color=\"green\"><b>Skjal nr.</b></font></dt>
    <dd>$is_skjalnr</dd>
"
}

if { ![empty_string_p $is_aths] || ![empty_string_p $en_aths] } {
  ns_puts "
    <dt><font color=\"green\"><b>Athugasemd</b></font></dt>
  "
  if { ![empty_string_p $is_aths] } {
    regsub -all -nocase <XREF>(.*?)</XREF> $is_aths "<a href=\"http://hugtakasafn.utn.stjr.is/leit-nidurstodur.adp?leitarord=\\1\\&tungumal=en\\&ordrett=t\">\\1</a>" is_aths
    regsub -all -nocase (<DESCRIPTEXT>|</DESCRIPTEXT>) $is_aths "" is_aths
    ns_puts "<dd>"
    if { ![empty_string_p $en_aths] } {
      ns_puts "\[<strong>is</strong>\]"  
    }
    ns_puts "$is_aths</dd>"
  }
  if { ![empty_string_p $en_aths] } {
    ns_puts "<dd>\[<strong>en</strong>\]  $en_aths</dd>"
  }
}

if { ![empty_string_p $is_adalord] } {
ns_puts "
    <dt><font color=\"green\"><b>A�alor�</b></font></dt>
    <dd>$is_adalord
"
  if { ![empty_string_p $is_adalord_ordfl] } {
    ns_puts " - <i>or�flokkur</i> $is_adalord_ordfl"
  }
  if { ![empty_string_p $is_adalord_kyn] } {
    ns_puts " <i>kyn</i> $is_adalord_kyn"
  }
  ns_puts "</dd>"
} else {
  if { ![empty_string_p $is_adalord_ordfl] } {
  ns_puts "
    <dt><font color=\"green\"><b>Or�flokkur</b></font></dt>
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
    <dt><font color=\"green\"><b>�nnur m�lfr��i</b></font></dt>
    <dd>$is_onnurmalfr</dd>
"
}
if { ![empty_string_p $en_ordfl] } {
ns_puts "
    <dt><font color=\"green\"><b>ENSKUR or�flokkur</b></font></dt>
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
    <dt><font color=\"gray\"><b>�SLENSK skammst�fun</b></font></dt>
    <dd>$is_skst</dd>
"
}
if { ![empty_string_p $is_annar_rith] } {
  set is_annar_rith_parts [split $is_annar_rith ";"]
  set is_annar_rith_display ""
  foreach is_annar_rith_part $is_annar_rith_parts {
	  if { [info exists leitarord] } {
	    foreach eitt_leitarord $list_leitarord {
	      regsub -all -nocase $eitt_leitarord $is_annar_rith_part "#####&bbbbb" is_annar_rith_part
	    }
	    regsub -all "#####" $is_annar_rith_part "<b style=\"color:black;background-color:#ffff66\">" is_annar_rith_part
	    regsub -all "bbbbb" $is_annar_rith_part "</b>" is_annar_rith_part
	  }
	  append is_annar_rith_display "$is_annar_rith_part<br />"
  }
ns_puts "
    <dt><font color=\"gray\"><b>�SLENSKA annar rith�ttur</b></font></dt>
    <dd>$is_annar_rith_display</dd>
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
    <dt><font color=\"gray\"><b>ENSK skammst�fun</b></font></dt>
    <dd>$en_skst</dd>
"
}
if { ![empty_string_p $en_annar_rith] } {
  set en_annar_rith_parts [split $en_annar_rith ";"]
  set en_annar_rith_display ""
  foreach en_annar_rith_part $en_annar_rith_parts {
	  if { [info exists leitarord] } {
	    foreach eitt_leitarord $list_leitarord {
	      regsub -all -nocase $eitt_leitarord $en_annar_rith_part "#####&bbbbb" en_annar_rith_part
	    }
	    regsub -all "#####" $en_annar_rith_part "<b style=\"color:black;background-color:#ffff66\">" en_annar_rith_part
	    regsub -all "bbbbb" $en_annar_rith_part "</b>" en_annar_rith_part
	  }
	  append en_annar_rith_display "$en_annar_rith_part<br />"
  }
ns_puts "
    <dt><font color=\"gray\"><b>ENSKA annar rith�ttur</b></font></dt>
    <dd>$en_annar_rith_display</dd>
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

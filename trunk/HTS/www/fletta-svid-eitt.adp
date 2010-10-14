<% ns_adp_include stjrFyrir.adp %>

<% set_the_usual_form_variables 0 %>

<% ns_adp_include leit-einfold.adp %>

<a href="/">Hugtakasafn</a> : <a href="fletta-svid.adp">Fletting svi�a</a> : <b><%=$id%></b>

<%
set db [ns_db gethandle]
if { [info exists c] } {
  set count $c
} else {
  set selection [ns_db select $db "select count(is_svid) as svid_fjoldi from hugtakasafn where is_svid = '$id'"]
  ns_db getrow $db $selection
  set_variables_after_query
  set count $svid_fjoldi
}
if { [info exists o] } {
  set offset $o
} else {
  set offset 0
}
set max 10
ns_puts "<br/><font color=\"gray\">Hugt�k [expr $offset + 1] "
if { $count < [expr $offset + $max] } {
  ns_puts "til $count"
} else {
  ns_puts "til [expr $offset + $max]"
}
ns_puts " af $count</font>"
%>
<dl>
<%
set sql_query "select entrynumber, lang_is, lang_en, lang_danosae, lang_fr, lang_de, lang_la from hugtakasafn where is_svid = '$id' order by lang_is limit 10 offset $offset"
set selection [ns_db select $db $sql_query]
while { [ns_db getrow $db $selection] } {
  set_variables_after_query
  ns_puts "<dt><a href=\"hugtak.adp?id=$entrynumber\">$lang_is</a></dt>"
  if { ![empty_string_p $lang_en] } {
    ns_puts "<dd>$lang_en \[en\]</dd>"
  }
  if { ![empty_string_p $lang_danosae] } {
    ns_puts "<dd>$lang_danosae \[da/no/s�\]</dd>"
  }
  if { ![empty_string_p $lang_fr] } {
    ns_puts "<dd>$lang_fr \[fr\]</dd>"
  }
  if { ![empty_string_p $lang_de] } {
    ns_puts "<dd>$lang_de \[de\]</dd>"
  }
  if { ![empty_string_p $lang_la] } {
    ns_puts "<dd>$lang_la \[la\]</dd>"
  }
}
%>
</dl>

<% set path "[ns_conn host][ns_conn url]?id=$id&c=$count" %>

<% ns_adp_include paginator.adp %>

<% ns_adp_include stjrEftir.adp %>

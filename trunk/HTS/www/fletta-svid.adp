<% ns_adp_include stjrFyrir.adp %>
<% ns_adp_include heading1is.adp %>

<% ns_adp_include leit-einfold.adp %>

<p>
	<a href="/">Hugtakasafn</a> : Fletting sviða
</p>
<ul>
<%
set sql_query "select is_svid, count(is_svid) as fjoldi from hugtakasafn group by is_svid order by is_svid"
set db [ns_db gethandle]
set selection [ns_db select $db $sql_query]
set link_oflokkad ""
while { [ns_db getrow $db $selection] } {
  set_variables_after_query
  if { [empty_string_p $is_svid] } {
  	set link_oflokkad "<li><a href=\"fletta-svid-eitt.adp?id=&c=$fjoldi\"><i>óflokkað</i></a> ($fjoldi)</li>" 
  } else {
    ns_puts "<li><a href=\"fletta-svid-eitt.adp?id=[ns_urlencode $is_svid]&c=$fjoldi\">$is_svid</a> ($fjoldi)</li>"
  }
}
ns_puts $link_oflokkad
%>
</ul>

<% ns_adp_include stjrEftir.adp %>
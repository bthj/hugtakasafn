<%
set fetch_dest [ns_set get [ns_conn headers] "Sec-Fetch-Dest"]
if { $fetch_dest == "iframe" } {
  ns_adp_puts {

</body>
</html>

  }
} else {
  ns_adp_include stjrTemplateAfter.html
}
%>

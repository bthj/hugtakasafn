<%
set fetch_dest [ns_set get [ns_conn headers] "Sec-Fetch-Dest"]
if { $fetch_dest == "iframe" } {
  ns_adp_puts {

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="is">
<head>
<!--  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      Björn Þór Jónsson
      bangsi@bthj.is
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  -->

<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />

<style>
  body {
    font-family: 'Open Sans';
  }
</style>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-43271726-3', 'stjr.is');
  ga('send', 'pageview');

</script>

</head>
<body>

  }

} else {
  ns_adp_include stjrTemplateBefore.html
}
%>


<%
# set stjrTemplateExample [ns_httpget http://bthj.is]
# ns_adp_puts [stjrTemplateExample]

# ns_adp_puts [ns_http run http://example.com/]

#set result [ns_http run http://example.com/]
# ns_adp_puts $result
#ns_adp_puts "status"

# ns_http queue http://example.com/
# ns_adp_puts [ns_http wait http0]
%>

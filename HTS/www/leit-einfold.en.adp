<%
upvar leitarord leitarord
upvar ordrett ordrett
upvar tungumal tungumal
if { ![info exists tungumal] } {
  set tungumal "oll"
}
%>
<table align="right">
<tr><td>Ritstjóri: <a href="mailto:sigrun.thorgeirsdottir@utn.stjr.is">sigrun.thorgeirsdottir@utn.stjr.is</a></td></tr>
</table>
<form method=get action="leit-nidurstodur.adp" name="leit">
  <table>
    <tr>
      <th>Simple search</th>
      <th>Language</th>
      <th></th>
    </tr>
    <tr>
      <td>
        <%
        if { [info exists leitarord] } {
          ns_puts "<input type=\"text\" name=\"leitarord\" value=\"$leitarord\"/><!-- br/ -->"
        } else {
          ns_puts "<input type=\"text\" name=\"leitarord\"/><!-- br/ -->"
        }
        %>
      </td>
      <td>
        <select name="tungumal">
        <%
          if { [string compare $tungumal "oll"] != 0 } {
            ns_puts "<option value=\"oll\">all languages</option>"
          } else {
            ns_puts "<option value=\"oll\" selected>all languages</option>"
          }
          if { [string compare $tungumal "is"] != 0 } {
            ns_puts "<option value=\"is\">Icelandic</option>"
          } else {
            ns_puts "<option value=\"is\" selected>Icelandic</option>"
          }
          if { [string compare $tungumal "en"] != 0 } {
            ns_puts "<option value=\"en\">English</option>"
          } else {
            ns_puts "<option value=\"en\" selected>English</option>"
          }
          if { [string compare $tungumal "danosae"] != 0 } {
            ns_puts "<option value=\"danosae\">Danish, Swedish, Norwegian</option>"
          } else {
            ns_puts "<option value=\"danosae\" selected>Danish, Swedish, Norwegian,</option>"
          }
          if { [string compare $tungumal "fr"] != 0 } {
            ns_puts "<option value=\"fr\">French</option>"
          } else {
            ns_puts "<option value=\"fr\" selected>French</option>"
          }
          if { [string compare $tungumal "de"] != 0 } {
            ns_puts "<option value=\"de\">German</option>"
          } else {
            ns_puts "<option value=\"de\" selected>German</option>"
          }
          if { [string compare $tungumal "la"] != 0 } {
            ns_puts "<option value=\"la\">Latin</option>"
          } else {
            ns_puts "<option value=\"la\" selected>Latin</option>"
          }
        %>
        </select>
      </td>
      <td nowrap>
        <%
        if { [info exists ordrett] && [string compare $ordrett "t"] == 0 } {
          ns_puts "<input type=\"checkbox\" name=\"ordrett\" value=\"t\" id=\"ordrett\" checked/><label for=\"ordrett\">Exact search</label>"
        } else {
          ns_puts "<input type=\"checkbox\" name=\"ordrett\" value=\"t\" id=\"ordrett\"/><label for=\"ordrett\">Exact search</label>"
        }
        %>
      </td>
    </tr>
  </table>
  <input type="submit" value="search"/> <a href="itarleit.adp">Detailed search</a>
</form>
<hr size="1" noshade/>
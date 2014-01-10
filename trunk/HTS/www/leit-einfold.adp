<%
upvar leitarord leitarord
upvar ordrett ordrett
upvar tungumal tungumal
if { ![info exists tungumal] } {
  set tungumal "oll"
}
%>
<table align="right">
<tr><td>Ritstjóri: <a href="mailto:sigrun.thorgeirsdottir@utn.stjr.is">Sigrún Þorgeirsdóttir</a></td></tr>
</table>
<form method=get action="leit-nidurstodur.adp" name="leit">
  <table>
    <tr>
      <th>Leitarorð</th>
      <th>Leitartungumál</th>
      <th></th>
    </tr>
    <tr>
      <td>
        <%
        if { [info exists leitarord] } {
          ns_puts "<input type=\"text\" name=\"leitarord\" value=\"$leitarord\" onFocus=\"javascript:this.select();\"/><!-- br/ -->"
        } else {
          ns_puts "<input type=\"text\" name=\"leitarord\"/><!-- br/ -->"
        }
        %>
      </td>
      <td>
        <select name="tungumal">
        <%
          if { [string compare $tungumal "oll"] != 0 } {
            ns_puts "<option value=\"oll\">öll tungumál</option>"
          } else {
            ns_puts "<option value=\"oll\" selected>öll tungumál</option>"
          }
          if { [string compare $tungumal "is"] != 0 } {
            ns_puts "<option value=\"is\">íslenska</option>"
          } else {
            ns_puts "<option value=\"is\" selected>íslenska</option>"
          }
          if { [string compare $tungumal "en"] != 0 } {
            ns_puts "<option value=\"en\">enska</option>"
          } else {
            ns_puts "<option value=\"en\" selected>enska</option>"
          }
          if { [string compare $tungumal "danosae"] != 0 } {
            ns_puts "<option value=\"danosae\">danska/norska/sænska</option>"
          } else {
            ns_puts "<option value=\"danosae\" selected>danska/norska/sænska</option>"
          }
          if { [string compare $tungumal "fr"] != 0 } {
            ns_puts "<option value=\"fr\">franska</option>"
          } else {
            ns_puts "<option value=\"fr\" selected>franska</option>"
          }
          if { [string compare $tungumal "de"] != 0 } {
            ns_puts "<option value=\"de\">þýska</option>"
          } else {
            ns_puts "<option value=\"de\" selected>þýska</option>"
          }
          if { [string compare $tungumal "la"] != 0 } {
            ns_puts "<option value=\"la\">latína</option>"
          } else {
            ns_puts "<option value=\"la\" selected>latína</option>"
          }
        %>
        </select>
      </td>
      <td nowrap>
        <%
        set matchAllChecked ""
        set matchExactChecked ""
        set matchStartChecked ""
        if { [info exists ordrett] && [string compare $ordrett "t"] == 0 } {
        
          #ns_puts "<input type=\"checkbox\" name=\"ordrett\" value=\"t\" id=\"ordrett\" checked/><label for=\"ordrett\">Orðrétt leit</label>"
          set matchExactChecked " checked=\"checked\""
        
        } elseif { [info exists ordrett] && [string compare $ordrett "s"] == 0 } {
        
          set matchStartChecked " checked=\"checked\""
          
        } else {
        
          #ns_puts "<input type=\"checkbox\" name=\"ordrett\" value=\"t\" id=\"ordrett\"/><label for=\"ordrett\">Orðrétt leit</label>"
          set matchAllChecked " checked=\"checked\""
        }
        %>
         
        <input type="radio" name="ordrett" value="o" id="matchAll"<%=$matchAllChecked%>><label for="matchAll" style="vertical-align:text-top;">öll tilvik</label>
        
        <input type="radio" name="ordrett" value="t" id="matchExact"<%=$matchExactChecked%>><label for="matchExact" style="vertical-align:text-top;">orðrétt</label>
        
        <input type="radio" name="ordrett" value="s" id="matchStart"<%=$matchStartChecked%>><label for="matchStart" style="vertical-align:text-top;">byrjar á</label>
        
        
        <!-- select name="tungumal">
          <option selected>Enska -> Íslenska</option>
          <option>Íslenska -> Enska</option>
        </select -->
      </td>
    </tr>
  </table>
  <input type="submit" value="leita"/> <a href="itarleit.adp">Nánari leit</a> &nbsp;|&nbsp; <a href="fletta-svid.adp">Fletting sviða</a>
</form>
<script language="JavaScript">
<!--
document.leit.leitarord.select();
// -->
</script>
<hr size="1" noshade/>
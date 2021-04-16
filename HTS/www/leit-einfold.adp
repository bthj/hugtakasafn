<%
upvar leitarord leitarord
upvar ordrett ordrett
upvar tungumal tungumal
if { ![info exists tungumal] } {
  set tungumal "oll"
}
%>
<span style="float:right;">
	Ritstj�ri: <a href="mailto:sigrun.thorgeirsdottir@utn.stjr.is">Sigr�n �orgeirsd�ttir</a>
</span>
<form method=get action="leit-nidurstodur.adp" name="leit">
  <table>
    <tr>
      <th>Leitaror�</th>
      <th>Leitartungum�l</th>
      <th></th>
    </tr>
    <tr>
      <td style="padding-right:1em">
        <%
        if { [info exists leitarord] } {
          ns_adp_puts "<input type=\"text\" name=\"leitarord\" value=\"$leitarord\" onFocus=\"javascript:this.select();\"/><!-- br/ -->"
        } else {
          ns_adp_puts "<input type=\"text\" name=\"leitarord\"/><!-- br/ -->"
        }
        %>
      </td>
      <td style="padding-right:1em; width:12em;">
        <select name="tungumal">
        <%
          if { [string compare $tungumal "oll"] != 0 } {
            ns_adp_puts "<option value=\"oll\">�ll tungum�l</option>"
          } else {
            ns_adp_puts "<option value=\"oll\" selected>�ll tungum�l</option>"
          }
          if { [string compare $tungumal "is"] != 0 } {
            ns_adp_puts "<option value=\"is\">�slenska</option>"
          } else {
            ns_adp_puts "<option value=\"is\" selected>�slenska</option>"
          }
          if { [string compare $tungumal "en"] != 0 } {
            ns_adp_puts "<option value=\"en\">enska</option>"
          } else {
            ns_adp_puts "<option value=\"en\" selected>enska</option>"
          }
          if { [string compare $tungumal "danosae"] != 0 } {
            ns_adp_puts "<option value=\"danosae\">danska/norska/s�nska</option>"
          } else {
            ns_adp_puts "<option value=\"danosae\" selected>danska/norska/s�nska</option>"
          }
          if { [string compare $tungumal "fr"] != 0 } {
            ns_adp_puts "<option value=\"fr\">franska</option>"
          } else {
            ns_adp_puts "<option value=\"fr\" selected>franska</option>"
          }
          if { [string compare $tungumal "de"] != 0 } {
            ns_adp_puts "<option value=\"de\">��ska</option>"
          } else {
            ns_adp_puts "<option value=\"de\" selected>��ska</option>"
          }
          if { [string compare $tungumal "la"] != 0 } {
            ns_adp_puts "<option value=\"la\">lat�na</option>"
          } else {
            ns_adp_puts "<option value=\"la\" selected>lat�na</option>"
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

          #ns_adp_puts "<input type=\"checkbox\" name=\"ordrett\" value=\"t\" id=\"ordrett\" checked/><label for=\"ordrett\">Or�r�tt leit</label>"
          set matchExactChecked " checked=\"checked\""

        } elseif { [info exists ordrett] && [string compare $ordrett "s"] == 0 } {

          set matchStartChecked " checked=\"checked\""

        } else {

          #ns_adp_puts "<input type=\"checkbox\" name=\"ordrett\" value=\"t\" id=\"ordrett\"/><label for=\"ordrett\">Or�r�tt leit</label>"
          set matchAllChecked " checked=\"checked\""
        }
        %>

        <input type="radio" name="ordrett" value="o" id="matchAll"<%=$matchAllChecked%> style="margin-right:0.3em" /><label for="matchAll" style="margin-right:0.5em">�ll tilvik</label>

        <input type="radio" name="ordrett" value="t" id="matchExact"<%=$matchExactChecked%> style="margin-right:0.3em" /><label for="matchExact" style="margin-right:0.5em">or�r�tt</label>

        <input type="radio" name="ordrett" value="s" id="matchStart"<%=$matchStartChecked%> style="margin-right:0.3em" /><label for="matchStart" style="margin-right:0.5em">byrjar �</label>


        <!-- select name="tungumal">
          <option selected>Enska -> �slenska</option>
          <option>�slenska -> Enska</option>
        </select -->
      </td>
    </tr>
  </table>
  <input type="submit" value="leita" style="margin-right:0.5em" /> <a href="itarleit.adp">N�nari leit</a> &nbsp;|&nbsp; <a href="fletta-svid.adp">Fletting svi�a</a>
</form>
<script language="JavaScript">
<!--
document.leit.leitarord.select();
// -->
</script>
<hr size="1" noshade/>

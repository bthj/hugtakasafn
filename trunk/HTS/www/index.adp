<% ns_adp_include stjrFyrir.adp %>


<% ns_adp_include leit-einfold.adp %>

<table>
  <tr>
    <td vAlign="top">
      <p>
        <a href="umhts.adp">Um hugtakasafnið</a>:
      <ul>
        <li><a href="umhts.adp#almennt">Almennt</a></li>
        <li><a href="umhts.adp#notkun">Notkun</a></li>
        <li><a href="umhts.adp#saga">Saga</a></li>
      </ul>
      </p>
      <p>
        Sjá einnig:
      </p>
      <ul>
        <li><a href="http://www.ordabanki.ismal.hi.is/search">ORÐABANKI Íslenskrar málstöðvar</a></li>
      </ul>
    </td>
    <td>
      <p>
        <b>Þýðingamiðstöð utanríkisráðuneytisins</b> hefur birt hugtakasafn sitt á vefslóðinni: www.hugtakasafn.utn.stjr.is.
      </p>
      <p>
        Unnið hefur verið að söfnun hugtaka og orðasambanda í safnið allt frá stofnun Þýðingamiðstöðvarinnar árið 1990. Sífellt er unnið að endurskoðun og aðlögun safnsins með vefsetningu þess í huga enda er vefsetning íslenskra hugtakasafna liður í tungutækniverkefni ríkisstjórnarinnar.
      </p>
      <p>
        Hugtökin og orðasamböndin eru að stórum hluta úr tilskipunum og reglugerðum sem falla undir EES-samninginn en þýðing þeirra yfir á íslensku er einmitt helsta verkefni  Þýðingamiðstöðvarinnar. Einnig eru í safninu hugtök sem tengjast öðrum milliríkjasamningum, svo sem Schengen-samningnum og samningnum um stofnun Alþjóðaviðskiptastofnunarinnar (GATT). Þá eru í safninu fjöldamörg hugtök sem tengjast Evrópusambandinu og stofnunum þess. Nú eru í safninu u.þ.b. 55.000 grunnfærslur en hverri þeirra fylgja á bilinu
6-8 upplýsingareitir.  Ný hugtök eru reglulega færð inn.
      </p>
      <p>
        Aðgangur að safninu er öllum opinn.
      </p>
    </td>
  </tr>
</table>

<p>
<b>Athugið:</b><br/>
Hugtakasafnið er í eigu Þýðingamiðstöðvar utanríkisráðuneytisins og unnið af starfsmönnum hennar. Óheimilt er með öllu að afrita það eða nýta á nokkurn hátt til útgáfu eða fjölföldunar. Hins vegar er öllum heimilt að fletta upp í hugtakasafninu.
Umsjón með vefsetningu hugtakasafns:  <a href="mailto:reynir.gunnlaugsson@utn.stjr.is">Reynir Gunnlaugsson</a>.
</p>

<%
set sql_query "select  max(updated) as updated from hugtakasafn_updated"
set db [ns_db gethandle]
set selection [ns_db select $db $sql_query]
ns_db getrow $db $selection
set_variables_after_query
set list_updated [split $updated "-"]
set upd_dags "[string trimleft [lindex $list_updated 2] "0"]. "
switch [lindex $list_updated 1] {
  "01" {append upd_dags "janúar "}
  "02" {append upd_dags "febrúar "}
  "03" {append upd_dags "mars "}
  "04" {append upd_dags "apríl "}
  "05" {append upd_dags "maí "}
  "06" {append upd_dags "júní "}
  "07" {append upd_dags "júlí "}
  "08" {append upd_dags "ágúst "}
  "09" {append upd_dags "september "}
  "10" {append upd_dags "október "}
  "11" {append upd_dags "nóvember "}
  "12" {append upd_dags "desember "}
}
append upd_dags [lindex $list_updated 0]
%>

<p>
Hugtakasafnið var <strong>síðast uppfært <%=$upd_dags%></strong>
</p>



<% ns_adp_include stjrEftir.adp %>

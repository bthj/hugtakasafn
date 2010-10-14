<% ns_adp_include stjrFyrir.adp %>


<% ns_adp_include leit-einfold.adp %>

<table>
  <tr>
    <td vAlign="top">
      <p>
        <a href="umhts.adp">Um hugtakasafni�</a>:
      <ul>
        <li><a href="umhts.adp#almennt">Almennt</a></li>
        <li><a href="umhts.adp#notkun">Notkun</a></li>
        <li><a href="umhts.adp#saga">Saga</a></li>
      </ul>
      </p>
      <p>
        Sj� einnig:
      </p>
      <ul>
        <li><a href="http://www.ordabanki.ismal.hi.is/search">OR�ABANKI �slenskrar m�lst��var</a></li>
      </ul>
    </td>
    <td>
      <p>
        <b>���ingami�st�� utanr�kisr��uneytisins</b> hefur birt hugtakasafn sitt � vefsl��inni: www.hugtakasafn.utn.stjr.is.
      </p>
      <p>
        Unni� hefur veri� a� s�fnun hugtaka og or�asambanda � safni� allt fr� stofnun ���ingami�st��varinnar �ri� 1990. S�fellt er unni� a� endursko�un og a�l�gun safnsins me� vefsetningu �ess � huga enda er vefsetning �slenskra hugtakasafna li�ur � tungut�kniverkefni r�kisstj�rnarinnar.
      </p>
      <p>
        Hugt�kin og or�asamb�ndin eru a� st�rum hluta �r tilskipunum og regluger�um sem falla undir EES-samninginn en ���ing �eirra yfir � �slensku er einmitt helsta verkefni  ���ingami�st��varinnar. Einnig eru � safninu hugt�k sem tengjast ��rum millir�kjasamningum, svo sem Schengen-samningnum og samningnum um stofnun Al�j��avi�skiptastofnunarinnar (GATT). �� eru � safninu fj�ldam�rg hugt�k sem tengjast Evr�pusambandinu og stofnunum �ess. N� eru � safninu u.�.b. 55.000 grunnf�rslur en hverri �eirra fylgja � bilinu
6-8 uppl�singareitir.  N� hugt�k eru reglulega f�r� inn.
      </p>
      <p>
        A�gangur a� safninu er �llum opinn.
      </p>
    </td>
  </tr>
</table>

<p>
<b>Athugi�:</b><br/>
Hugtakasafni� er � eigu ���ingami�st��var utanr�kisr��uneytisins og unni� af starfsm�nnum hennar. �heimilt er me� �llu a� afrita �a� e�a n�ta � nokkurn h�tt til �tg�fu e�a fj�lf�ldunar. Hins vegar er �llum heimilt a� fletta upp � hugtakasafninu.
Umsj�n me� vefsetningu hugtakasafns:  <a href="mailto:reynir.gunnlaugsson@utn.stjr.is">Reynir Gunnlaugsson</a>.
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
  "01" {append upd_dags "jan�ar "}
  "02" {append upd_dags "febr�ar "}
  "03" {append upd_dags "mars "}
  "04" {append upd_dags "apr�l "}
  "05" {append upd_dags "ma� "}
  "06" {append upd_dags "j�n� "}
  "07" {append upd_dags "j�l� "}
  "08" {append upd_dags "�g�st "}
  "09" {append upd_dags "september "}
  "10" {append upd_dags "okt�ber "}
  "11" {append upd_dags "n�vember "}
  "12" {append upd_dags "desember "}
}
append upd_dags [lindex $list_updated 0]
%>

<p>
Hugtakasafni� var <strong>s��ast uppf�rt <%=$upd_dags%></strong>
</p>



<% ns_adp_include stjrEftir.adp %>

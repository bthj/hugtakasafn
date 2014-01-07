<% ns_adp_include stjrFyrir.adp %>
<% ns_adp_include heading1is.adp %>

<% ns_adp_include leit-einfold.adp %>

<table>
  <tr>
    <td vAlign="top">
      <p>
        <a href="umhts.adp">Um Hugtakasafnið</a>:
      <ul>
      </ul>
      </p>
      <p>
        Sjá einnig:
      </p>
      <ul>
        <li><a href="http://www.ordabanki.hi.is/wordbank/search">ORÐABANKI Íslenskrar málstöðvar</a></li>
      </ul>
    </td>
    <td>
      <p>
        <b>Þýðingamiðstöð utanríkisráðuneytisins</b> hefur birt hugtakasafn sitt á vefslóðinni: www.hugtakasafn.utn.stjr.is.
      </p>
      <p>
        Unnið hefur verið að söfnun íðorða (sérfræðiorða) og orðasambanda hjá þýðingamiðstöð frá árinu 1990 í tengslum við þýðingu samningsins um Evrópska efnahagssvæðið (EES-samningsins) og lagatexta sem falla undir hann. Flest íðorðanna tengjast hinum ýmsu sérsviðum EES-samningsins. Þá eru í safninu mörg íðorð úr lagamáli og stjórnsýslu, svo og heiti milliríkjasamninga, stofnana, nefnda, ráða o.fl. Einnig hefur orðasafn Þróunarsamvinnustofnunar Íslands verið birt í hugtakasafninu.
      </p>
      <p>
        Hjá þýðingamiðstöð er unnið að íðorðastarfi og nýyrðasmíð í samstarfi við sérfræðinga hjá opinberum stofnunum, í háskólasamfélaginu og atvinnulífinu. Nú eru í safninu rúmlega 70.000 færslur en hverri þeirra fylgja á bilinu 5-8 upplýsingareitir. Ný íðorð eru reglulega færð inn.
      </p>
      <p>
        Aðgangur að safninu er öllum opinn.
      </p>
    </td>
  </tr>
</table>

<p>
<b>Athugið:</b><br/>
Hugtakasafnið er í eigu þýðingamiðstöðvar utanríkisráðuneytisins og unnið af starfsmönnum hennar. Heimilt er að endurnota upplýsingar úr hugtakasafni, sbr. VII. kafla upplýsingalaga nr. 140/2012, enda sé uppruna upplýsinganna jafnan getið. 
Ritstjóri hugtakasafns er <a href="mailto:sigrun.thorgeirsdottir@utn.stjr.is">Sigrún Þorgeirsdóttir</a> og vefstjóri er  <a href="mailto:reynir.gunnlaugsson@utn.stjr.is">Reynir Gunnlaugsson</a>.
</p> Að ritstjórn hugtakasafns hafa unnið Björgvin R. Andersen, Hálfdan Ó. Hálfdanarson og Sindri Guðjónsson.

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

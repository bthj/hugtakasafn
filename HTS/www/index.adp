<% ns_adp_include stjrFyrir.adp %>
<% ns_adp_include heading1is.adp %>

<% ns_adp_include leit-einfold.adp %>

<table>
  <tr>
    <td vAlign="top" style="padding-right: 1em;">
      <p>
        <a href="umhts.adp">Um Hugtakasafnið</a>:
      <ul>
      </ul>
      </p>
      <p>
        Sjá einnig:
      </p>
      <ul>
        <li><a href="http://www.ordabanki.hi.is/wordbank/search">Íðorðabanki Árnastofnunar</a></li>
      </ul>
      </p>
      <p>
      <ul>
        <li><a href="http://www.eionet.europa.eu/gemet/is/theme/25/concepts/">GEMET orðalistinn</a></li>
      </ul>
      </p>
    </td>
    <td>
      <p>
        <b>Þýðingamiðstöð utanríkisráðuneytisins</b> hefur birt hugtakasafn sitt á vefslóðinni: www.hugtakasafn.utn.stjr.is.
      </p>
      <p>
        Hátt í aldarfjórðung hafa verið þýddir hjá þýðingamiðstöð utanríkisráðuneytisins lagatextar sem falla undir samninginn um Evrópska efnahagssvæðið (EES-samninginn). Eitt stærsta verkefnið í þýðingarstarfinu er skilgreining nýrra hugtaka í textunum og leit að íslenskum þýðingum þessara sérfræðihugtaka (íslenskum íðorðum). Þetta er jafnan tímafrekasti þátturinn í starfinu og oft þarf að smíða nýyrði þegar orðaleitin ber ekki árangur. Frá upphafi þýðingarstarfsins hefur íðorðum og orðasamböndum verið safnað í Hugtakasafn þýðingamiðstöðvar. Hugtakasafnið er birt á vef utanríkisráðuneytisins og hefur verið aðgengilegt á Netinu frá árinu 1995. Flest íðorðanna tengjast hinum margvíslegu sérsviðum EES-samningsins en af þeim má nefna t.d. félagsleg réttindi, flutninga, fjármál, lyf, neytendamál og umhverfismál. Þá eru í safninu mörg íðorð úr lagamáli og stjórnsýslu, svo og heiti milliríkjasamninga, stofnana, nefnda, ráða o.fl. Einnig hefur orðasafn Þróunarsamvinnustofnunar Íslands verið birt í Hugtakasafninu.
      </p>
      <p>
        Hjá þýðingamiðstöð er unnið að íðorðastarfi og nýyrðasmíð í samstarfi við sérfræðinga hjá ráðuneytum, opinberum stofnunum, í háskólasamfélaginu og atvinnulífinu. Nú eru í safninu rúmlega 82.000 færslur og hverri þeirra fylgja nokkrir upplýsingareitir. Ný íðorð eru reglulega færð inn. Með þýðingum og íðorðastarfi er sífellt unnið að því að stækka íslenskan orðaforða, efla íslenska tungu og styrkja stöðu hennar á nýjum sviðum. Nálgast má allar birtar þýðingar sem falla undir EES-samninginn á vef EFTA: <a href="http://www.efta.int/eea-lex?qs=31998L0047&sort_bef_combine=search_api_relevance+DESC&sort_by=search_api_relevance&=Search">EEA-Lex.</a>
      </p>
      <p>
        Aðgangur að safninu er öllum opinn.
      </p>
    </td>
  </tr>
</table>

<p>
<b>Athugið:</b><br/>
Hugtakasafnið er í eigu þýðingamiðstöðvar utanríkisráðuneytisins og unnið af starfsmönnum hennar. Heimilt er að endurnota upplýsingar úr Hugtakasafni, sbr. VII. kafla upplýsingalaga nr. 140/2012, enda sé uppruna upplýsinganna jafnan getið.
      <p>
        Ritstjóri Hugtakasafns þýðingamiðstöðvar er <a href="mailto:sigrun.thorgeirsdottir@utn.stjr.is">Sigrún Þorgeirsdóttir</a>. Að ritstjórn Hugtakasafns hafa unnið Ásta K. Hauksdóttir Wiium íðorðastjóri, Björgvin R. Andersen íðorðastjóri, Brynjólfur Sveinsson íðorðastjóri, Gunnhildur Stefánsdóttir íðorðastjóri, Hálfdan Ó. Hálfdanarson íðorðastjóri og Sindri Guðjónsson lögfræðingur. <a href="mailto:reynir.gunnlaugsson@utn.stjr.is">Reynir Gunnlaugsson</a> er vefstjóri og Björn Þór Jónsson hefur umsjón með forritun.
      </p>


<%
set sql_query "select max(updated) as updated, entry_count from hugtakasafn_updated group by entry_count"
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
Hugtakasafnið var <strong>síðast uppfært <%=$upd_dags%></strong> með <strong><%=$entry_count%></strong> færslum.
</p>



<% ns_adp_include stjrEftir.adp %>

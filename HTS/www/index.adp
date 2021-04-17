<% ns_adp_include stjrFyrir.adp %>
<% ns_adp_include heading1is.adp %>

<% ns_adp_include leit-einfold.adp %>

<table>
  <tr>
    <td vAlign="top" style="padding-right: 1em;">
      <p>
        <a href="umhts.adp">Um Hugtakasafni�</a>:
      <ul>
      </ul>
      </p>
      <p>
        Sj� einnig:
      </p>
      <ul>
        <li><a href="http://www.ordabanki.hi.is/wordbank/search">��or�abanki �rnastofnunar</a></li>
      </ul>
      </p>
      <p>
      <ul>
        <li><a href="http://www.eionet.europa.eu/gemet/is/theme/25/concepts/">GEMET or�alistinn</a></li>
      </ul>
      </p>
    </td>
    <td>
      <p>
        <b>���ingami�st�� utanr�kisr��uneytisins</b> hefur birt hugtakasafn sitt � vefsl��inni: www.hugtakasafn.utn.stjr.is.
      </p>
      <p>
        H�tt � aldarfj�r�ung hafa veri� ��ddir hj� ���ingami�st�� utanr�kisr��uneytisins lagatextar sem falla undir samninginn um Evr�pska efnahagssv��i� (EES-samninginn). Eitt st�rsta verkefni� � ���ingarstarfinu er skilgreining n�rra hugtaka � textunum og leit a� �slenskum ���ingum �essara s�rfr��ihugtaka (�slenskum ��or�um). �etta er jafnan t�mafrekasti ��tturinn � starfinu og oft �arf a� sm��a n�yr�i �egar or�aleitin ber ekki �rangur. Fr� upphafi ���ingarstarfsins hefur ��or�um og or�asamb�ndum veri� safna� � Hugtakasafn ���ingami�st��var. Hugtakasafni� er birt � vef utanr�kisr��uneytisins og hefur veri� a�gengilegt � Netinu fr� �rinu 1995. Flest ��or�anna tengjast hinum margv�slegu s�rsvi�um EES-samningsins en af �eim m� nefna t.d. f�lagsleg r�ttindi, flutninga, fj�rm�l, lyf, neytendam�l og umhverfism�l. �� eru � safninu m�rg ��or� �r lagam�li og stj�rns�slu, svo og heiti millir�kjasamninga, stofnana, nefnda, r��a o.fl. Einnig hefur or�asafn �r�unarsamvinnustofnunar �slands veri� birt � Hugtakasafninu.
      </p>
      <p>
        Hj� ���ingami�st�� er unni� a� ��or�astarfi og n�yr�asm�� � samstarfi vi� s�rfr��inga hj� r��uneytum, opinberum stofnunum, � h�sk�lasamf�laginu og atvinnul�finu. N� eru � safninu r�mlega 82.000 f�rslur og hverri �eirra fylgja nokkrir uppl�singareitir. N� ��or� eru reglulega f�r� inn. Me� ���ingum og ��or�astarfi er s�fellt unni� a� �v� a� st�kka �slenskan or�afor�a, efla �slenska tungu og styrkja st��u hennar � n�jum svi�um. N�lgast m� allar birtar ���ingar sem falla undir EES-samninginn � vef EFTA: <a href="http://www.efta.int/eea-lex?qs=31998L0047&sort_bef_combine=search_api_relevance+DESC&sort_by=search_api_relevance&=Search">EEA-Lex.</a>
      </p>
      <p>
        A�gangur a� safninu er �llum opinn.
      </p>
    </td>
  </tr>
</table>

<p>
<b>Athugi�:</b><br/>
Hugtakasafni� er � eigu ���ingami�st��var utanr�kisr��uneytisins og unni� af starfsm�nnum hennar. Heimilt er a� endurnota uppl�singar �r Hugtakasafni, sbr. VII. kafla uppl�singalaga nr. 140/2012, enda s� uppruna uppl�singanna jafnan geti�.
      <p>
        Ritstj�ri Hugtakasafns ���ingami�st��var er <a href="mailto:sigrun.thorgeirsdottir@utn.stjr.is">Sigr�n �orgeirsd�ttir</a>. A� ritstj�rn Hugtakasafns hafa unni� �sta K. Hauksd�ttir Wiium ��or�astj�ri, Bj�rgvin R. Andersen ��or�astj�ri, Brynj�lfur Sveinsson ��or�astj�ri, Gunnhildur Stef�nsd�ttir ��or�astj�ri, H�lfdan �. H�lfdanarson ��or�astj�ri og Sindri Gu�j�nsson l�gfr��ingur. <a href="mailto:reynir.gunnlaugsson@utn.stjr.is">Reynir Gunnlaugsson</a> er vefstj�ri og Bj�rn ��r J�nsson hefur umsj�n me� forritun.
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
Hugtakasafni� var <strong>s��ast uppf�rt <%=$upd_dags%></strong> me� <strong><%=$entry_count%></strong> f�rslum.
</p>



<% ns_adp_include stjrEftir.adp %>

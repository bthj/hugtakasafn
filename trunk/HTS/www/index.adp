<% ns_adp_include stjrFyrir.adp %>
<% ns_adp_include heading1is.adp %>

<% ns_adp_include leit-einfold.adp %>

<table>
  <tr>
    <td vAlign="top">
      <p>
        <a href="umhts.adp">Um Hugtakasafni�</a>:
      <ul>
      </ul>
      </p>
      <p>
        Sj� einnig:
      </p>
      <ul>
        <li><a href="http://www.ordabanki.hi.is/wordbank/search">OR�ABANKI �slenskrar m�lst��var</a></li>
      </ul>
    </td>
    <td>
      <p>
        <b>���ingami�st�� utanr�kisr��uneytisins</b> hefur birt hugtakasafn sitt � vefsl��inni: www.hugtakasafn.utn.stjr.is.
      </p>
      <p>
        Unni� hefur veri� a� s�fnun ��or�a (s�rfr��ior�a) og or�asambanda hj� ���ingami�st�� fr� �rinu 1990 � tengslum vi� ���ingu samningsins um Evr�pska efnahagssv��i� (EES-samningsins) og lagatexta sem falla undir hann. Flest ��or�anna tengjast hinum �msu s�rsvi�um EES-samningsins. �� eru � safninu m�rg ��or� �r lagam�li og stj�rns�slu, svo og heiti millir�kjasamninga, stofnana, nefnda, r��a o.fl. Einnig hefur or�asafn �r�unarsamvinnustofnunar �slands veri� birt � hugtakasafninu.
      </p>
      <p>
        Hj� ���ingami�st�� er unni� a� ��or�astarfi og n�yr�asm�� � samstarfi vi� s�rfr��inga hj� opinberum stofnunum, � h�sk�lasamf�laginu og atvinnul�finu. N� eru � safninu r�mlega 70.000 f�rslur en hverri �eirra fylgja � bilinu 5-8 uppl�singareitir. N� ��or� eru reglulega f�r� inn.
      </p>
      <p>
        A�gangur a� safninu er �llum opinn.
      </p>
    </td>
  </tr>
</table>

<p>
<b>Athugi�:</b><br/>
Hugtakasafni� er � eigu ���ingami�st��var utanr�kisr��uneytisins og unni� af starfsm�nnum hennar. Heimilt er a� endurnota uppl�singar �r hugtakasafni, sbr. VII. kafla uppl�singalaga nr. 140/2012, enda s� uppruna uppl�singanna jafnan geti�. 
Ritstj�ri hugtakasafns er <a href="mailto:sigrun.thorgeirsdottir@utn.stjr.is">Sigr�n �orgeirsd�ttir</a> og vefstj�ri er  <a href="mailto:reynir.gunnlaugsson@utn.stjr.is">Reynir Gunnlaugsson</a>.
</p> A� ritstj�rn hugtakasafns hafa unni� Bj�rgvin R. Andersen, H�lfdan �. H�lfdanarson og Sindri Gu�j�nsson.

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

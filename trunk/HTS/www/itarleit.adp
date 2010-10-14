<% ns_adp_include stjrFyrir.adp %>

  <a href="/">Hugtakasafn</a>
<br/><br/>
<form method="post" action="itarleit-nidurstodur.adp">
  <table>
    <tr>
      <td><b>Hugtak:</b></td>
      <td>
        <input type="text" name="hugtak" size="32"/>
        <select name="tungumal">
          <option value="oll">öll tungumál</option>
          <option value="is">íslenska</option>
          <option value="en">enska</option>
          <option value="danosae">danska/norska/sænska</option>
          <option value="fr">franska</option>
          <option value="de">þýska</option>
          <option value="la">latína</option>
        </select>
      </td>
    </tr>    
    <tr>
      <td><b>Samheiti</b></td>
      <td>
        <select name="samh_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="samh"/>
      </td>
    </tr>    
    <tr>
      <td><b>Svið</b></td>
      <td>
        <select name="svid_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="svid"/>
      </td>
    </tr>    
    <tr>
      <td><b>Dæmi</b></td>
      <td>
        <select name="daemi_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="daemi"/>
      </td>
    </tr>    
    <tr>
      <td><b>Skilgreining</b></td>
      <td>
        <select name="skilgr_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="skilgr"/>
      </td>
    </tr>
    <tr>
      <td><b>Rit</b></td>
      <td>
        <select name="rit_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="rit"/>
      </td>
    </tr>
    
    <tr>
      <td><b>Skjal nr.</b></td>
      <td>
        <select name="skjalnr_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="skjalnr"/>
      </td>
    </tr>

    <tr>
      <td><b>Heimild</b></td>
      <td>
        <select name="heimild_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="heimild"/>
      </td>
    </tr>
    <tr>
      <td><b>Athugasemd</b></td>
      <td>
        <select name="aths_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="aths"/>
      </td>
    </tr>
    <tr>
      <td><b>Aðalorð</b></td>
      <td>
        <select name="adalord_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="adalord"/>
      </td>
    </tr>
    <tr>
      <td><b>Orðflokkur</b></td>
      <td>
        <select name="ordflokkur_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="ordflokkur"/>
      </td>
    </tr>
    <tr>
      <td><b>Kyn</b></td>
      <td>
        <select name="kyn_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="kyn"/>
      </td>
    </tr>
    <tr>
      <td><b>Önnur málfræði</b></td>
      <td>
        <select name="onnurmalfr_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="onnurmalfr"/>
      </td>
    </tr>
    <tr>
      <td><b>Skammstöfun</b></td>
      <td>
        <select name="skst_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="skst"/>
      </td>
    </tr>
    <tr>
      <td><b>Annar ritháttur</b></td>
      <td>
        <select name="annarrh_op">
          <option value="og">og</option>
          <option value="eda">eða</option>
          <option value="ekki">og ekki</option>
        </select>
        <input type="text" name="annarrh"/>
      </td>
    </tr>
  </table>
  <br/>
  <input type="submit" name="leita" value="Leita"/> <input type="reset" value="Hreinsa form"/> <a href="/">Til baka í grunnleit</a>
</form>
<br/>
<% ns_adp_include stjrEftir.adp %>

function skraHugtakLoad() {
  var doctree;
  if(window.opener.name == "adal") { // glugginn var opnaður frá aðalglugga; fyrsta skráning hugtaks frá tillögu úr pari
    document.getElementById('hugtak-enska').setAttribute('value', window.opener.document.getElementById('hugtak-enska').getAttribute("value"));
    document.getElementById('hugtak-islenska').setAttribute('value', window.opener.document.getElementById('hugtak-islenska').getAttribute("value"));
    document.getElementById('hugtak-daemi-enskt').setAttribute('value', window.opener.document.getElementById('hugtak-daemi-enskt').getAttribute("value"));
    document.getElementById('hugtak-daemi-islenskt').setAttribute('value', window.opener.document.getElementById('hugtak-daemi-islenskt').getAttribute("value"));
    document.getElementById('hugtak-rit').setAttribute('value', window.opener.document.getElementById('hugtak-rit').getAttribute("value"));
    document.getElementById('hugtak-skjal').setAttribute('value', window.opener.document.getElementById('hugtak-skjal').getAttribute("value"));
    doctree = window.opener.document.getElementById("skjol-tree");
//    document.getElementById('hugtak-rit').setAttribute('value', 
//      doctree.view.getCellText(doctree.currentIndex,doctree.columns?doctree.columns["skjol-rit"]:"skjol-rit") + " " +
//      doctree.view.getCellText(doctree.currentIndex,doctree.columns?doctree.columns["skjol-flokkun"]:"skjol-flokkun") + ", " +
//      doctree.view.getCellText(doctree.currentIndex,doctree.columns?doctree.columns["skjol-dags"]:"skjol-dags") + ", " +
//      doctree.view.getCellText(doctree.currentIndex,doctree.columns?doctree.columns["skjol-bls"]:"skjol-bls")
//    );
  }
  else if(window.opener.name == "hugtakalisti") { // glugginn opnaður úr hugtakalista; breyting skráningar
    doctree = window.opener.document.getElementById("hugtokList");    
    var req = new XMLHttpRequest();
    req.open('GET', 'http://hugtakasafn.utn.stjr.is/hugtakagripill/xul-hugtak.tcl?id='+window.arguments[0], false);
    req.send(null);
		if(req.status == 200)
    	eval(req.responseText); //kallar í doInsertHugtakData(...)
  }
}

function doInsertHugtakData(id, dags, enska, islenska, daemi_enska, daemi_islenska, rit, skjal_nr, samheiti, svid, heimild, athugasemd, adalord, ordflokkur, kyn, onnur_malfraedi, skammstofun, skilgreining, nafn_ordtaka, gilding, enska_skammstofun, islenska_annar_rith, enska_annar_rith, da_no_sae, de, fr, la) {
	document.getElementById('hugtak-id').setAttribute('value', id);
	document.getElementById('hugtak-enska').setAttribute('value', enska);
	document.getElementById('hugtak-islenska').setAttribute('value', islenska);
	document.getElementById('hugtak-daemi-enskt').setAttribute('value', daemi_enska);
	document.getElementById('hugtak-daemi-islenskt').setAttribute('value', daemi_islenska);
	document.getElementById('hugtak-rit').setAttribute('value', rit);
	document.getElementById('hugtak-skjal').setAttribute('value', skjal_nr);
	document.getElementById('hugtak-adalord').setAttribute('value', adalord);
	document.getElementById('hugtak-svid').value = svid;
	document.getElementById('hugtak-ordflokkur').value = ordflokkur;
	document.getElementById('hugtak-kyn').value = kyn;
	document.getElementById('hugtak-onnurmalfraedi').value = onnur_malfraedi;
	document.getElementById('hugtak-skilgreining').setAttribute('value', skilgreining);
	document.getElementById('hugtak-nafn-ordtaka').setAttribute('value', nafn_ordtaka);
	document.getElementById('hugtak-samheiti').setAttribute('value', samheiti);
	document.getElementById('hugtak-athugasemd').setAttribute('value', athugasemd);
	document.getElementById('hugtak-heimild').setAttribute('value', heimild);
	document.getElementById('hugtak-gilding').value = gilding;
	document.getElementById('hugtak-skammstofun').setAttribute('value', skammstofun);
	document.getElementById('hugtak-en-skammstofun').setAttribute('value', enska_skammstofun);
	document.getElementById('hugtak-is-annar-rithattur').setAttribute('value', islenska_annar_rith);
	document.getElementById('hugtak-en-annar-rithattur').setAttribute('value', enska_annar_rith);
	document.getElementById('hugtak-da-no-sae').setAttribute('value', da_no_sae);
	document.getElementById('hugtak-de').setAttribute('value', de);
	document.getElementById('hugtak-fr').setAttribute('value', fr);
	document.getElementById('hugtak-la').setAttribute('value', la);
}

//skrá hugtakið í gagnagrunn
function skraHugtak() {
  var params = encodeURI("enska=" + document.getElementById("hugtak-enska").value +
               "&islenska=" + document.getElementById("hugtak-islenska").value +
               "&daemienska=" + document.getElementById("hugtak-daemi-enskt").value +
               "&daemiislenska=" + document.getElementById("hugtak-daemi-islenskt").value +
               "&rit=" + document.getElementById("hugtak-rit").value +
               "&skjal=" + document.getElementById("hugtak-skjal").value +
               "&samheiti=" + document.getElementById("hugtak-samheiti").value +
               "&svid=" + document.getElementById("hugtak-svid").value +
               "&heimild=" + document.getElementById("hugtak-heimild").value +
               "&athugasemd=" + document.getElementById("hugtak-athugasemd").value +
               "&adalord=" + document.getElementById("hugtak-adalord").value +
               "&ordflokkur=" + document.getElementById("hugtak-ordflokkur").value +
               "&kyn=" + document.getElementById("hugtak-kyn").value +
               "&onnurmalfraedi=" + document.getElementById("hugtak-onnurmalfraedi").value +
               "&skammstofun=" + document.getElementById("hugtak-skammstofun").value +
               "&skilgreining=" + document.getElementById("hugtak-skilgreining").value +
               "&nafnordtaka=" + document.getElementById("hugtak-nafn-ordtaka").value +
               "&gilding=" + document.getElementById("hugtak-gilding").value +
               "&enskammstofun=" + document.getElementById("hugtak-en-skammstofun").value +
               "&isannarrithattur=" + document.getElementById("hugtak-is-annar-rithattur").value +
               "&enannarrithattur=" + document.getElementById("hugtak-en-annar-rithattur").value +
               "&danosae=" + document.getElementById("hugtak-da-no-sae").value +
               "&de=" + document.getElementById("hugtak-de").value +
               "&fr=" + document.getElementById("hugtak-fr").value +
               "&la=" + document.getElementById("hugtak-la").value);
  var req = new XMLHttpRequest(); // Request
  var res = null; // Response
  
	if(window.opener.name == "adal") { // glugginn var opnaður frá aðalglugga; fyrsta skráning hugtaks frá tillögu úr pari
		req.open("POST", "http://hugtakasafn.utn.stjr.is/hugtakagripill/xul-skra-hugtak.tcl");
		//  req.setRequestHeader("Content-Type","multipart/form-data"); 
		//  req.setRequestHeader("Content-Encoding","ISO-8859-1"); 
	} else if(window.opener.name == "hugtakalisti") { // glugginn opnaður úr hugtakalista; breyting skránigar
		params += encodeURI("&id=" + document.getElementById("hugtak-id").value);
		req.open("POST", "http://hugtakasafn.utn.stjr.is/hugtakagripill/xul-update-hugtak.tcl");
	}

  req.send(params);
  
  window.close();
}

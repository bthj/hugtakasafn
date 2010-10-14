
function upload_files() {
    //signed.applets.codebase_principal_support = true;
    //netscape.security.PrivilegeManager.enablePrivilege(
  //		'UniversalXPConnect UniversalBrowserAccess');
    const nsIFilePicker = Components.interfaces.nsIFilePicker;
  
    var fp = Components.classes["@mozilla.org/filepicker;1"].createInstance(nsIFilePicker);
    fp.init(window, "BAK skrár til að vinna pör úr", nsIFilePicker.modeOpenMultiple);
    fp.appendFilter("BAK skrár","*.bak");
    fp.appendFilters(nsIFilePicker.filterAll);
  
    var rv = fp.show();
    if (rv == nsIFilePicker.returnOK)
    {
      //var file = fp.file;
      var files = fp.files;
      var file;
      // work with returned nsILocalFile...
      var jsFile;
      var http;
      var req;
      while(files.hasMoreElements()) {
        file = files.getNext().QueryInterface(Components.interfaces.nsILocalFile);
        jsFile = new File(file.path);
        req = new FilePostRequest("http://hugtakasafn.utn.stjr.is/hugtakagripill/bakprocess.tcl");
        req.setFile(jsFile.leaf,jsFile,"application/x-www-form-urlencoded");
        http = new HTTP();
        http.doOperation(req);
        alert(file.path);
      }
  }
}

function upload_files_via_channel() {
    const nsIFilePicker = Components.interfaces.nsIFilePicker;
  
    var fp = Components.classes["@mozilla.org/filepicker;1"].createInstance(nsIFilePicker);
    fp.init(window, "BAK skrár til að vinna pör úr", nsIFilePicker.modeOpenMultiple);
    fp.appendFilter("BAK skrár","*.bak");
    fp.appendFilters(nsIFilePicker.filterAll);
  
    var rv = fp.show();
    if (rv == nsIFilePicker.returnOK)
    {
      var files = fp.files;
      var file;
      const ioService = Components.classes["@mozilla.org/network/io-service;1"].getService(Components.interfaces.nsIIOService);
      while(files.hasMoreElements()) {
        file = files.getNext().QueryInterface(Components.interfaces.nsILocalFile);
        
        var uploadURI = ioService.newURI("http://hugtakasafn.utn.stjr.is/hugtakagripill/uploadchannel.tcl", null, null);
        var ioChannel = ioService.newChannelFromURI(uploadURI);
        var uploadChannel = ioChannel.QueryInterface(Components.interfaces.nsIUploadChannel);
        
        fileStream = Components.classes["@mozilla.org/network/file-input-stream;1"].createInstance(Components.interfaces.nsIFileInputStream);
        fileStream.init(file,0x01, 00004, null);
        
        uploadChannel.setUploadStream(fileStream, "text/plain", -1);
        
        var httpChannel = ioChannel.QueryInterface(Components.interfaces.nsIHttpChannel);
        httpChannel.requestMethod = "POST";
        
        httpChannel.open();
        
        // alert(file.path);
      }
    }
}

function upload_files_via_xmlhttp() {
    netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect UniversalBrowserAccess")
    const nsIFilePicker = Components.interfaces.nsIFilePicker;
  
    var fp = Components.classes["@mozilla.org/filepicker;1"].createInstance(nsIFilePicker);
    fp.init(window, "BAK skrár til að vinna pör úr", nsIFilePicker.modeOpenMultiple);
    fp.appendFilter("BAK skrár","*.bak");
    fp.appendFilters(nsIFilePicker.filterAll);
  
    var rv = fp.show();
    if (rv == nsIFilePicker.returnOK)
    {
      var files = fp.files;
      var file;
      var jsFile;
      while(files.hasMoreElements()) {
        file = files.getNext().QueryInterface(Components.interfaces.nsILocalFile);
//        jsFile = new File(file.path);
//        jsFile.open();
//        var sData = "clientfile=" + encodeURIComponent( String(new Date) ); 
//        var sData = "clientfile=" + encodeURIComponent( jsFile.read() );
//        var sData = "clientfile=" +  jsFile.read();
        fileStream = Components.classes["@mozilla.org/network/file-input-stream;1"].createInstance(Components.interfaces.nsIFileInputStream);
        fileStream.init(file,0x01, 00004, null);
        var req = new XMLHttpRequest;
        req.open("POST", "http://hugtakasafn.utn.stjr.is/hugtakagripill/uploadchannel.tcl", false);
//        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.setRequestHeader("Content-Type", "multipart/form-data");
//        req.setRequestHeader("Content-Length", sData.length);
//        req.send(sData);
        req.send(fileStream);
        if (req.status / 100 == 2) {
          alert(req.responseText);
          alert(jsFile.read());
        } else {
          alert("else");
        }
      }
    }
}

function display_pair() {
  alert('Paste invoked');
}

// byggir upp RDF gögn í minni og setur í tré
function doBakDocTree(skrarheiti, flokkur, rit, bls, dags) {
  // get the XPCOM services we need to work with RDF's
  var RDF = 
  Components.classes['@mozilla.org/rdf/rdf-service;1'].getService();
  RDF = RDF.QueryInterface(Components.interfaces.nsIRDFService);

  var RDFC = Components.classes['@mozilla.org/rdf/container;1'].getService();
  RDFC = RDFC.QueryInterface(Components.interfaces.nsIRDFContainer);

  var RDFCUtils = 
  Components.classes['@mozilla.org/rdf/container-utils;1'].getService();
  RDFCUtils = 
  RDFCUtils.QueryInterface(Components.interfaces.nsIRDFContainerUtils);

  var ds = 
  Components.classes["@mozilla.org/rdf/datasource;1?name=in-memory-datasource"].createInstance();
  ds = ds.QueryInterface(Components.interfaces.nsIRDFDataSource);
  
  // create our root nodes
  var rootNode =  RDF.GetResource("urn:root");
  var seqNode =  RDF.GetResource("urn:root:seq");
  
  // insert the "top" of the tree, a Seq container
  ds.Assert(rootNode,
	   RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#skjol"),
	   seqNode, true);

  RDFCUtils.MakeSeq(ds, seqNode);
  RDFC.Init(ds, seqNode);

  // get the tree and add the datasource
  var tree = document.getElementById("skjol-tree");
  // clean the tree of datasources (bthj)
  var list = tree.database.GetDataSources();
  while (list.hasMoreElements()) {
    tree.database.RemoveDataSource(list.getNext());
  }
  tree.database.AddDataSource(ds);

  // let's add some data.
  for (var i = 0; i < skrarheiti.length; i++) {
    var newURI = "urn:root:doc:" + i;

    // add the new element
    RDFC.AppendElement(RDF.GetResource(newURI));

    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#skrarheiti"),
       RDF.GetLiteral(skrarheiti[i]), true);

    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#flokkur"),
       RDF.GetLiteral(flokkur[i]), true);

    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#rit"),
       RDF.GetLiteral(rit[i]), true);

    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#bls"),
       RDF.GetLiteral(bls[i]), true);

    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#dags"),
       RDF.GetLiteral(dags[i]), true);
  }

  tree.builder.rebuild();
}

// kallar eftir lista yfir BAK skjöl, fær til baka svar með javascript kóða sem eval er keyrt á
function listBakDocs() {
  var req = new XMLHttpRequest();
  req.open('GET', 'http://hugtakasafn.utn.stjr.is/hugtakagripill/xul-skjol.tcl', false);
  req.send(null);
  if(req.status == 200)
    eval(req.responseText); // kallar í doBakDocTree(...)
}

function doPairTree(nr, skrarheiti, enska, islenska) {
  // get the XPCOM services we need to work with RDF's
  var RDF = 
  Components.classes['@mozilla.org/rdf/rdf-service;1'].getService();
  RDF = RDF.QueryInterface(Components.interfaces.nsIRDFService);

  var RDFC = Components.classes['@mozilla.org/rdf/container;1'].getService();
  RDFC = RDFC.QueryInterface(Components.interfaces.nsIRDFContainer);

  var RDFCUtils = 
  Components.classes['@mozilla.org/rdf/container-utils;1'].getService();
  RDFCUtils = 
  RDFCUtils.QueryInterface(Components.interfaces.nsIRDFContainerUtils);

  var ds = 
  Components.classes["@mozilla.org/rdf/datasource;1?name=in-memory-datasource"].createInstance();
  ds = ds.QueryInterface(Components.interfaces.nsIRDFDataSource);
  
  // create our root nodes
  var rootNode =  RDF.GetResource("urn:por");
  var seqNode =  RDF.GetResource("urn:por:seq");
  
  // insert the "top" of the tree, a Seq container
  ds.Assert(rootNode,
	   RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#por"),
	   seqNode, true);

  RDFCUtils.MakeSeq(ds, seqNode);
  RDFC.Init(ds, seqNode);

  // get the tree and add the datasource
  var tree = document.getElementById("por-tree");
  // clean the tree of datasources (bthj)
  var list = tree.database.GetDataSources();
  while (list.hasMoreElements()) {
    tree.database.RemoveDataSource(list.getNext());
  }
  tree.database.AddDataSource(ds);

  // let's add some data.
  for (var i = 0; i < enska.length; i++) {
    var newURI = "urn:por:par:" + i;

    // add the new element
    RDFC.AppendElement(RDF.GetResource(newURI));

    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#enska"),
       RDF.GetLiteral(enska[i]), true);

    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#islenska"),
       RDF.GetLiteral(islenska[i]), true);
       
    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#nr"),
       RDF.GetLiteral(nr[i]), true);
       
    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#skrarheiti"),
       RDF.GetLiteral(skrarheiti), true);
  }

  tree.builder.rebuild();
  
}

// kallar eftir pörum
function listPairs(bakdoc) {
  var req = new XMLHttpRequest();
  req.open('GET', 'http://hugtakasafn.utn.stjr.is/hugtakagripill/xul-por.tcl?skjal=' + bakdoc, false);
  req.send(null);
  if(req.status == 200)
    eval(req.responseText);
}

// þegar bakskjal valið úr lista, birta pör þess
function selectBakDoc(event) {
  // the tree is the target of the event
  var tree = event.target;
  var col = tree.columns ? tree.columns["skjol-skjal"] : "skjol-skjal";
  var bakdoc = tree.view.getCellText(tree.currentIndex, col);
  listPairs(bakdoc);
}

// byggir upp rdf gögn fyrir <listbox/> með tillögum
function doSuggestionsListbox(ord, idxStart, idxEnd) {
  // get the XPCOM services we need to work with RDF's
  var RDF = 
  Components.classes['@mozilla.org/rdf/rdf-service;1'].getService();
  RDF = RDF.QueryInterface(Components.interfaces.nsIRDFService);

  var RDFC = Components.classes['@mozilla.org/rdf/container;1'].getService();
  RDFC = RDFC.QueryInterface(Components.interfaces.nsIRDFContainer);

  var RDFCUtils = 
  Components.classes['@mozilla.org/rdf/container-utils;1'].getService();
  RDFCUtils = 
  RDFCUtils.QueryInterface(Components.interfaces.nsIRDFContainerUtils);

  var ds = 
  Components.classes["@mozilla.org/rdf/datasource;1?name=in-memory-datasource"].createInstance();
  ds = ds.QueryInterface(Components.interfaces.nsIRDFDataSource);
  
  // create our root nodes
  var rootNode =  RDF.GetResource("urn:tillogur");
  var seqNode =  RDF.GetResource("urn:tillogur:seq");
  
  // insert the "top" of the tree, a Seq container
  ds.Assert(rootNode,
	   RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#tillogur"),
	   seqNode, true);

  RDFCUtils.MakeSeq(ds, seqNode);
  RDFC.Init(ds, seqNode);

  // get the tree and add the datasource
  var listbox = document.getElementById("tillogur-stakord");
  // clean the tree of datasources (bthj)
  var list = listbox.database.GetDataSources();
  while (list.hasMoreElements()) {
    listbox.database.RemoveDataSource(list.getNext());
  }
  listbox.database.AddDataSource(ds);

  // let's add some data.
  for (var i = 0; i < ord.length; i++) {
    var newURI = "urn:tillogur:tillaga:" + i;

    // add the new element
    RDFC.AppendElement(RDF.GetResource(newURI));

    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#ord"),
       RDF.GetLiteral(ord[i]), true);
       
    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#ordStart"),
       RDF.GetLiteral(idxStart[i]), true);
       
    ds.Assert(RDF.GetResource(newURI),
       RDF.GetResource("http://hugtakasafn.utn.stjr.is/hugtakagripill#ordEnd"),
       RDF.GetLiteral(idxEnd[i]), true);
  }

  listbox.builder.rebuild();
}

// kallar eftir tillögum
function listSuggestions(bakdoc, pairnr) {
  var req = new XMLHttpRequest();
  req.open('GET', 'http://hugtakasafn.utn.stjr.is/hugtakagripill/xul-tillogur-stakord.tcl?skjal=' + bakdoc + '&parnr=' + pairnr, false);
  req.send(null);
  if(req.status == 200)
    eval(req.responseText);
}

// þegar par valið úr lista, birta það í skráningarformi
function selectPair(event) {
  // the tree is the target of the event
  var pairtree = event.target;
  var enska = pairtree.view.getCellText(pairtree.currentIndex,pairtree.columns?pairtree.columns["parEnska"]:"parEnska");
  var islenska = pairtree.view.getCellText(pairtree.currentIndex,pairtree.columns?pairtree.columns["parIslenska"]:"parIslenska");
  var skjal = pairtree.view.getCellText(pairtree.currentIndex,pairtree.columns?pairtree.columns["parSkjal"]:"parSkjal");
  var nr = pairtree.view.getCellText(pairtree.currentIndex,pairtree.columns?pairtree.columns["parNr"]:"parNr");
  var doctree = document.getElementById("skjol-tree");
  var rit = doctree.view.getCellText(doctree.currentIndex,doctree.columns?doctree.columns["skjol-rit"]:"skjol-rit");
  var flokkun = doctree.view.getCellText(doctree.currentIndex,doctree.columns?doctree.columns["skjol-flokkun"]:"skjol-flokkun");
  var dags = doctree.view.getCellText(doctree.currentIndex,doctree.columns?doctree.columns["skjol-dags"]:"skjol-dags");
  var bls = doctree.view.getCellText(doctree.currentIndex,doctree.columns?doctree.columns["skjol-bls"]:"skjol-bls");
  document.getElementById('parskraning-enska').setAttribute('value',enska);
  document.getElementById('parskraning-islenska').setAttribute('value',islenska);
  document.getElementById('hugtak-rit').setAttribute( 'value', rit + " " + flokkun + ", " + dags + ", " + bls );
  document.getElementById('hugtak-skjal').setAttribute('value',skjal);
  
  cleanHugtakForm()
  listSuggestions(skjal, nr);
  setParDaemi();
}


/////////// val texta í enska hluta pars /////////////////
/*
function selectWord(event) {
  var wordList = event.target;
  var parEnska = document.getElementById('parskraning-enska'); //<textbox/>
  if (parEnska.setSelectionRange) {
    //input.focus();
    parEnska.setSelectionRange(
      parseInt(wordList.selectedItem.childNodes.item(1).getAttribute("label")), 
      parseInt(wordList.selectedItem.childNodes.item(2).getAttribute("label")) + 1);
  }
  document.getElementById('hugtak-enska').setAttribute('value', parEnska.value.substring(parEnska.selectionStart,parEnska.selectionEnd));
}
*/

function selectWord(event) {
  var wordList = document.getElementById('tillogur-stakord');
  var parEnska = document.getElementById('parskraning-enska'); //<textbox/>
  if (parEnska.setSelectionRange) {
    //input.focus();
    parEnska.setSelectionRange(
      parseInt(wordList.view.getCellText(wordList.currentIndex,wordList.columns?wordList.columns["tillogur-ordStart"]:"tillogur-ordStart")), 
      parseInt(wordList.view.getCellText(wordList.currentIndex,wordList.columns?wordList.columns["tillogur-ordEnd"]:"tillogur-ordEnd")) + 1);
  }
  document.getElementById('hugtak-enska').setAttribute('value', parEnska.value.substring(parEnska.selectionStart,parEnska.selectionEnd));
}
//smellt á takkan Skrá enskt
function selectEnskt() {
  var parEnska = document.getElementById('parskraning-enska'); //<textbox/>
  document.getElementById('hugtak-enska').setAttribute('value', parEnska.value.substring(parEnska.selectionStart,parEnska.selectionEnd));
}
//smellt á takkan Skrá íslenskt
function selectIslenskt() {
  var parIslenska = document.getElementById('parskraning-islenska'); //<textbox/>
  document.getElementById('hugtak-islenska').setAttribute('value', parIslenska.value.substring(parIslenska.selectionStart,parIslenska.selectionEnd));
}
//smellt á takkan Skrá par sem dæmi ...takki farinn
function setParDaemi() {
  var parEnska = document.getElementById('parskraning-enska'); //<textbox/>
  var parIslenska = document.getElementById('parskraning-islenska');
  document.getElementById('hugtak-daemi-enskt').setAttribute('value', parEnska.value);
  document.getElementById('hugtak-daemi-islenskt').setAttribute('value', parIslenska.value);
}
function cleanParDaemi() {
  document.getElementById('hugtak-daemi-enskt').setAttribute('value',"");
  document.getElementById('hugtak-daemi-islenskt').setAttribute('value',"");
}
//smellt á takkan Er enskt í HTS? - leitað orðrétt
function searchEnsktInHTS() {
  var parEnska = document.getElementById('parskraning-enska'); //<textbox/>
  window.open("http://hugtakasafn.utn.stjr.is/leit-nidurstodur.adp?tungumal=en&ordrett=t&leitarord="+parEnska.value.substring(parEnska.selectionStart,parEnska.selectionEnd), "hugtakasafn","");
}
function getSelectedSuggestion() {
  var wordList = document.getElementById('tillogur-stakord');
  return wordList.view.getCellText(wordList.currentIndex,wordList.columns?wordList.columns["tillogur-ord"]:"tillogur-ord");
}
//heinsa Hugtak form
function cleanHugtakForm() {
  document.getElementById('hugtak-enska').setAttribute('value',"");
  document.getElementById('hugtak-islenska').setAttribute('value',"");
  document.getElementById('hugtak-daemi-enskt').setAttribute('value',"");
  document.getElementById('hugtak-daemi-islenskt').setAttribute('value',"");
}

/////////// setja á stopplista /////////////////	
function putOnStoplist(stopword) {
  var req = new XMLHttpRequest(); // Request
  var res = null; // Response
//íslenskir stafir brenglast
  //var params = encodeURI("tillaga="+stopword);
  var params = "tillaga="+stopword;  

  req.open("POST", "http://hugtakasafn.utn.stjr.is/hugtakagripill/xul-tillaga-a-stopplista.tcl");
  req.send(params);
  
  var pairtree = document.getElementById('por-tree');
  var skjal = pairtree.view.getCellText(pairtree.currentIndex,pairtree.columns?pairtree.columns["parSkjal"]:"parSkjal");
  var nr = pairtree.view.getCellText(pairtree.currentIndex,pairtree.columns?pairtree.columns["parNr"]:"parNr");
  listSuggestions(skjal, nr);
}

/////////// skráning hugtaks /////////////////	

function skraHugtak() {
  window.name="adal";
  var win = window.open("hugtakagripill-skra-hugtak.xul","hugtakSkraning","modal=yes,resizable=yes");
}

/////////// fellivalmyndir /////////////////
function sjaHugtok() {
  var win = window.open("hugtakagripill-hugtok.xul","hugtok","modal=no,resizable=yes");
}
function sjaStopplista() {
  var win = window.open("hugtakagripill-stopplisti.xul","stopplisti","modal=no,resizable=yes");
}
function hladaInnBak() {
  var win = window.open("http://hugtakasafn.utn.stjr.is/hugtakagripill/fileuploadb.html","bakUpload","toolbar,scrollbars=yes,modal=no,resizable=yes");
}
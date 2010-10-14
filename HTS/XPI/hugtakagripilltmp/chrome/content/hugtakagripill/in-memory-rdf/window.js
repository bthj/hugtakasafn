/* 
	Contributed by Sandesh Karalkar (skexz@yahoo.co.in)
	http://in.geocities.com/skexz
*/


function startup() //Startup function.
{
	alert('hlaðið');
	createCustomerRDF('http://in.geocities.com/skexz/tuts/xul/in-memory/customers.xml');
}


function requestXMLdocument(URL) //requesting XML file from the remote location
{
	var oXML=new XMLHttpRequest();
	oXML.open("GET",URL,false);
	oXML.send(null);
	//Returning the document content to the XML parser function
	return oXML.responseText;    
}


function readXMLdocument(URL) //Parsing XML message.
{
	xmlMessage = requestXMLdocument(URL);
	this.parser = new DOMParser();
    var xmlDOM = this.parser.parseFromString(xmlMessage, "text/xml");
	//Returning the XML DOM.
	return xmlDOM;
}


function createCustomerRDF(URL){	//Creating customers In-Memory RDF feed

	var xmlDoc = readXMLdocument(URL);
    var customers = xmlDoc.documentElement;
	var customer = customers.getElementsByTagName("customer");


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
		 RDF.GetResource("http://www.bttlindia.com/RDF#subheadings"),
		 seqNode, true);

	RDFCUtils.MakeSeq(ds, seqNode);
	RDFC.Init(ds, seqNode);

	// get the tree and add the datasource
	var tree = document.getElementById("bo-customer-tree");
	tree.database.AddDataSource(ds);


	// let's add some data.
	for (var i = 0; i < customer.length; i++) {
		 var newURI = "urn:root:file:" + i;

		 // add the new element
		 RDFC.AppendElement(RDF.GetResource(newURI));

		 ds.Assert(RDF.GetResource(newURI),
			 RDF.GetResource("http://www.bttlindia.com/RDF#id"),
			 RDF.GetLiteral(customer[i].getAttribute("id")), true);

		 ds.Assert(RDF.GetResource(newURI),
			 RDF.GetResource("http://www.bttlindia.com/RDF#name"),
			 RDF.GetLiteral(customer[i].getAttribute("name")), true);

		 ds.Assert(RDF.GetResource(newURI),
			 RDF.GetResource("http://www.bttlindia.com/RDF#phone"),
			 RDF.GetLiteral(customer[i].getAttribute("phone")), true);

		 ds.Assert(RDF.GetResource(newURI),
			 RDF.GetResource("http://www.bttlindia.com/RDF#fiscalnumber"),
			 RDF.GetLiteral(customer[i].getAttribute("fiscalnumber")), true);
	}

	tree.builder.rebuild();
}

/* Updated on 1/12/04. */
function selectCustomer(event)
{
	// the tree is the target of the event
	var tree = event.target;
	var customerId =tree.view.getCellText(tree.currentIndex,"customer-id");
	var customerName =tree.view.getCellText(tree.currentIndex,"customer-name");
	alert("Customer ID : " + customerId +"\n"+
		  "Customer name : "+ customerName +"");
}

ns_write "HTTP/1.0 200 OK
Content-Type: application/vnd.mozilla.xul+xml; charset=utf-8
MIME-Version: 1.0
pragma: no-cache
Server: AOLserver/3.3.1+ad13

"

ns_write "<?xml version=\"1.0\"?>
<?xml-stylesheet href=\"chrome://global/skin/\" type=\"text/css\"?>
<?xml-stylesheet href=\"boxesTemp.css\" type=\"text/css\"?>
<!DOCTYPE window>
<window xmlns= \"http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul\" xmlns:html=\"http://www.w3.org/1999/xhtml\">
  <toolbox>
    <menubar>
      <menu label=\"Skrá\">
        <menupopup>
          <menuitem label=\"Hætta\"/>
        </menupopup>
      </menu>
      <menu label=\"Sýn\">
        <menupopup>
          <menuitem label=\"Pör\"/>
          <menuseparator/>
          <menuitem label=\"Hugtök\"/>
          <menuitem label=\"Vinnslulisti\"/>
          <menuitem label=\"Stopplisti\"/>
        </menupopup>
      </menu>
      <menu label=\"Aðgerðir\">
        <menupopup>
          <menuitem label=\"Lesa inn pör úr BAK skrám\"/>
          <menuitem label=\"Handfæra inn par\"/>
          <menuseparator/>
          <menuitem label=\"Sækja MT innflutningsskapalón\"/>
          <menuseparator/>
          <menuitem label=\"Skrá svið\"/>
        </menupopup>
      </menu>
    </menubar>
  </toolbox>
  <hbox flex=\"1\">
    <vbox id=\"viewSelectPaneBox\" persist=\"width\">
      <tree flex=\"1\" hidecolumnpicker=\"true\" class=\"plain\">
        <treecols>
          <treecol flex=\"1\" id=\"syn\" label=\"Sýn\" primary=\"true\"/>
        </treecols>
        <treechildren flex=\"1\">
          <treeitem>
            <treerow>
              <treecell label=\"Pör\"/>
            </treerow>
          </treeitem>
          <treeseparator/>
          <treeitem>
            <treerow>
              <treecell label=\"Hugtök\"/>
            </treerow>
          </treeitem>
          <treeitem>
            <treerow>
              <treecell label=\"Vinnslulisti\"/>
            </treerow>
          </treeitem>
          <treeitem>
            <treerow>
              <treecell label=\"Stopplisti\"/>
            </treerow>
          </treeitem>
        </treechildren>
      </tree>
    </vbox>
    <splitter collapse=\"before\" persist=\"state\">
      <grippy/>
    </splitter>
    <vbox flex=\"1\" persist=\"width\">
      <hbox align=\"center\">
        <label value=\"Lesa inn pör úr BAK skrám:\"/>
        <html:form enctype=\"multipart/form-data\" method=\"post\" action=\"bakprocess.tcl\">
          <html:input name=\"clientfile\" type=\"file\"/>
          <html:input name=\"submit\" type=\"submit\" value=\"Hlaða inn\"/>
        </html:form>
      </hbox>
      <hbox align=\"center\">
        <hbox align=\"center\">
          <label value=\"Sjá:\" accesskey=\"s\"/>
          <menulist>
            <menupopup>
              <menuitem label=\"Öll pör\" value=\"0\"/>
              <menuitem label=\"Pör með uppástungum\" value=\"0\"/>
              <menuitem label=\"Pör án nýjunga\" value=\"0\"/>
              <menuseparator/>
              <menuitem label=\"Sérsníða...\" value=\"0\"/>
            </menupopup>
          </menulist>
        </hbox>
        <label value=\"Pör innihalda\"/>
        <textbox flex=\"5\"/>
        <button label=\"Hreinsa\" disabled=\"true\" tooltiptext=\"Hreinsa leitarskilyrði og sýna öll pör\"/>
      </hbox>
      <tree flex=\"1\" class=\"plain focusring\" enableColumnDrag=\"true\">
        <treecols>
          <treecol flex=\"1\" id=\"parEnska\" label=\"Enska\" persist=\"hiddn ordinal width\"/>
          <splitter class=\"tree-splitter\"/>
          <treecol flex=\"1\" id=\"parIslenska\" label=\"Íslenska\" persist=\"hidden ordinal width\"/>
          <splitter class=\"tree-splitter\"/>
          <treecol flex=\"1\" id=\"parRit\" label=\"Rit\" persist=\"hidden ordinal width\"/>
          <splitter class=\"tree-splitter\"/>
          <treecol flex=\"1\" id=\"parFlokkun\" label=\"Flokkun\" persist=\"hidden ordinal width\"/>
          <splitter class=\"tree-splitter\"/>
          <treecol flex=\"1\" id=\"parDags\" label=\"Dags\" persist=\"hidden ordinal width\"/>
          <splitter class=\"tree-splitter\"/>
          <treecol flex=\"1\" id=\"parSkjal\" label=\"Skjal nr.\" persist=\"hidden ordinal width\"/>
        </treecols>
        <treechildren flex=\"1\">
"
set db [ns_db gethandle]
set selection [ns_db select $db "select * from por order by skrarheiti, enska"]
while { [ns_db getrow $db $selection] } {
  set_variables_after_query
  regsub -all {"} $enska {'} enska
  regsub -all {"} $islenska {'} islenska
  regsub -all {>} $enska {\&gt;} enska
  regsub -all {<} $enska {\&lt;} enska
  regsub -all {>} $islenska {\&gt;} islenska
  regsub -all {<} $islenska {\&lt;} islenska
  ns_write "<treeitem>
    <treerow>
      <treecell label=\"$enska\"/>
      <treecell label=\"$islenska\"/>
      <treecell label=\"\"/>
      <treecell label=\"\"/>
      <treecell label=\"\"/>
      <treecell label=\"$skrarheiti\"/>
    </treerow>
  </treeitem>
  "
}
ns_write "
        </treechildren>
      </tree>
      <splitter collapse=\"after\" persist=\"state\">
        <grippy/>
      </splitter>
      <vbox flex=\"3\" persist=\"collapsed height\">
        <groupbox flex=\"1\" collapsed=\"false\">
          <caption label=\"Par\"/>
	  <hbox flex=\"1\">
	    <vbox flex=\"1\">
	      <label value=\"Enska\"/>
	      <textbox multiline=\"true\" flex=\"1\" value=\"\"/>
	      <label value=\"Íslenska\"/>
	      <textbox multiline=\"true\" flex=\"1\" value=\"\"/>
	    </vbox>
	    <vbox>
	      <label value=\"Hugtakaaðgerðir\"/>
	      <button label=\"Skrá enskt\" tooltiptext=\"Færa valið enskt hugtak í skráningarform\"/>
	      <button label=\"Skrá íslenskt\" tooltiptext=\"Færa valið íslenskt hugtak í skráningarform\"/>
	      <button label=\"Á stopplista\" tooltiptext=\"Skrá valið enskt hugtak á stopplista\"/>
	      <separator/>
	      <button label=\"Skrá par sem dæmi\" tooltiptext=\"Færa innihald pars sem dæmi í skráningarform hugtaks\"/>
	    </vbox>
	  </hbox>
        </groupbox>
        <groupbox flex=\"1\">
          <caption label=\"Hugtak\"/>
          <hbox flex=\"1\">
            <vbox flex=\"1\">
              <hbox>
                <vbox flex=\"1\">
	          <label value=\"Enska\"/>
	          <textbox value=\"\" flex=\"1\"/>
	        </vbox>
	        <vbox flex=\"1\">
	          <label value=\"Íslenska\"/>
	          <textbox value=\"\" flex=\"1\"/>
	        </vbox>
	      </hbox>
	      <label value=\"Dæmi á ensku\"/>
	      <textbox multiline=\"true\" flex=\"1\" value=\"\"/>
	      <label value=\"Dæmi á íslensku\"/>
	      <textbox multiline=\"true\" flex=\"1\" value=\"\"/>
	      <hbox>
		<vbox flex=\"1\">
		  <label value=\"Rit\"/>
		  <textbox value=\"\"/>
		</vbox>
		<vbox flex=\"1\">
		  <label value=\"Skjal nr.\"/>
		  <textbox value=\"\"/>
		</vbox>
	      </hbox>
            </vbox>
            <vbox pack=\"end\">
	      <button label=\"Til skoðunar\" tooltiptext=\"Vista hugtakafærslu á vinnslulista\"/>
	      <separator/>
	      <button label=\"Skrá...\" tooltiptext=\"Skrá færslu hugtaks\"/>
            </vbox>
          </hbox>
        </groupbox>
      </vbox>
    </vbox>
  </hbox>
</window>

"
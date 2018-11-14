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
      <menu label=\"Skr�\">
        <menupopup>
          <menuitem label=\"H�tta\"/>
        </menupopup>
      </menu>
      <menu label=\"S�n\">
        <menupopup>
          <menuitem label=\"P�r\"/>
          <menuseparator/>
          <menuitem label=\"Hugt�k\"/>
          <menuitem label=\"Vinnslulisti\"/>
          <menuitem label=\"Stopplisti\"/>
        </menupopup>
      </menu>
      <menu label=\"A�ger�ir\">
        <menupopup>
          <menuitem label=\"Lesa inn p�r �r BAK skr�m\"/>
          <menuitem label=\"Handf�ra inn par\"/>
          <menuseparator/>
          <menuitem label=\"S�kja MT innflutningsskapal�n\"/>
          <menuseparator/>
          <menuitem label=\"Skr� svi�\"/>
        </menupopup>
      </menu>
    </menubar>
  </toolbox>
  <hbox flex=\"1\">
    <vbox id=\"viewSelectPaneBox\" persist=\"width\">
      <tree flex=\"1\" hidecolumnpicker=\"true\" class=\"plain\">
        <treecols>
          <treecol flex=\"1\" id=\"syn\" label=\"S�n\" primary=\"true\"/>
        </treecols>
        <treechildren flex=\"1\">
          <treeitem>
            <treerow>
              <treecell label=\"P�r\"/>
            </treerow>
          </treeitem>
          <treeseparator/>
          <treeitem>
            <treerow>
              <treecell label=\"Hugt�k\"/>
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
        <label value=\"Lesa inn p�r �r BAK skr�m:\"/>
        <html:form enctype=\"multipart/form-data\" method=\"post\" action=\"bakprocess.tcl\">
          <html:input name=\"clientfile\" type=\"file\"/>
          <html:input name=\"submit\" type=\"submit\" value=\"Hla�a inn\"/>
        </html:form>
      </hbox>
      <hbox align=\"center\">
        <hbox align=\"center\">
          <label value=\"Sj�:\" accesskey=\"s\"/>
          <menulist>
            <menupopup>
              <menuitem label=\"�ll p�r\" value=\"0\"/>
              <menuitem label=\"P�r me� upp�stungum\" value=\"0\"/>
              <menuitem label=\"P�r �n n�junga\" value=\"0\"/>
              <menuseparator/>
              <menuitem label=\"S�rsn��a...\" value=\"0\"/>
            </menupopup>
          </menulist>
        </hbox>
        <label value=\"P�r innihalda\"/>
        <textbox flex=\"5\"/>
        <button label=\"Hreinsa\" disabled=\"true\" tooltiptext=\"Hreinsa leitarskilyr�i og s�na �ll p�r\"/>
      </hbox>
      <tree flex=\"1\" class=\"plain focusring\" enableColumnDrag=\"true\">
        <treecols>
          <treecol flex=\"1\" id=\"parEnska\" label=\"Enska\" persist=\"hiddn ordinal width\"/>
          <splitter class=\"tree-splitter\"/>
          <treecol flex=\"1\" id=\"parIslenska\" label=\"�slenska\" persist=\"hidden ordinal width\"/>
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
	      <label value=\"�slenska\"/>
	      <textbox multiline=\"true\" flex=\"1\" value=\"\"/>
	    </vbox>
	    <vbox>
	      <label value=\"Hugtakaa�ger�ir\"/>
	      <button label=\"Skr� enskt\" tooltiptext=\"F�ra vali� enskt hugtak � skr�ningarform\"/>
	      <button label=\"Skr� �slenskt\" tooltiptext=\"F�ra vali� �slenskt hugtak � skr�ningarform\"/>
	      <button label=\"� stopplista\" tooltiptext=\"Skr� vali� enskt hugtak � stopplista\"/>
	      <separator/>
	      <button label=\"Skr� par sem d�mi\" tooltiptext=\"F�ra innihald pars sem d�mi � skr�ningarform hugtaks\"/>
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
	          <label value=\"�slenska\"/>
	          <textbox value=\"\" flex=\"1\"/>
	        </vbox>
	      </hbox>
	      <label value=\"D�mi � ensku\"/>
	      <textbox multiline=\"true\" flex=\"1\" value=\"\"/>
	      <label value=\"D�mi � �slensku\"/>
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
	      <button label=\"Til sko�unar\" tooltiptext=\"Vista hugtakaf�rslu � vinnslulista\"/>
	      <separator/>
	      <button label=\"Skr�...\" tooltiptext=\"Skr� f�rslu hugtaks\"/>
            </vbox>
          </hbox>
        </groupbox>
      </vbox>
    </vbox>
  </hbox>
</window>

"
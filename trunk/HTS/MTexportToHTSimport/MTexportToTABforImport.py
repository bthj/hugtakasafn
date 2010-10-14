#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
Created on 5.10.2010

@author: bthj
'''

from lxml import etree
import codecs

if __name__ == '__main__':
    dataDir = "../import/"
    exportFile = "MT-Exp-Vottad-131010-3.xml"
    
    print "Thatta export skjal: " + (dataDir + exportFile)
    tree = etree.parse(dataDir + exportFile)
    
    tabFile = exportFile.replace(".xml", ".tab")
    f = codecs.open(dataDir + tabFile, 'w', encoding='utf-8')
    
    print "Hringa yfir allar hugtakafaerslur og skrifa a TAB snidi i: " + (dataDir + tabFile)
    count = 0
    entrynumbers = []  #thad getur komid fyrir ad eitt entrynumber se tvitekid; komum i veg fyrir thad
    omittedEntrynumbers = []
    for conceptGrp in tree.iterfind("./conceptGrp"):
        
        entrynumber = ""
        lang_is = ""
        lang_en = ""
        lang_danosae = "" 
        lang_fr = ""
        lang_de = ""
        lang_la = ""
        is_samh = ""
        is_svid = ""
        is_daemi = ""
        is_skilgr = ""
        is_rit = ""
        is_efnisfl = ""
        is_adalord = ""
        is_adalord_ordfl = ""
        is_adalord_kyn = ""
        is_onnurmalfr = ""
        en_ordfl = ""
        en_skst = ""
        en_annar_rith = ""
        is_skst = ""
        is_annar_rith = ""
        is_heimild = ""
        is_aths = ""
        is_skjalnr = ""

        
        entrynumber = conceptGrp.find("concept").text
        if entrynumbers.count(entrynumber) == 0:
            entrynumbers.append(entrynumber)
    
            isLangGrp = conceptGrp.findall("./languageGrp/language[@type='IS']/..")
            for idx, val in enumerate(isLangGrp):
                isTerm = isLangGrp[idx].find("termGrp/term").text
                if isTerm is not None:
                    if idx > 0:
                        if is_annar_rith != "":
                            is_annar_rith += ";"
                        is_annar_rith += isTerm
                    else:
                        lang_is = isTerm
    
            enLangGrp = conceptGrp.findall("./languageGrp/language[@type='EN']/..")
            for idx, val in enumerate(enLangGrp):
                enTerm = enLangGrp[idx].find("termGrp/term").text
                if enTerm is not None:
                    if idx > 0:
                        if en_annar_rith != "":
                            en_annar_rith += ";"
                        en_annar_rith += enTerm
                    else:
                        lang_en = enTerm
                        
            danosaeTermGrp = conceptGrp.find("./languageGrp/language[@type='DA/NO/SÆ']/../termGrp")
            if danosaeTermGrp is not None:
                lang_danosae = danosaeTermGrp.find("term").text
                
            frTermGrp = conceptGrp.find("./languageGrp/language[@type='FR']/../termGrp")
            if frTermGrp is not None:
                lang_fr = frTermGrp.find("term").text
                
            deTermGrp = conceptGrp.find("./languageGrp/language[@type='DE']/../termGrp")
            if deTermGrp is not None:
                lang_de = deTermGrp.find("term").text
    
            laTermGrp = conceptGrp.find("./languageGrp/language[@type='LA']/../termGrp")
            if laTermGrp is not None:
                lang_la = laTermGrp.find("term").text            
                
            
            if isLangGrp is not None and len(isLangGrp) > 0:
                adalordGrp = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='aðalorð']/..")
                if adalordGrp is not None:
                    is_adalord = adalordGrp.find("descrip").text
                    if adalordGrp.find("descripGrp/descrip[@type='orðfl.']") is not None:
                        is_adalord_ordfl = adalordGrp.find("descripGrp/descrip[@type='orðfl.']").text
                    if adalordGrp.find("descripGrp/descrip[@type='kyn']") is not None:
                        is_adalord_kyn = adalordGrp.find("descripGrp/descrip[@type='kyn']").text
                else:
                    if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='orðfl.']") is not None:
                        is_adalord_ordfl = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='orðfl.']").text
                    if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='kyn']") is not None:
                        is_adalord_kyn = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='kyn']").text
                
                if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='samh.']") is not None:
                    is_samh = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='samh.']").text
                if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='svið']") is not None:
                    is_svid = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='svið']").text
                if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='dæmi']") is not None:
                    is_daemi = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='dæmi']").text
                if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='skilgr.']") is not None:
                    is_skilgr = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='skilgr.']").text
                if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='rit']") is not None:
                    is_rit = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='rit']").text
                if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='efnisfl.']") is not None:
                    is_efnisfl = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='efnisfl.']").text
                if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='heimild']") is not None:
                    is_heimild = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='heimild']").text
                if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='aths.']") is not None:
                    if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='aths.']").text is None:
                        xref = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='aths.']").find("xref")
                        if xref is not None:
                            is_aths = "<XREF>" + xref.text + "</XREF>" + xref.tail
                    else:
                        is_aths = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='aths.']").text
                        xref = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='aths.']").find("xref")
                        if xref is not None:
                            is_aths += "<XREF>" + xref.text + "</XREF>"
                            if xref.tail is not None:
                                is_aths += xref.tail
                if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='skjal nr.']") is not None:
                    is_skjalnr = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='skjal nr.']").text
                
                    
            if enLangGrp is not None and len(enLangGrp) > 0:
                if enLangGrp[0].find("termGrp/descripGrp/descrip[@type='orðfl.']") is not None:
                    en_ordfl = enLangGrp[0].find("termGrp/descripGrp/descrip[@type='orðfl.']").text
    
            isSkstGrp = conceptGrp.find("./languageGrp/language[@type='IS skst']/..")
            if isSkstGrp is not None:
                is_skst = isSkstGrp.find("termGrp/term").text
            enSkstGrp = conceptGrp.find("./languageGrp/language[@type='EN skst']/..")
            if enSkstGrp is not None:
                en_skst = enSkstGrp.find("termGrp/term").text
    
    
            lang_is = lang_is.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            lang_en = lang_en.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            lang_danosae = lang_danosae.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            lang_fr = lang_fr.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            lang_de = lang_de.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            lang_la = lang_la.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_samh = is_samh.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_svid = is_svid.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_daemi = is_daemi.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_skilgr = is_skilgr.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_rit = is_rit.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_efnisfl = is_efnisfl.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_adalord = is_adalord.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_adalord_ordfl = is_adalord_ordfl.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_adalord_kyn = is_adalord_kyn.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_onnurmalfr = is_onnurmalfr.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            en_ordfl = en_ordfl.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            en_skst = en_skst.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            en_annar_rith = en_annar_rith.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_skst = is_skst.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_annar_rith = is_annar_rith.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_heimild = is_heimild.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_aths = is_aths.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            is_skjalnr = is_skjalnr.replace("\n", "<br/>").replace("'","''").replace("\t", "")
            
            
            tabEntry = [entrynumber,lang_is,lang_en,lang_danosae,lang_fr,lang_de,lang_la,is_samh,is_svid,is_daemi,is_skilgr,is_rit,is_efnisfl,is_adalord,is_adalord_ordfl,is_adalord_kyn,is_onnurmalfr,en_ordfl,en_skst,en_annar_rith,is_skst,is_annar_rith,is_heimild,is_aths,is_skjalnr]
            tabLine = "\t".join(tabEntry) + "\n"

            tabLineLATINcompatible = tabLine.encode("utf_16_le", "ignore").decode("utf_16_le", "ignore")
            tabLineLATINcompatible = tabLineLATINcompatible.encode("latin-1","ignore")
            tabLineLATINcompatible = tabLineLATINcompatible.decode("latin-1").encode("utf-8")
            
            f.write(tabLineLATINcompatible)
            
            count += 1
            if count%1000 == 0:
                print str(count) + " faerslur skrifadar..."
        
        else:
            omittedEntrynumbers.append(entrynumber)

    f.write("\\.\n")
    f.close()
    
    print "Skrifadi ut " + str(count) + " faerslur.\n"
    omittedSet = set(omittedEntrynumbers)
    omittedUniqueList = list(omittedSet)
    print "Tvitekin entrynumber sleppt:  " + ", ".join(omittedUniqueList)

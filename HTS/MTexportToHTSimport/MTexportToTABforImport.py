#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
Created on 5.10.2010

@author: bthj
'''

from lxml import etree
import codecs, sys, os, glob


if __name__ == '__main__':


    # if len(sys.argv) < 2:
    #     print "Engin export skra tiltekin"
    # else:
        # thisPath = os.path.split( sys.argv[0] )[0]
        # dataDir = thisPath + "/../import/"

        dataDir = "../import/"
        globPathName = "../import/*.xml"

        tabFile = "exportCombined.tab"
        f = codecs.open(dataDir + tabFile, 'w', encoding='utf-8')
        # let's make sure the file is empty before we begin
        f.truncate()

        # print "globPathName: " + globPathName
        count = 0
        entrynumbers = []  #thad getur komid fyrir ad eitt entrynumber se tvitekid; komum i veg fyrir thad
        omittedEntrynumbers = []
        entryNumberPadding = 0  # incremented by a large amount by the end of each loop, to ensure entry number uniqueness between databases
        for oneExportFile in glob.glob( globPathName ):
            print "One export file: " + oneExportFile

            # exportFile = sys.argv[1]


            print "Thatta export skjal: " + oneExportFile
            # tree = etree.parse((dataDir + exportFile), parser=etree.XMLParser(strip_cdata=False, encoding='utf-16le'))
            tree = etree.parse(dataDir + oneExportFile)

            print(tree.docinfo.encoding)

            # tabFile = exportFile.replace(".xml", ".tab")
            # f = codecs.open(dataDir + tabFile, 'w', encoding='utf-8')

            print "Hringa yfir allar hugtakafaerslur og skrifa a TAB snidi i: " + (dataDir + tabFile)
            # count = 0
            # entrynumbers = []  #thad getur komid fyrir ad eitt entrynumber se tvitekid; komum i veg fyrir thad
            # omittedEntrynumbers = []
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
                en_daemi = ""
                en_samh= ""
                en_skilgr = ""
                en_aths = ""
                en_rit = ""

                originalEntryNumber = conceptGrp.find("concept").text
                paddedEntryNumber = int(originalEntryNumber) + entryNumberPadding
                entrynumber = str(paddedEntryNumber)

                # print "Vinn faerslu #" + entrynumber

                if entrynumbers.count(entrynumber) == 0:
                    entrynumbers.append(entrynumber)

                    isLangGrp = conceptGrp.findall("./languageGrp/language[@type='IS']/..")
                    for idx, val in enumerate(isLangGrp):
                        isTermGrp = isLangGrp[idx].findall("termGrp")
                        for grpIdx, grpVal in enumerate(isTermGrp):
                            isTerm = isTermGrp[grpIdx].find("term").text
                            if isTerm is not None:
                                if idx+grpIdx > 0:
                                    if is_annar_rith != "":
                                        is_annar_rith += ";"
                                    is_annar_rith += isTerm
                                else:
                                    lang_is = isTerm

                    enLangGrp = conceptGrp.findall("./languageGrp/language[@type='EN']/..")
                    for idx, val in enumerate(enLangGrp):
                        enTermGrp = enLangGrp[idx].findall("termGrp")
                        for grpIdx, grpVal in enumerate(enTermGrp):
                            enTerm = enTermGrp[grpIdx].find("term").text
                            if enTerm is not None:
                                if idx+grpIdx > 0:
                                    if en_annar_rith != "":
                                        en_annar_rith += ";"
                                    en_annar_rith += enTerm
                                else:
                                    lang_en = enTerm

                    danosaeTermGrp = conceptGrp.xpath("./languageGrp/language[contains(@type,'DA/NO/')]/../termGrp")
                    if len(danosaeTermGrp) > 0:
                        lang_danosae = danosaeTermGrp[0].find("term").text

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
                        adalordGrp = isLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='aðalorð']/..")
                        if adalordGrp is not None:
                            is_adalord = adalordGrp.find("descrip").text
                            if adalordGrp.find(u"descripGrp/descrip[@type='orðfl.']") is not None:
                                is_adalord_ordfl = adalordGrp.find(u"descripGrp/descrip[@type='orðfl.']").text
                            if adalordGrp.find("descripGrp/descrip[@type='kyn']") is not None:
                                is_adalord_kyn = adalordGrp.find("descripGrp/descrip[@type='kyn']").text
                        if not is_adalord_ordfl:
                            if isLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='orðfl.']") is not None:
                                is_adalord_ordfl = isLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='orðfl.']").text
                        if not is_adalord_kyn:
                            if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='kyn']") is not None:
                                is_adalord_kyn = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='kyn']").text

                        if isLangGrp[0].find("termGrp/descripGrp/descrip[@type='samh.']") is not None:
                            is_samh = isLangGrp[0].find("termGrp/descripGrp/descrip[@type='samh.']").text
                        if isLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='svið']") is not None:
                            is_svid = isLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='svið']").text
                        if isLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='önnur málfr.']") is not None:
                            is_onnurmalfr = isLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='önnur málfr.']").text
                        if isLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='dæmi']") is not None:
                            is_daemi = isLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='dæmi']").text
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
                        if enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='orðfl.']") is not None:
                            en_ordfl = enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='orðfl.']").text
                        if enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='dæmi']") is not None:
                            en_daemi = enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='dæmi']").text
                        if enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='samh.']") is not None:
                            en_samh = enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='samh.']").text
                        if enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='skilgr.']") is not None:
                            en_skilgr = enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='skilgr.']").text
                        if enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='aths.']") is not None:
                            en_aths = enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='aths.']").text
                        if enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='rit']") is not None:
                            en_rit = enLangGrp[0].find(u"termGrp/descripGrp/descrip[@type='rit']").text


                    isSkstGrp = conceptGrp.find("./languageGrp/language[@type='c']/..")
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
                    en_daemi = en_daemi.replace("\n", "<br/>").replace("'","''").replace("\t", "")
                    en_samh = en_samh.replace("\n", "<br/>").replace("'","''").replace("\t", "")
                    en_skilgr = en_skilgr.replace("\n", "<br/>").replace("'","''").replace("\t", "")
                    en_aths = en_aths.replace("\n", "<br/>").replace("'","''").replace("\t", "")
                    en_rit = en_rit.replace("\n", "<br/>").replace("'","''").replace("\t", "")


                    tabEntry = [entrynumber,lang_is,lang_en,lang_danosae,lang_fr,lang_de,lang_la,is_samh,is_svid,is_daemi,is_skilgr,is_rit,is_efnisfl,is_adalord,is_adalord_ordfl,is_adalord_kyn,is_onnurmalfr,en_ordfl,en_skst,en_annar_rith,is_skst,is_annar_rith,is_heimild,is_aths,is_skjalnr,en_daemi,en_samh,en_skilgr,en_aths,en_rit]
                    tabLine = "\t".join(tabEntry) + "\n"

                    tabLineLATINcompatible = tabLine.encode("utf_16_le", "ignore").decode("utf_16_le", "ignore")
                    tabLineLATINcompatible = tabLineLATINcompatible.encode("latin-1","ignore")
                    #tabLineLATINcompatible = tabLineLATINcompatible.decode("latin-1").encode("utf-8")
                    tabLineLATINcompatible = tabLineLATINcompatible.decode("latin-1")

                    f.write(tabLineLATINcompatible)

                    count += 1
                    if count%1000 == 0:
                        print str(count) + " faerslur skrifadar..."
                        print "entrynumber: " + entrynumber

                else:
                    omittedEntrynumbers.append(entrynumber)

            entryNumberPadding += 1000000 # a million will be added to all entry numbers in the next iteration

        f.write("\\.\n")
        f.close()

        print "Skrifadi ut " + str(count) + " faerslur.\n"
        omittedSet = set(omittedEntrynumbers)
        omittedUniqueList = list(omittedSet)
        print "Tvitekin entrynumber sleppt:  " + ", ".join(omittedUniqueList)

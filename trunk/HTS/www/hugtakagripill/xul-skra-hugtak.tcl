# bangsi@bthj.is 2005-05-10
# Setur stakorð á stopplista og eyðir tillögum um það orð í öllum pörum

set_the_usual_form_variables

set db [ns_db gethandle]
set sql [encoding convertfrom utf-8 "insert into hugtakagripill_hugtok
               (id, dags, enska, islenska, daemi_enska, daemi_islenska, rit, skjal_nr, samheiti, svid, heimild, athugasemd, adalord, ordflokkur, kyn, onnur_malfraedi, skammstofun, skilgreining, nafn_ordtaka, gilding, enska_skammstofun, islenska_annar_rith, enska_annar_rith, da_no_sae, de, fr, la)
               values
               (nextval('hugtakagripill_hugtok_id'), CURRENT_TIMESTAMP, '[string trim $QQenska]', '[string trim $QQislenska]', '$QQdaemienska', '$QQdaemiislenska', '$QQrit', '$QQskjal', '$QQsamheiti', '$QQsvid', '$QQheimild', '$QQathugasemd', '$QQadalord', '$QQordflokkur', '$QQkyn', '$QQonnurmalfraedi', '$QQskammstofun', '$QQskilgreining', '$QQnafnordtaka', '$QQgilding', '$QQenskammstofun', '$QQisannarrithattur', '$QQenannarrithattur', '$QQdanosae', '$QQde', '$QQfr', '$QQla')
               "]
ns_db dml $db $sql
# eyða öllum tillögum
ns_db dml $db "delete from hugtakagripill_tillogur_stakord where ord = '$QQenska'"

ns_return 200 "text/plain" "success"

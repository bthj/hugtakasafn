# bangsi@bthj.is 2005-10-06
# Uppfærir færslu hugtaks

set_the_usual_form_variables

set db [ns_db gethandle]

set sql [encoding convertfrom utf-8 "update hugtakagripill_hugtok set
		  dags = CURRENT_TIMESTAMP,
		  enska = '[string trim $QQenska]',
		  islenska = '[string trim $QQislenska]',
		  daemi_enska = '$QQdaemienska',
		  daemi_islenska = '$QQdaemiislenska',
		  rit = '$QQrit',
		  skjal_nr = '$QQskjal',
		  samheiti = '$QQsamheiti',
		  svid = '$QQsvid',
		  heimild = '$QQheimild',
		  athugasemd = '$QQathugasemd',
		  adalord = '$QQadalord',
		  ordflokkur = '$QQordflokkur',
		  kyn = '$QQkyn',
		  onnur_malfraedi = '$QQonnurmalfraedi',
		  skammstofun = '$QQskammstofun',
		  skilgreining = '$QQskilgreining',
		  nafn_ordtaka = '$QQnafnordtaka',
		  gilding = '$QQgilding',
		  enska_skammstofun = '$QQenskammstofun',
		  islenska_annar_rith = '$QQisannarrithattur',
		  enska_annar_rith = '$QQenannarrithattur',
		  da_no_sae = '$QQdanosae',
		  de = '$QQde',
		  fr = '$QQfr',
		  la = '$QQla'
		where id = '$id'"]
ns_db dml $db $sql
ns_return 200 "text/plain" "success"
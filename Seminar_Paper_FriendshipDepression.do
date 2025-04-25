
**  DO-File Freundschaft/Depression/Anna Sophie Oevermann
 **Globals anlegen 			                                              
********************************************************************************

global root "." /* Do-File uses sensitive data from the Survey of Health, Ageing and Retirement in Europe (SHARE), which can't be shared without proper authorization. */

global data_folder "${root}/Data"
global output_folder "${root}/Data_output"
global do_folder "${root}/Do-File"

global easy "${data_folder}"   
global wave4 "${data_folder}" 
global easywave4 "${output_folder}/easywave4.dta"

********************************************************************************
**Variable aus Welle 4 in den easySHARE transferieren

	* 	Open wave4 and keep wave4 variables
	
	*use 		${wave4}/sharew4_rel8-0-0_gv_networks.dta, clear
	*gen 		wave = 4
	*keep 		mergeid wave friendnet friend_contact very_close
	*save 		${output_folder}/wave4_transformed.dta, replace
	
	* merge easydata and wave4 
	
	*use         ${output_folder}/wave4_transformed.dta, clear 
	*merge       1:1 mergeid wave using ${easy}/easySHARE_rel8-0-0.dta
	*drop 		if wave!=4
	*save        ${output_folder}/easywave4.dta, replace
	
	**Open easywave4
    use        ${easywave4}, clear
	
*******************************************************************************
	
	***missing values der Variable eurod entfernen
	mvdecode eurod, mv (-15 -9 -1 -2)

	***Variable umbenennen-sprechender Variablenname
	rename eurod Depression
	
	***Variable Depression neu labeln
	label variable Depression "Depression"
	
******************************************************************************
	
	***missing values der Variable friendnet entfernen
	mvdecode friendnet, mv(-15 -9 -1 -2) 
	
	***Variable umbenennen - sprechender Variablenname
	rename friendnet AnzahlFreundschaften
	
	***Variable AnzahlFreundschaften neu labeln
	label variable AnzahlFreundschaften "Anzahl der Freund*innen im sozialen Netzwerk"
	
	***Variable AnzahlFreundschaften neu labeln - Ausprägungen 0-7 benennen
	label define AnzahlFreundschaften 0 "keine Freund*in" 1 "1 Freund*in" 2 "2 Freund*innen" 3 "3 Freund*innen" 4 "4 Freund*innen" 5 "5 Freund*innen" 6 "6 Freund*innen" 7 "7 Freund*innen"
	
******************************************************************************
	
	***missing values der Variable very_close entfernen
	mvdecode very_close, mv (-9 -1 -2)
	
	***Variable very_close recodieren, sodass 4 anstatt 7 Ausprägungen von emotionaler Verbundenheit zu Freund*innen existieren, neue Variable generieren
	recode very_close (0/0=0) (1/2=1) (3/4=2) (5/7=3), gen(selbsteingeschätzteVerbundenheit)
	
	***Variable selbsteingeschätzteVerbundenheit neu labeln
	label variable selbsteingeschätzteVerbundenheit "Einschätzung der Verbundenheit von wenig zu stark"

	***Variable selbsteingeschätzteVerbundenheit neu labeln, sprechende Ausprägungen: keine Verbundenheit, geringe Verbundenheit, mäßige Verbundenheit, hohe Verbundenheit 
	label define selbsteingeschätzteVerbundenheit 0 "keine Verbundenheit" 1 "geringe Verbundenheit" 2 "mittlere Verbundenheit" 3 "hohe Verbundenheit"

******************************************************************************

   ***missing values der Variable friend_contact entfernen
	mvdecode friend_contact, mv(-9 -1 -2)
	
	***Variable friend_contact recodieren, sodass nur 7 Ausprägungen existieren, neue Variable generieren
	recode friend_contact (1/1.857143=1) (2/2.857143=2) (3/3.84=3) (4/4.84=4) (5/5.8=5) (6=6) (7=7),gen(DurchschnittKontakt)

	//Jetzt existieren die Ausprägungen, 1 "Daily contact", 2 "Several times/week", 3 "1x/week", 4 "Every 2 weeks",  5 "Once a month", 6 "Less than once a month", 7 "Never"
	
	***Variable DurchschnittKontakt recodieren, sodass nur 3 Ausprägungen existieren - (0/3) von wenig zu viel Kontakt
	recode DurchschnittKontakt (1/3=2) (4/5=1) (6/7=0)
	//Ausprägung 0 Nie, 1 mindestens 1xmonatlich, 2 mindestens 1xwöchentlich
	
	***Variable DurchschnittKontakt neu labeln, sprechende Ausprägungen 
	label define DurchschnittKontakt 0 "Nie" 1 "mindestens 1x monatlich" 2 "mindestens 1x wöchentlich" 
	
	***Variable DurchschnittKontakt neu labeln
	label variable DurchschnittKontakt "Durchschnittlicher monatlicher Kontakt zu Freund*innen (von kein bis viel Kontakt)"
	
******************************************************************************	
	***sum der AV & UV's: Tabelle der Anzahl der Beobachtungen (N), Mittelwert (Mean), Standardabweichung (SD), Minimum (Minimum), Maximum (Maximum) - Deskriptive Statistik
	sum Depression AnzahlFreundschaften selbsteingeschätzteVerbundenheit DurchschnittKontakt
	
******************************************************************************
	***missings der Kontrollvariablen entfernen: 
	mvdecode age, mv(-15)
	mvdecode sphus, mv(-15 -12)
	mvdecode chronic_mod, mv(-15 -12)
	
	***Änderung der Namen der KV'save
	rename female Geschlecht
	rename age Alter
	rename sphus selbsteingeschätzteGesundheit
	rename chronic_mod AnzahlKrankheiten
*******************************************************************************
    ***Regressionensmodell 1 durchführen
	regress Depression AnzahlFreundschaften selbsteingeschätzteVerbundenheit
	
	***Regressionsmodell 2 durchführen
	regress Depression AnzahlFreundschaften selbsteingeschätzteVerbundenheit selbsteingeschätzteGesundheit AnzahlKrankheiten
	
********************************************************************************	
	
	
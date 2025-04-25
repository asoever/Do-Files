* Do - freundschaftliche Unterstüzung-Depression-Einsamkeit

use "/Users/PATH/TO/DATAFILE.dta" /* Do-File uses sensitive data from the German Ageing Survey (DEAS), which can't be shared without proper authorization. */

* Mögliche Freundschaftsvariablen rekodieren 

******** Emotionale Unterstützung - UV1: Rat von Freunden ****
* Kopien der relevanten Variablen erstellen
clonevar RatF_1 = ic701_1
clonevar RatF_2 = ic701_2
clonevar RatF_3 = ic701_3
clonevar RatF_4 = ic701_4
clonevar RatF_5 = ic701_5

* Rekodieren ic701_1_K bis ic701_5_K
recode RatF_1 (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 301 302 303 306 307 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 = 0) (501 502 503 504 505 506 = 1)
recode RatF_2 (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 209 301 302 303 304 305 306 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 905 = 0) (501 502 503 504 505 506 = 1) (995 =.) 
recode RatF_3 (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 207 209 301 302 303 312 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 = 0) (501 502 503 504 505 506 = 1) (995 = .) 
recode RatF_4 (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 301 302 307 401 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 = 0) (501 502 503 504 505 506 = 1) (995 = .) 
recode RatF_5 (102 103 104 105 106 107 108 111 112 201 202 203 204 205 208 301 302 401 402 403 404 405 406 451 452 601 602 603 801 901 902 904 905 = 0) (501 502 503 504 505 506 = 1) (995 = .)
/* (995 = .) -> Abwesenheit weiterer Personen, die um Rat gefragt werden können: Missing value generieren*/

/* Dem Codebook der Variablen eine Notiz hinzufügen, dass missings unter "." zukünftig interpretiert werden können.
 (Kann mit dem Befehl codebook varname, notes abgerufen werden) */
notes RatF_2: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, die um Rat gefragt werden können
notes RatF_3: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, die um Rat gefragt werden können
notes RatF_4: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, die um Rat gefragt werden können
notes RatF_5: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, die um Rat gefragt werden können

* Ausprägungen der Variablen labeln
*1. Wertelabel definieren
label define beziehungsart 0 "Familie und Andere" 1 "Freunde" 
*2. Ausprägungen labeln 
label values RatF_1 beziehungsart
label values RatF_2 beziehungsart
label values RatF_3 beziehungsart
label values RatF_4 beziehungsart
label values RatF_5 beziehungsart

* Neue Variable aus Zeilensumme generieren; 
egen Rat_Freunde = rowtotal(RatF_1 RatF_2 RatF_3 RatF_4 RatF_5) 
/* Variable besitzt 5 Ausprägungen
0= Familie und Andere als Ratgeber*innen genannt 
1= 1 Freund*in als Ratgeber*in genannt haben
2= 2 genannte Freund*innen als Ratgeber*innen 
3= 3 genannte Freund*innen als Ratgeber*innen 
4= 4 genannte Freund*innen als Ratgeber*innen 
5= 5 genannte Freund*innen als Ratgeber*innen */

* Beschreibung der Variablen erstellen
label variable Rat_Freunde "Anzahl an Freund*innen, die um Rat gefragt werden können"

* Ausprägungen der Variablen labeln
*1. Wertelabel definieren
label define anzahlfreunde1 0 "0 Familie und Andere" 1 "1 Freund*in" 2 "2 Freunde" 3 "3 Freunde" 4 "4 Freunde" 5 "5 Freunde"
*2. Ausprägungen labeln 
label values Rat_Freunde anzahlfreunde1

**** Dichotome Variable erstellen
* Kopie erstellen 
clonevar dRat_Freunde = Rat_Freunde
* Rekodieren
recode dRat_Freunde (0 = 0) (1/5 = 1)
* Beschreibung erstellen 
label variable dRat_Freunde "Verfügbarkeit von Freund*innen für Ratschläge"
* Ausprägungen der Variable labeln 
*1. Wertelabel definieren 
label define Freunde 0 "Nein (Keine Freunde genannt)" 1 "Ja (mind. 1 Freund*in genannt)"
*2. Ausprägungen labeln 
label values dRat_Freunde Freunde

********Emotionale Unterstützung - UV2: Trost und Aufmunterung von Freund*innen********
*Kopien der relevanten Variablen erstellen
clonevar TrostF1 = ic705_1
clonevar TrostF2 = ic705_2
clonevar TrostF3 = ic705_3
clonevar TrostF4 = ic705_4
clonevar TrostF5 = ic705_5

*Rekodieren ic705_1_K bis ic705_5_K (Personen, die um Trost/Aufmunterung gefragt werden kann)
recode TrostF1 (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 209 301 302 303 305 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 = 0) (501 502 503 504 505 506 = 1)
recode TrostF2 (102 103 104 106 107 108 111 112 120 201 202 203 204 205 206 207 209 301 302 303 304 305 306 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 = 0) (501 502 503 504 505 506 = 1) (995 = .)  
recode TrostF3 (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 209 301 302 302 303 306 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 = 0) (501 502 503 504 505 506 = 1) (995 = .) 
recode TrostF4 (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 301 302 303 304 401 402 403 404 405 406 407 451 452 601 602 603 701 801 901 903 = 0) (501 502 503 504 505 506 = 1) (995 = .) 
recode TrostF5 (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 209 301 302 303 304 305 401 403 404 405 406 407 451 452 601 602 603 701 801 901 902 904 = 0) (501 502 503 504 505 506 =1) (995 = .)

*Dem Codebook der Variablen eine Notiz hinzufügen, dass missings unter "." zukünftig interpretiert werden können. Das kann mit dem Befehl codebook varname, notes abgerufen werden
notes TrostF2: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, die nach Trost/Aufmunterung gefragt werden kann
notes TrostF3: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, die nach Trost/Aufmunterung gefragt werden kann
notes TrostF4: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, die nach Trost/Aufmunterung gefragt werden kann
notes TrostF5: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, die nach Trost/Aufmunterung gefragt werden kann

*Ausprägungen der Variablen definieren
label values TrostF1 beziehungsart
label values TrostF2 beziehungsart
label values TrostF3 beziehungsart
label values TrostF4 beziehungsart
label values TrostF5 beziehungsart

*Neue Variable generieren
egen Trost_Freunde = rowtotal(TrostF1 TrostF2 TrostF3 TrostF4 TrostF5 ) 
/*Variable besitzt 5 Ausprägungen; 0=Personen, die Familie und Andere genannt haben, 1=Personen, die 1 Freund*in genannt haben, 2= 2 genannte Freund*innen, 3= 3 genannte Freund*innen usw.*/

*Beschreibung der Variablen erstellen
label variable Trost_Freunde "Anzahl an Freund*innen, die um Trost/Aufmunterung gefragt werden kann"

*Ausprägungen der Variable definieren
label values Trost_Freunde anzahlfreunde1 

********Instrumentelle Unterstützung - UV1: Hilfe im Haushalt von Freunden geleistet********
*Kopien der relevanten Variablen erstellen
clonevar ic709_1_K = ic709_1
clonevar ic709_2_K = ic709_2
clonevar ic709_3_K = ic709_3
clonevar ic709_4_K = ic709_4
clonevar ic709_5_K = ic709_5

*Rekodieren ic709_1_K bis ic709_5_K (Personen, denen die befragte Person im letzten Jahr im Haushalt geholfen hat)
recode ic709_1_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 209 301 302 303 304 308 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 905 = 0) (501 502 503 504 505 506 = 1)

recode ic709_2_K (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 209 301 302 303 304 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 = 0) (501 502 503 504 505 506 = 1) (995 = .)/*995 -> No further persons in SN were helped in their household, diese Ausprägung als missing value umkodieren*/

recode ic709_3_K (101 102 103 104 105 106 107 108 111 112 201 202 203 204 205 301 302 303 305 312 401 402 403 404 406 407 451 452 601 602 603 701 801 901 902 903 = 0) (501 502 503 504 505 506 = 1) (995 = .)/*995 -> No further persons in SN were helped in their household, diese Ausprägung als missing value umkodieren*/

recode ic709_4_K (102 103 104 105 106 107 108 111 112 201 202 203 204 303 311 314 402 405 406 451 452 601 602 603 701 801 901 904 = 0) (501 502 503 504 505 506 = 1) (995 = .)/*995 -> No further persons in SN were helped in their household, diese Ausprägung als missing value umkodieren*/

recode ic709_5_K (103 105 107 108 111 201 202 203 204 304 312 451 452 601 602 603 902 = 0) (501 502 503 504 505 506 = 1) (995 = .)/*995 -> No further persons in SN were helped in their household, diese Ausprägung als missing value umkodieren*/

*Dem Codebook der Variablen eine Notiz hinzufügen, dass missings unter "." zukünftig interpretiert werden können. Das kann mit dem Befehl codebook varname, notes abgerufen werden
notes ic709_2_K: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, welchen die befragte Person im Haushalt geholfen hat
notes ic709_3_K: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, welchen die befragte Person im Haushalt geholfen hat
notes ic709_4_K: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, welchen die befragte Person im Haushalt geholfen hat
notes ic709_5_K: Fehlende Werte unter . resultieren aus keinen weiteren Personen im SN, welchen die befragte Person im Haushalt geholfen hat

*Variablennamen ändern
rename ic709_1_K HilfeG_SN_1 
rename ic709_2_K HilfeG_SN_2
rename ic709_3_K HilfeG_SN_3
rename ic709_4_K HilfeG_SN_4
rename ic709_5_K HilfeG_SN_5

*Ausprägungen der Variablen definieren
label values HilfeG_SN_1 beziehungsart
label values HilfeG_SN_2 beziehungsart
label values HilfeG_SN_3 beziehungsart
label values HilfeG_SN_4 beziehungsart
label values HilfeG_SN_5 beziehungsart

*Neue Variable generieren
egen HilfeG_SN = rowtotal(HilfeG_SN_1 HilfeG_SN_2 HilfeG_SN_3 HilfeG_SN_4 HilfeG_SN_5) /*Variable besitzt 5 Ausprägungen; 0=Personen, die Familie und Andere genannt haben, 1=Personen, die 1 Freund*in genannt haben, 2= 2 genannte Freund*innen, 3= 3 genannte Freund*innen usw.*/

*Beschreibung der Variablen erstellen
label variable HilfeG_SN "Anzahl der Freund*innen im SN, denen die befragte Person im letzten Jahr im Haushalt geholfen hat"

*Ausprägungen der Variable definieren
label values HilfeG_SN anzahlfreunde1 

********Instrumentelle Unterstützung - UV2: Hilfe im Haushalt von Freund*innen erhalten********
*Kopien der relevanten Variablen erstellen
clonevar ic711_1_K = ic711_1
clonevar ic711_2_K = ic711_2
clonevar ic711_3_K = ic711_3
clonevar ic711_4_K = ic711_4
clonevar ic711_5_K = ic711_5

*Rekodieren ic711_1_K bis ic711_5_K (Personen, die die befragte Person im letzten Jahr im Haushalt unterstützt haben)
recode ic711_1_K (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 301 302 303 304 308 314 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 = 0) (501 502 503 504 505 506 =1)

recode ic711_2_K (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 209 301 302 303 304 305 306 308 311 312 401 403 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 905 = 0) (501 502 503 504 505 506 = 1) (995 = .)/*995 -> No further persons helped the respondent in household, diese Ausprägung als missing value umkodieren*/

recode ic711_3_K (103 104 105 106 107 108 111 112 201 202 203 204 205 206 301 302 303 304 306 307 312 402 403 405 406 407 451 452 601 602 603 702 801 901 902 903 = 0) (501 502 503 504 505 506 = 1) (995 = .) /*995 -> No further persons helped the respondent in household, diese Ausprägung als missing value umkodieren*/

recode ic711_4_K (107 111 112 201 202 301 405 602 702 901 904 = 0) (501 502 = 1) (995 = .)/*995 -> No further persons helped the respondent in household, diese Ausprägung als missing value umkodieren*/

recode ic711_5_K (201 202 302 452 = 0) (995 = .)/*995 -> No further persons helped the respondent in household, diese Ausprägung als missing value umkodieren*/

*Dem Codebook der Variablen eine Notiz hinzufügen, dass missings unter "." zukünftig interpretiert werden können. Das kann mit dem Befehl codebook varname, notes abgerufen werden
notes ic711_2_K: Fehlende Werte unter . resultieren daraus, dass keine weiteren Personen im sozialen Netzwerk die befragte Person im Haushalt unterstützt haben
notes ic711_3_K: Fehlende Werte unter . resultieren daraus, dass keine weiteren Personen im sozialen Netzwerk die befragte Person im Haushalt unterstützt haben
notes ic711_4_K: Fehlende Werte unter . resultieren daraus, dass keine weiteren Personen im sozialen Netzwerk die befragte Person im Haushalt unterstützt haben
notes ic711_5_K: Fehlende Werte unter . resultieren daraus, dass keine weiteren Personen im sozialen Netzwerk die befragte Person im Haushalt unterstützt haben

*Variablennamen ändern
rename ic711_1_K HilfeE_SN_1 
rename ic711_2_K HilfeE_SN_2
rename ic711_3_K HilfeE_SN_3
rename ic711_4_K HilfeE_SN_4
rename ic711_5_K HilfeE_SN_5

*Ausprägungen der Variablen definieren
label values HilfeE_SN_1 beziehungsart
label values HilfeE_SN_2 beziehungsart
label values HilfeE_SN_3 beziehungsart
label values HilfeE_SN_4 beziehungsart
label values HilfeE_SN_5 beziehungsart

*Neue Variable generieren
egen HilfeE_SN = rowtotal(HilfeE_SN_1 HilfeE_SN_2 HilfeE_SN_3 HilfeE_SN_4 HilfeE_SN_5) /*Variable besitzt 5 Ausprägungen; 0=Personen, die Familie und Andere genannt haben, 1=Personen, die 1 Freund*in genannt haben, 2= 2 genannte Freund*innen, 3= 3 genannte Freund*innen usw.*/

*Beschreibung der Variablen erstellen
label variable HilfeE_SN "Anzahl der Freund*innen im SN, die der befragten Person im letzten Jahr im Haushalt geholfen haben"

*Ausprägungen der Variable definieren
label define anzahlfreunde2 0 "0 Familie und Andere" 1 "1 Freund*in" 2 "2 Freunde" 3 "3 Freunde" /*Wertelabel anzahlfreunde2 erstellen*/
label values HilfeE_SN anzahlfreunde2 /*der Variablen das label zuschreiben*/

********Finanzielle Unterstützung - UV1: Finanzielle Unterstützung für Freund*innen geleistet********
*Kopien der relevanten Variablen erstellen
clonevar ic800a1_K = ic800a1
clonevar ic800a2_K = ic800a2
clonevar ic800a3_K = ic800a3
clonevar ic800a4_K = ic800a4

*Rekodieren ic800a1_K bis ic800a4_K (Personen, die die befragte Person im letzten Jahr finanziell unterstützt hat)
recode ic800a1_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 209 301 302 303 304 305 306 307 308 309 311 313 315 316 401 402 403 404 405 406 407 451 452 601 602 603 701 702 801 901 902 903 904 905= 0) (501 502 503 504 505 506 = 1)

recode ic800a2_K (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 209 301 302 303 304 305 306 307 308 311 312 316 321 404 405 406 407 451 452 602 603 702 801 901 902 903 904 = 0) (501 502 503 504 506 = 1) (995 = .) /*995 -> Keine weiteren SN-Personen wurden durch befragte Person finanziell unterstützt (12 Monate), diese Ausprägung als missing value umkodieren*/

recode ic800a3_K (102 103 104 106 107 108 111 112 120 201 202 203 204 205 206 209 301 302 303 304 305 306 307 308 311 313 402 405 406 407 451 452 801 901 902 903 905 = 0) (501 502 503 504 505 506 = 1) (995 = .)/*995 -> Keine weiteren SN-Personen wurden durch befragte Person finanziell unterstützt (12 Monate), diese Ausprägung als missing value umkodieren*/

recode ic800a4_K (102 103 104 105 106 107 108 112 201 202 203 204 301 302 303 304 305 306 307 308 314 403 405 406 407 451 452 702 901 902 904 = 0) (501 502 503 504 506 = 1) (995 = .)/*995 -> Keine weiteren SN-Personen wurden durch befragte Person finanziell unterstützt (12 Monate), diese Ausprägung als missing value umkodieren*/

*Dem Codebook der Variablen eine Notiz hinzufügen, dass missings unter "." zukünftig interpretiert werden können. Das kann mit dem Befehl codebook varname, notes abgerufen werden
notes ic800a2_K: Fehlende Werte unter . resultieren daraus, dass keine weiteren Personen im SN der befragten Person durch diese in den letzten 12 Monaten finanziell unterstützt wurden
notes ic800a3_K: Fehlende Werte unter . resultieren daraus, dass keine weiteren Personen im SN der befragten Person durch diese in den letzten 12 Monaten finanziell unterstützt wurden
notes ic800a4_K: Fehlende Werte unter . resultieren daraus, dass keine weiteren Personen im SN der befragten Person durch diese in den letzten 12 Monaten finanziell unterstützt wurden

*Variablennamen ändern
rename ic800a1_K FinG_SN_1
rename ic800a2_K FinG_SN_2
rename ic800a3_K FinG_SN_3
rename ic800a4_K FinG_SN_4

*Ausprägungen der Variablen definieren
label values FinG_SN_1 beziehungsart
label values FinG_SN_2 beziehungsart
label values FinG_SN_3 beziehungsart
label values FinG_SN_4 beziehungsart

*Beschreibung der Variablen erstellen
label variable FinG_SN_1 "Empfänger finanzieller Unterstützung durch befragte Person (12 Monate)"
label variable FinG_SN_2 "Empfänger finanzieller Unterstützung durch befragte Person (12 Monate)"
label variable FinG_SN_3 "Empfänger finanzieller Unterstützung durch befragte Person (12 Monate)"
label variable FinG_SN_4 "Empfänger finanzieller Unterstützung durch befragte Person (12 Monate)"

*Neue Variable generieren
egen FinG_SN = rowtotal(FinG_SN_1 FinG_SN_2 FinG_SN_3 FinG_SN_4) /*Variable besitzt 5 Ausprägungen; 0=Personen, die Familie und Andere genannt haben, 1=Personen, die 1 Freund*in genannt haben, 2= 2 genannte Freund*innen, 3= 3 genannte Freund*innen usw.*/

*Beschreibung der Variablen erstellen
label variable FinG_SN "Empfänger finanzieller Unterstützung durch befragte Person (12 Monate)"

*Ausprägungen der Variable definieren
label define anzahlfreunde3 0 "0 Familie und Andere" 1 "1 Freund*in" 2 "2 Freunde" 3 "3 Freunde" 4 "4 Freunde" /*Wertelabel beziehungsart erstellen*/
label values FinG_SN anzahlfreunde3 /*der Variablen das label zuschreiben*/


********Finanzielle Unterstützung - UV2: Finanzielle Unterstützung von Freund*innen erhalten********
*Kopien der relevanten Variablen erstellen
clonevar ic801a1_K = ic801a1
clonevar ic801a2_K = ic801a2
clonevar ic801a3_K = ic801a3
clonevar ic801a4_K = ic801a4

*Rekodieren ic801a1_K bis ic801a4_K (Personen, die die befragte Person im letzten Jahr finanziell unterstützt haben)
recode ic801a1_K (102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 301 303 308 401 402 404 406 407 451 452 601 602 603 801 901 903 904 = 0) (501 502 503 504 505 506 = 1)

recode ic801a2_K (101 102 103 104 105 106 108 120 201 202 203 205 301 302 309 401 402 405 451 452 603 801 = 0) (501 502 503 504 506 = 1)

recode ic801a3_K (102 103 104 105 106 201 202 203 204 301 302 307 401 406 407 452 602 = 0) (501 502 503 505 506 = 1)

recode ic801a4_K (104 106 107 202 203 205 301 302 308 451 452 601 602 = 0) (501 502 503 504 506 = 1)

*Variablennamen ändern
rename ic801a1_K FinE_SN_1
rename ic801a2_K FinE_SN_2
rename ic801a3_K FinE_SN_3
rename ic801a4_K FinE_SN_4

*Ausprägungen der Variablen definieren
label values FinE_SN_1 beziehungsart
label values FinE_SN_2 beziehungsart
label values FinE_SN_3 beziehungsart
label values FinE_SN_4 beziehungsart

*Beschreibung der Variablen erstellen 
label variable FinE_SN_1 "Herkunft finanzieller Unterstützung (letzte 12 Monate)"
label variable FinE_SN_2 "Herkunft finanzieller Unterstützung (letzte 12 Monate)"
label variable FinE_SN_3 "Herkunft finanzieller Unterstützung (letzte 12 Monate)"
label variable FinE_SN_4 "Herkunft finanzieller Unterstützung (letzte 12 Monate)"

*Neue Variable generieren
egen FinE_SN = rowtotal(FinE_SN_1 FinE_SN_2 FinE_SN_3 FinE_SN_4) /*Variable besitzt 4 Ausprägungen; 0=Personen, die Familie und Andere genannt haben, 1=Personen, die 1 Freund*in genannt haben, 2= 2 genannte Freund*innen, 3= 3 genannte Freund*innen usw.*/

*Beschreibung der Variablen erstellen
label variable FinE_SN "Anzahl an Freund*innen, die die befragte Person finanziell unterstützt haben (letzte 12 Monate)"

*Ausprägungen der Variablen definieren 
label values FinE_SN anzahlfreunde3

********************Regressionsmodell 1 schätzen, ohne KV 
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN 

******************** Rekodierungen für Regressionsmodell 2
*Kopie Rat_SN erstellen
clonevar Rat_SN_K = Rat_SN
*Generieren einer dichotomen Variablen für Rat_SN_K
recode Rat_SN_K (0 = 0 "Nein (Keine Freunde genannt)") (1/5 = 1 "Ja (mind. 1 Freund*in genannt)"), gen(dRat_Freunde)
*Beschreibung der Variablen erstellen 
label variable dRat_SN "Verfügbarkeit von Freund*innen für Ratschläge"

*Kopie Trost_SN erstellen
clonevar Trost_SN_K = Trost_SN
*Generieren einer dichotomen Variablen für Trost_SN_K
recode Trost_SN_K (0 = 0 "Nein (Keine Freunde genannt)") (1/5 = 1 "Ja (mind. 1 Freund*in genannt)"), gen(dTrost_SN)
*Beschreibung der Variablen erstellen 
label variable dTrost_SN "Verfügbarkeit von Freund*innen für Trost"

*Kopie HilfeG_SN erstellen
clonevar HilfeG_SN_K = HilfeG_SN
*Generieren einer dichotomen Variablen für HilfeG_SN_K
recode HilfeG_SN_K (0 = 0 "Nein (Keine Freunde genannt)") (1/5 = 1 "Ja (mind. 1 Freund*in genannt)"), gen(dHilfeG_SN)
*Beschreibung der Variablen erstellen 
label variable dHilfeG_SN "Haushaltsunterstützung für Freund*innen geleistet (12 Monate)"

*Kopie HilfeE_SN erstellen
clonevar HilfeE_SN_K = HilfeE_SN
*Generieren einer dichotomen Variablen für HilfeE_SN_K
recode HilfeE_SN_K (0 = 0 "Nein (Keine Freunde genannt)") (1/5 = 1 "Ja (mind. 1 Freund*in genannt)"), gen(dHilfeE_SN)
*Beschreibung der Variablen erstellen 
label variable dHilfeE_SN "Haushaltsunterstützung von Freund*innen erhalten (12 Monate)"

*Kopie FinG_SN erstellen
clonevar FinG_SN_K = FinG_SN
*Generieren einer dichotomen Variablen für FinG_SN_K
recode FinG_SN_K (0 = 0 "Keine Freunde genannt") (1/4 = 1 "Ja (mind. 1 Freund*in genannt)"), gen(dFinG_SN)
*Beschreibung der Variablen erstellen 
label variable dFinG_SN "Finanzielle Unterstützung für Freund*innen geleistet (12 Monate)"

*Kopie FinE_SN erstellen
clonevar FinE_SN_K = FinE_SN
*Generieren einer dichotomen Variablen für Rat_SN
recode FinE_SN_K (0 = 0 "Nein (Keine Freunde genannt)") (1/4 = 1 "Ja (mind. 1 Freund*in genannt)"), gen(dFinE_SN)
*Beschreibung der Variablen erstellen 
label variable dFinE_SN "Finanzielle Unterstützung von Freund*innen erhalten"

********************Regressionsmodell 2 schätzen, ohne KV mit dichotomen UV's 
regress depressiv_17 dRat_Freunde dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN 

********************Regressionsmodell 1&2 schätzen, Multikollinearität der UV's
regress depressiv_17 Rat_Freunde Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN 
estat vif
regress depressiv_17 dRat_Freunde dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN 
estat vif

*******************Regressionsmodell 3: Quadratische Regression
Variablen für die quadratischen Werte unserer Prädiktorvariablen Rat_SN erstellen
gen Rat_Freunde2 = Rat_Freunde*Rat_Freunde
gen Trost_SN2 = Trost_SN*Trost_SN
gen HilfeG_SN2 = HilfeG_SN*HilfeG_SN
gen HilfeE_SN2 = HilfeE_SN*HilfeE_SN
gen FinG_SN2 = FinG_SN*FinG_SN
gen FinE_SN2 = FinE_SN*FinE_SN
regress depressiv_17 Rat_Freunde Rat_Freunde2 Trost_SN Trost_SN2 HilfeG_SN HilfeG_SN2 HilfeE_SN HilfeE_SN2 FinG_SN FinG_SN2 FinE_SN FinE_SN2

******** Kontrollvariablen ****

* 1. Geschlecht (ic1) - Ausprägungen auf 0 und 1 setzen
* Kopie erstellen
clonevar Männlich = ic1
* Rekodieren
recode Männlich (2 = 0) (1 = 1)
* Beschreibung erstellen
label variable Männlich "Geschlecht"
* Ausprägungen labeln 
*1. Wertelabel definieren
label define Geschlecht 0 "Weiblich" 1 "Männlich"
*2. Ausprägungen labeln 
label values Männlich Geschlecht

*2. Familienstand (famstand_17) - Kategorien zusammenfassen
* Kopie erstellen
clonevar Alleinstehend = famstand_17
* Rekodieren
recode Alleinstehend (1/2= 0) (3/5= 1)
* Beschreibung erstellen
label variable Alleinstehend "Familienstand 2017"
* Ausprägungen labeln 
*1. Wertelabel definieren
label define famstand 0 "Verheiratet" 1 "Alleinstehend"
label values Alleinstehend famstand 

*3. Erwerbsstatus (erw_17) - Dummies erstellen 
* Kopien erstellen 
clonevar Ruhestand = erw_17 
clonevar NichtErwerbstätig = erw_17 
* Rekodieren 
recode Ruhestand (1 3 = 0) (2 = 1)
recode NichtErwerbstätig (1 2 = 0) (3 = 1)
* Beschreibung erstellen 
label variable Ruhestand "Dummy Ruhestand (Referenz Erwerbsstätige)"
label variable NichtErwerbstätig "Dummy Nicht-Erwerbstätig (Referenz Erwerbstätige)"
* Ausprägungen der Variablen labeln 
*1. Wertelabel definieren
label define LabelR 0 "Erwerbstätige (&Nicht-Erwerbstätige)" 1 "Ruhestand"
*2. Ausprägungen labeln 
label values Ruhestand LabelR
*3. Wertelabel definieren
label define LabelN 0 "Erwerbstätige (&Ruhestand)" 1 "Nicht-Erwerbstätige"
*4. Ausprägungen labeln 
label values NichtErwerbstätig LabelN

*4. Bildungsniveau (bildung4_17): Ausprägungen umkehren 
clonevar bildung4_17_K = bildung4_17
recode bildung4_17_K (4=0 "Hoch") (3=1 "Gehoben") (2=2 "Mittel") (1=3 "Niedrig"), gen(Bildung)
label variable Bildung "Bildungsniveau (4-Stufen)"

*5. Vorhandensein funktionaler Einschränkungen (ic523a): Dummy erstellen, Ausprägungen umkehren 
clonevar ic523a_K = ic523a
recode ic523a_K (3= 0 "Nein")(1/2 = 1 "Ja"), gen(Einschränkung)
label variable Einschränkung "Funktionale Einschränkungen durch Gesundheit"

*6. Pflegebedürftigkeit (ic524): Dummy erstellen, Ausprägungen umkehren
clonevar ic524_K = ic524
recode ic524_K (2=0 "Nein") (1=1 "Ja"), gen(Pflegebedürftigkeit)
label variable Pflegebedürftigkeit "Pflegebedürftigkeit durch schlechte Gesundheit"

******** Altersgruppen erstellen ****

clonevar altersgruppe1 = alter_17
clonevar altersgruppe2 = alter_17
clonevar altersgruppe3 = alter_17

recode altersgruppe1 (43/59=1) (60/97=0)
label define Alter1 0 "0(60-97J)" 1 "1(43-59J)"
label values altersgruppe1 Alter1
label variable altersgruppe1 "altersgruppe1"

recode altersgruppe2 (43/59=0) (80/97=0) (60/79=1)
label define Alter2 0 "0(andere)" 1 "1(60-79J)"
label values altersgruppe2 Alter2
label variable altersgruppe2 "altersgruppe2"

recode altersgruppe3 (43/79=0) (80/97=1) 
label define Alter3 0 "0(43-79J)" 1 "1(80-97J)"
label values altersgruppe3 Alter3
label variable altersgruppe3 "altersgruppe3"


*******************Regressionsmodell 1 - schrittweise KV aufnehmen
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN 
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung 
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 na_17 
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 na_17 optimismus_17
regress depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 na_17 optimismus_17 stress_17 
*******************Regressionsmodell 2 - schrittweise KV aufnehmen
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN 
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 Bildung 
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung 
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 na_17 
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 na_17 optimismus_17
regress depressiv_17 dRat_SN dTrost_SN dHilfeG_SN dHilfeE_SN dFinG_SN dFinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 na_17 optimismus_17 stress_17 

** Log Transformation der abhängigen Variable (depressiv_17)
gen ln_depressiv_17 = ln(depressiv_17)
*******************Regressionsmodell 4 - schrittweise Aufnahme der KV
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN 
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung 
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 na_17 
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 na_17 optimismus_17
regress ln_depressiv_17 Rat_SN Trost_SN HilfeG_SN HilfeE_SN FinG_SN FinE_SN Männlich Alleinstehend alter_17 Bildung anzphy_17 Einschränkung selbstwirk_17 selbstwert_17 ic501 na_17 optimismus_17 stress_17 

//////////////////Fazit: Um die Komplexität zu reduzieren und das Konstrukt besser messbar zu machen,  alternative Messindikatoren für 'freundschaftliche Unterstützung' verwenden und den Modellumfang auf emotionale freundschaftliche Unterstützung begrenzen. Kontrollvariablen anpassen

*******************Regressionsmodell 5 - schrittweise Aufnahme der KV
regress depressiv_17 Rat_Freunde
regress depressiv_17 Rat_Freunde Männlich 
regress depressiv_17 Rat_Freunde Männlich Alleinstehend 
regress depressiv_17 Rat_Freunde Männlich Alleinstehend anzphy_17
regress depressiv_17 Rat_Freunde Männlich Alleinstehend anzphy_17 
regress depressiv_17 Rat_Freunde Männlich alter_17 Alleinstehend bildung4_17 


//////////////////Fazit: 
//Bisherige Regressionsmodelle: Zu überfrachtet 
//Nicht alle 6 UV's messen das Konstrukt der 'freundschaftlichen Unterstützung' valide 
//Ursprünglicher Effekt bzw. Hauptzusammenhang besteht, verschwindet bei schrittweiser Zunahme potentieller Störfaktoren - mögl. Gründe: UV(s) haben keinen eigenständigen Einfluss auf AV/Effekt nur scheinbar vorhanden 

////weitere Vorgehensweise: 
//Änderung der abhängigen Variablen von Depressivität hinzu subjektivem Einsamkeitsempfinden theoretisch begründbar, daher Test 





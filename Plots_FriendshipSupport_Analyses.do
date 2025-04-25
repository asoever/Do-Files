* Do - freundschaftliche Unterstüzung-Depression-Einsamkeit

use "/Users/PATH/TO/DATAFILE.dta" /* Do-File uses sensitive data from the German Ageing Survey (DEAS), which can't be shared without proper authorization. */

* Verteilung der Variablen Depressivität 
hist depressiv_17, frequency 
* Oder 
kdensity depressiv_17

* Verteilung der Variablen Depressivität nach Altersgruppen
histogram depressiv_17 if alter_17 < 80, name(hist_DepAlt, replace)
histogram depressiv_17 if alter_17 >= 80, name(hist_DepHochalt, replace)
graph combine hist_DepAlt hist_DepHochalt, col(2)
// eignet sich nicht (Skalierung)

***BY AGE: graph box
 graph box depressiv_17 if alter_17 >= 80, over(ic712_1)

. graph box depressiv_17 if alter_17 < 80, over(ic712_1)

. graph box depressiv_17 if alter_17 >= 80, over(ic712_1)

. graph box depressiv_17 if alter_17 < 60, over(ic712_1)

* Variablen Vorhandensein SN - ic600 & nwgroesse_17 oder neue Variable mit Anzahl Freunden (!)
swilk depressiv_17 ic600 nwgroesse_17
spearman depressiv_17 ic600 nwgroesse_17 /* -> keine Korrelation */

* Test Mittelwertunterschiede: 
// Unterscheiden sich Befragte hinsichtlich ihres Depressivitätsscores abhängig davon, ob sie soziale Kontakte im Netzwerk genannt haben?
ranksum depressiv_17, by(ic600) /* es besteht ein statistisch signifikanter Unterschied zwischen den beiden Gruppen (SN: Ja/Nein) und Depressivität (p=0.01)*/

*Unterscheiden sich Hochaltrige (80+) und Alte (60-79) hinsichtlich ihres Depressivitätsscores abhängig davon, ob sie soziale Kontakte im Netzwerk genannt haben?  
// Test für "alte Personen" (60–79 Jahre)
ranksum depressiv_17 if altersgruppe2 == 1, by(ic600) /*nicht signifikant auf 95% Signifikanzniveau, aber auf 90% Signifikanzniveau signifikant (p=0.09)*/

// Test für "hochaltrige Personen" (80–97 Jahre)
ranksum depressiv_17 if altersgruppe3 == 1, by(ic600) /*nicht signifikant auf allen Signifikanzniveau(p=0.11)*/

* Boxplot depressiv_17 ic600

graph hbox depressiv_17 if alter_17 < 80, over(ic600) ytitle("Depressive symptoms by social contacts aged under 80") saving(graphbox1, replace)
graph hbox depressiv_17 if alter_17 >= 80, over(ic600) ytitle("Depressive symptoms aged 80 &above") saving(graphbox2, replace)
graph combine graphbox1.gph graphbox2.gph, col(2) 

*Dot chart
*1. depressiv_17 umkodieren (Cut off >=18)
clonevar depressivbinär = depressiv_17
recode depressivbinär (0/17.5=0) (18/45=1)
label define Depression 0 "Keine Depression" 1 "Depression vorhanden"
label values depressivbinär Depression
label variable depressivbinär "Vorliegen depressiver Symptome"
*2. Dot chart erstellen 
graph dot (p25) alter_17 ( mean ) alter_17 (p75) alter_17, over(depressivbinär)

*Violinplot
vioplot depressiv_17, over(ic700)

*2. Alter und soziale Kontakte
graph dot (p25) alter_17 ( mean ) alter_17 (p75) alter_17, over(ic600) /*SN*/
graph dot (p25) alter_17 ( mean ) alter_17 (p75) alter_17, over(hasFriends) /*Freunde*/

* Größe Netzwerk und Depression
// Variable Größe_SN erstellen 
clonevar ic601_1_K = ic601_1
clonevar ic601_2_K = ic601_2
clonevar ic601_3_K = ic601_3
clonevar ic601_4_K = ic601_4
clonevar ic601_5_K = ic601_5
clonevar ic601_6_K = ic601_6
clonevar ic601_7_K = ic601_7
clonevar ic601_8_K = ic601_8

recode ic601_1_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 208 209 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 329 330 401 402 403 404 405 406 407 451 452 501 502 503 504 505 506 601 602 603 701 702 801 901 902 903 904 905 = 1)  
recode ic601_2_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 208 209 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 329 330 401 402 403 404 405 406 407 451 452 501 502 503 504 505 506 601 602 603 701 702 801 901 902 903 904 905 = 1) 
recode ic601_3_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 208 209 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 329 330 401 402 403 404 405 406 407 451 452 501 502 503 504 505 506 601 602 603 701 702 801 901 902 903 904 905 = 1) 
recode ic601_4_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 208 209 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 329 330 401 402 403 404 405 406 407 451 452 601 602 501 502 503 504 505 506 603 701 702 801 901 902 903 904 905 = 1) 
recode ic601_5_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 208 209 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 329 330 401 402 403 404 405 406 407 451 452 501 502 503 504 505 506 601 602 603 701 702 801 901 902 903 904 905 = 1) 
recode ic601_6_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 208 209 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 329 330 401 402 403 404 405 406 407 451 452 501 502 503 504 505 506 601 602 603 701 702 801 901 902 903 904 905 = 1) 
recode ic601_7_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 208 209 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 329 330 401 402 403 404 405 406 407 451 452 501 502 503 504 505 506 601 602 603 701 702 801 901 902 903 904 905 = 1)
recode ic601_8_K (101 102 103 104 105 106 107 108 111 112 120 201 202 203 204 205 206 207 208 209 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 329 330 401 402 403 404 405 406 407 451 452 501 502 503 504 505 506 601 602 603 701 702 801 901 902 903 904 905 = 1) 

egen Größe_SN = rowtotal (ic601_1_K ic601_2_K ic601_3_K ic601_4_K ic601_5_K ic601_6_K ic601_7_K ic601_8_K ic607_8)

// Boxplot mit verschiedenen SN Größen (weiß nicht, ob sinnvoll)
gen dep1 = depressiv_17 if Größe_SN < 20
gen dep2 = depressiv_17 if Größe_SN < 40
gen dep3 = depressiv_17 if Größe_SN < 58
gen dep4 = depressiv_17 if Größe_SN < 104
graph box dep1 dep2 dep3 dep4



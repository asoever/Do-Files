* Do - ReligionAbtreibung - Allbus-Datensatz 2021

clear all
cap log close 
version 18.0
set more off

use "/Users/PATH/TO/DATAFILE.dta" /* Do-File uses sensitive data from the German General Social Survey (ALLBUS), which can't be shared without proper authorization. */
* ALLBUS 2021-Datensatz öffnen

* Ausschluss der Personen, die nicht zur Religiosität befragt wurden 
drop if rb07 == -11


* Rekodierung der Selbsteingeschätzten Religiosität*
gen reli = rb07
label var reli "Selbsteingeschätzte Religiosität"
recode reli (-9=.)(-42=.) (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (8=7) (9=8) (10=9)
label define reli_lbl 0"nicht religiös" 9"stark religioes"
label value reli reli_lbl
numlabel reli_lbl, add
tab reli

* Rekodierung der Verhaltensbeurteilung von Schwangerschaftsabbrüchen*
gen abort = ca03
label var abort "Einstellung zur Rechtfertigbarkeit von Abtreibungen"
recode abort (-9=.)(-42=.) (1=0) (2=1) (3=2) (4=3) 
label define abort_lbl 0"Schwangerschaftsabbruch sehr schlimm" 1"Schwangerschaftsabbruch ziemlich schlimm" 2"Schwangerschaftsabbruch weniger schlimm" 3"Schwangerschaftsabbruch gar nicht schlimm"
label value abort abort_lbl
numlabel abort_lbl, add
tab abort

* Rekodierung der Selbsteinstufung auf der Links-Rechts-Skala zu einer Dummy-Variable*
gen linkrech = pa01
label var linkrech "Selbsteinstufung auf der Links-Rechts-Skala"
recode linkrech (-9=.)(-42=.) (1=0) (2=0) (3=0) (4=0) (5=0) (6=1) (7=1) (8=1) (9=1) (10=1)
label define linkrech_lbl 0"politisch links" 1"politisch rechts"
label value linkrech linkrech_lbl
numlabel linkrech_lbl, add
tab linkrech

* Rekodierung des Alters (Hierbei Übernahme der Variable "age" unter Ausschluss der Missing Values)*
gen alter = age
label var alter "Alter"
recode alter (-32=.) 
tab alter

* Rekodierung des Geschlechts*
gen ges = sex
label var ges "Geschlecht"
recode ges (3=.)(-9=.) (1=0) (2=1) 
label define ges_lbl 0"mann" 1"frau"
label value ges ges_lbl
numlabel ges_lbl, add
tab ges

* Zusammenhangsmaße und Häufigkeiten

* Darstellung der Variablen in Häufigkeitstabelle*
sum reli abort linkrech alter ges 
* Anpassung dieser in Apple Numbers (Siehe Abbildung 4)*

* Anzeigen der Nettostichprobe*
count 

* Darstellung der Antworthäufigkeiten von Religiosität*
histogram reli, frequency ytitle(`"Häufigkeit"')
 
* Darstellung der Antworthäufigkeiten von Schwangerschaftsbabrüchen*
histogram abort, frequency ytitle(`"Häufigkeit"')

* Korrelationskoeffizient von den Variablen "reli" und "abort" ausfindig machen*
* Nutzen eines 1%-igen Signifikanzniveaus*
pwcorr abort reli, sig star (0.01) 
 
* Korrelationskoeffizient von den Variablen "linkrech" und "abort" ausfindig machen*
* Nutzen eines 1%-igen Signifikanzniveaus*
pwcorr abort linkrech, sig star (0.01) 


* Regressionstabellen

* Ausschluss von dener, die für die Regression irrelevant sind*
gen sample = 0 
replace sample = 1 if reli ! =. & abort !=. & linkrech !=. & alter !=. & ges !=.
tab sample, m 
keep if sample == 1 

* Moderatorvariable generieren
gen moderator = c.reli*linkrech

***Modell 1: nur Haupt-X, und Y:
reg abort reli 
est store mod1_mm

****Modell 2: Interaktionsterm*
reg abort reli moderator
est store mod2_mm

****Modell 3: zusätzlich weitere Kontrollvariablen:
reg abort reli moderator alter ges
est store mod3_mm








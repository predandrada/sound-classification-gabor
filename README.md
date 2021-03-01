# Gabor Filter -- DSP Assignment

### Overview
- Ex 1 este rezolvat in [gabor_filter.m](gabor_filter.m)
- Ex 2, 3 sunt rezolvate integral in [get_features.m](get_features.m)
- Ex 4 este rezolvat in [get_result_conv.m](get_result_conv.m)
- Ex 5 este rezolvat in [get_stride_conv.m](get_stride_conv.m)

### Ex 1
- am implementat filtrul gaussian conform formulei (3), considerand media u = size/2.

### Ex 2
- mi-am construit in get_features.m 3 matrice (cos_filters, sin_filters si exp_filters) pentru a avea acces mai usor la filtre -- fiecarei linii ii corespunde unui filtru;
- cele 3 matrice vor fi returnate de functie sub forma unui singur vector bidimensional, construit la final:

	`filters = [cos_filters; sin_filters; exp_filters];`

- am afisat filtrele cos si sin folsind valorile de pe primele linii ale matricelor cos_filters & sin_filters.

### Ex 3
- destul de straightforward: am iterat prin filtre, am aplicat fft si am afisat spectrul pentru fiecare 
	
### Ex 4
- am iterat prin fiecare sunet am aplicat convolutia pe fiecare filtru de la linia j
- dimensiunile de dupa convolutie: [161805, 1] 

	`161805 = 160704 + 1101 = size(elem 1) + size (elem 2) - 1`

- obtin: 
	'Accuracy on train: 0.55'
	'Accuracy on test: 0.49'

### Ex 5
- am realizat parcurgerea unui sunet in bucati de 35ms, pe care le-am transpus in esantioane 
- 35 ms => 1543.815 ~ 1543 esantioane

- pentru dimensiunea ferestrei: transpunand 25 ms am obtinut 1102.725 esantioane, aproximate 1102, pt a corespunde cu dimensiunea filtrului gabor
- am obtinut ~ 104 ferestre 
- am folosit formula (1), insa nu am mai inversat filtrul, datorita proprietatii de simetrie
- pentru a ilustra respectarea egalitatii am pus conditia intr-un if, astfel incat daca se depaseste pragul de 10^-10 sa se printeze un mesaj -- mesajul nu se afiseaza => corectitudine
- pentru a realiza matricea rezultat am iterat separat de calculul tensorilor: pentru fiecare sunet se va itera din nou prin filtre (valorile sunt sub forma de vectori coloana in cadrul tensorilor) si se aplica mean si std pe coloane 	

- obtin: 
	'Accuracy on train: 0.71'
	'Accuracy on test: 0.55'

## Implementare TEMA1-METODE NUMERICE:

### Task 1. Markov is coming...

1. Functia parse_labyrinth:
	Am citit prima linie din fișier cu [fgetl]
(https://www.mathworks.com/help/matlab/ref/fgetl.html) și am folosit
[str2num] (https://www.mathworks.com/help/matlab/ref/str2num.html) pentru a
extrage dimensiunile matricei (m și n). Apoi, cu ajutorul unui while, am parcurs
fiecare linie a fișierului, am convertit-o în vector numeric tot cu str2num și
am completat rândurile matricei Labyrinth. Metoda de procesare a fost inspirata
din primul laborator.
	Această abordare este simplă și eficientă pentru fișiere structurate corect.
Singura verificare inclusă este pentru deschiderea fișierului, unde se afișează
un mesaj de eroare dacă acesta nu poate fi accesat.

2. Functia get_adjacency_matrix:
	Am extras dimensiunile labirintului cu [size]
(https://www.mathworks.com/help/matlab/ref/double.size.html), apoi am construit
o matrice matrix cu valori de la 1 la m*n, folosind [reshape]
(https://www.mathworks.com/help/matlab/ref/double.reshape.html) și două for-uri.
Am inițializat matricile win_matrix și lose_matrix pentru a marca stările
speciale. Fiecare element al labirintului a fost convertit în binar cu [dec2bin]
(https://www.mathworks.com/help/matlab/ref/dec2bin.html), rezultând
un string. Pentru a obține valorile [b3 b2 b1 b0], am folosit str2num pe fiecare
caracter. Fiecare bit reprezintă existența unui perete: Nord (b3), Sud (b2), Est
(b1), Vest (b0). Dacă pentru b3 sau b2 suntem pe prima sau ultima linie, nodul
curent se leagă de starea WIN (indice m x n+1). În caz contrar, se creează o
legătură cu nodul de deasupra sau dedesubt. Analog, pentru b1 și b0, dacă ne
aflăm pe marginea din stânga sau dreapta, nodul se leagă de starea LOSE
(m x n+2). În rest, se conectează cu vecinii din stânga/dreapta. Am adăugat
legături între stările WIN și LOSE, iar la final am creat matricea de adiacență
de tip [sparse] (https://docs.octave.org/v4.2.2/Creating-Sparse-Matrices.html)
pentru a optimiza spațiul de memorie ocupat. Pentru logica construirii rețelei
și a matricii de adiacență, m-am inspirat din doua exemple MATLAB disponibile
aici: https://ece.uwaterloo.ca/~dwharder/Matlab/indexing.html si
https://www.mathworks.com/matlabcentral/answers/2002377-i-want-to-get-adjacency-matrix-of-a-networkz

3. Functia get_link_matrix:
	Pornind de la matricea de adiacență Adj, am construit matricea de legătură
Link, unde fiecare element nenul de pe o linie este împărțit la numărul total de
elemente nenule de pe linia respectivă. Această normalizare transformă matricea
într-o formă probabilistică, utilă pentru modelări de tip lanț Markov. Pentru a
calcula suma valorilor de pe fiecare linie, am folosit funcția [sum]
(https://www.mathworks.com/help/matlab/ref/double.sum.html) din
documentația oficială MATLAB. Operația a fost realizată în cadrul unui for care
parcurge liniile și coloanele, împărțind fiecare valoare 1 la suma totală a
liniei respective. Matricea rezultată este de tip sparse pentru a optimiza
utilizarea memoriei.

4. Functia get_Jacobi_parameters:
	Extragem matricea și vectorul de iterații necesare pentru aplicarea metodei
Jacobi pe modelul de labirint. Pentru aceasta, am eliminat ultimele două linii
și coloane din matricea de legătură Link, corespunzătoare stărilor speciale WIN
și LOSE. Am construit matricea G folosind primele n1 linii și n2 coloane, iar
vectorul c a fost extras din coloana n2+1, reprezentând influența stării WIN
asupra fiecărui nod din rețea.

5. Functia perform_iterative:
	Am implementat metoda Jacobi pentru rezolvarea sistemului 𝑥=𝐺𝑥+𝑐, iterativ.
Inițial, x ← x0, err ← tol + 1, iar la fiecare pas se salvează vechea soluție
(x_anterior) pentru a calcula norma diferenței. Dacă eroarea devine mai mică
decât tol sau se atinge max_steps, procesul se oprește. Funcția întoarce soluția
finală, eroarea și numărul de pași executați. Algoritmul este eficient dacă
matricea G respectă condițiile de convergență. Metoda de rezolvare a
algoritmului Jacobi este la fel ca cea facuta la laborator.

6. Functia heuristic_greedy:
	Am implementat un algoritm greedy euristic pentru a găsi un traseu dintr-o
poziție inițială către starea WIN, pe baza probabilităților. La fiecare pas, cu
[find] (https://www.mathworks.com/help/matlab/ref/find.html)
alegem vecinul nevizitat cu probabilitatea maximă. Dacă nu există vecini
eligibili [isempty]
(https://www.mathworks.com/help/matlab/ref/double.isempty.html), facem
backtracking. Se evită ciclurile cu un vector visited, iar algoritmul se oprește
la atingerea stării WIN.

7. Functia decode_path:
	Am implementat o funcție care transformă un vector de stări într-un traseu
exprimat prin coordonate (linie, coloană). Am reconstruit o matrice de referință
pentru a lega fiecare stare de poziția ei în labirint. Folosind find, totodata
fiind indrumata de informatiile furnizate in acest link https://www.mathworks.com/matlabcentral/answers/214388-how-do-i-find-what-row-and-column-a-specific-element-is-in
identificăm poziția fiecărei stări din path, ignorând starea finală WIN.
Se construiește astfel decoded_path, vectorul de coordonate ce descrie vizual
parcursul în labirint.

### Task 2. Linear Regression

1. Functia parse_data_set_file:
	Am citit prima linie a fisierului cu fgetl si de acolo am extras
dimensiunile matricii. Ulterior, am creat trei matrici, doua de tip [cell]
(https://www.mathworks.com/help/matlab/ref/cell.html) si una de tip numeric.
Prima matrice se stocheaza cu toate informatiile din fisier, acestea fiind
prelucrate cu ajutorul functiei [regexp]
(https://www.mathworks.com/help/matlab/ref/regexp.html).
Prima coloana a matricii A este atribuita lui Y, datele fiind convertite cu
ajutorul functiei [str2double]
(https://www.mathworks.com/help/matlab/ref/str2double.html), restul fiind
atribuit in InitialMatrix.

2. Functia parse_csv_file:
	Am citit prima linie a fisierului pentru a duce cursorul incepand de la
linia a doua a acestuia. Cu [textscan]
(https://www.mathworks.com/help/matlab/ref/textscan.html) am extras continutul
ramas necitit, iar apoi am stocat in A toata informatia prelucrata cu regexp.
Prima coloana a matricii A s-a dus in Y, iar restul in InitialMatrix.

3. Functia prepare_for_regression:
	Am creat o matrice numerica in care voi adauga toate informatiile prelucrate
din InitialMatrix. Astfel, am creat doua for-uri pentru a ma plimba prin matrice
element cu element. Compar elementele din InitialMatrix cu [strcmp]
(https://www.mathworks.com/help/matlab/ref/strcmp.html) Am creat un contor a
care este 0 pe fiecare linie iar cand ajunge la coloana n-1 in cazul in care
avem de modificat 'furnished', 'semi-furnished' sau 'unfurnished' acesta se
face 1. In acest fel, putem umple corespunzator matricea FeatureMatrix.

4. Functia linear_regression_cost_function:
	Am calculat functia de cost cu formula din suportul teoretic aferent task-
ului. Astfel, am extras prima coloana din Theta pentru ca aceasta era 0 si nu
ne ajuta la calculul valorii prezise. Totodata, am scazut iesirile, am ridicat
la patrat fiecare element din vectorul rezultat, am adunat apoi termenii sai
iar la final am calculat eroarea.

5. Functia gradient_descent:
	Am adaugat o coloana de 1 atat in Theta cat si FutureMatrix cu ajutorul
functiei [cat] (https://www.mathworks.com/help/matlab/ref/double.cat.html),
pentru a permite calculul corect al produsului între matrice. În cadrul
algoritmului, se calculează eroarea între predicțiile modelului și valorile
reale, iar coeficientul Theta este actualizat iterativ, începând de la al doilea
element pentru a ignora influența valorii 0 a primului element.

6. Functia normal_equation:
	În această funcție, folosim metoda ecuației normale combinată cu gradientul
conjugat pentru a calcula vectorul de parametri Theta. Se adaugă o coloană de 1
la matricea de intrare pentru a putea include termenul liber. Se calculează
matricea A și vectorul b necesare rezolvării sistemului normal de ecuații.
Pentru a evita modificarea primei componente a lui Theta, sistemul este
restricționat doar la coeficienții corespunzători caracteristicilor. Apoi,
folosind gradientul conjugat, se actualizează pas cu pas valorile din Theta până
când eroarea devine mai mică decât o toleranță dată sau până la un număr maxim
de iterații.

7. Functia lasso_regresion_cost_function:
	Am folosit aceleasi calcule ca la linear_regression_cost_function, iar
apoi am calculat regularizarea prin adaugarea tuturor elementelor in modul.
Am calculat ulterior eroarea cu formula specifica acestui caz.

8. Functia ridge_regression_cost_function:
	Am folosit aceleasi calcule ca la linear_regression_cost_function, iar
apoi am calculat regularizarea prin adaugarea tuturor elementelor la patrat.
Am calculat ulterior eroarea cu formula specifica acestui caz.

### Task 3. MNIST 101

1. Functia load_dataset:
	Am extras toate informatiile din fisierul de tip .mat cu ajutorul functiei
[load] (https://www.mathworks.com/help/matlab/ref/load.html).

2. Functia split_dataset:
	Am permutat liniile cu [randperm]
(https://www.mathworks.com/help/matlab/ref/randperm.html) si am aplicat aceeasi
permutare pe X si y. Am calculat cate teste se duc in train, respectiv cate se
duc in test. Ulterior, am adaugat primele m_train teste in setul de train, iar
pe restul le am adaugat in setul de test. Ideea de a permuta matricea si
vectorul in acelasi fel am luat-o din acest link:
(https://www.mathworks.com/matlabcentral/answers/1568213-how-to-shuffle-two-matrices-in-a-consistent-manner)

3. Functia initialize_weights:
	Am adunat cele doua dimensiuni si l-am calculat pe epsilon, apoi am calculat
o matrice cu valori aleatoare intre -epsilon si epsilon astfel: cum stim ca
functia [rand] (https://www.mathworks.com/help/matlab/ref/rand.html) ne da o
matrice cu valori intre 0 si 1, am inmultit cu 2*epsilon
pentru a obtine una cu valori in 0, 2*epsilon, iar la final am scazut un epsilon
pentru a avea in matrice valori intre -epsilon si epsilon.

4. Functia cost_function:
	Am împărțit vectorul params în matricile Theta1 și Theta2 folosind reshape.
Am adăugat o coloană de 1 la X și am aplicat propagarea înainte, calculând
activările a2 și a3 prin funcția sigmoid. Costul a fost calculat folosind
formula specifică rețelelor neuronale, iar apoi a fost împărțit la numărul de
exemple și a fost adăugată regularizarea fără a afecta coloana de bias. Am
aplicat apoi backpropagation pentru a calcula gradientele triunghi1 și
triunghi2. Gradientele au fost ajustate cu regularizare și în final au fost
concatenate într-un vector coloană pentru rezultat.

5. Functia predict_classes:
	În această funcție, folosind dimensiunile de intrare, reconstruim matricile
de ponderi pentru straturile rețelei. Se adaugă o coloană de 1 în fața lui X
pentru bias, iar apoi se calculează activările pentru stratul ascuns și stratul
de ieșire prin înmulțiri succesive și aplicarea funcției sigmoid. După obținerea
activărilor finale, pentru fiecare exemplu se parcurg valorile din stratul de
ieșire și se caută maximul. Poziția acestuia este considerată clasa prezisă și
este stocată într-un vector rezultat.

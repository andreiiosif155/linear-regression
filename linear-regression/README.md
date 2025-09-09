Linear regression

Abstract:
Implemented multiple regression techniques in Matlab/Octave for predictive modeling on structured datasets:
> Built parsers for mixed-type datasets (.txt and .csv), converting categorical features into numerical form
> Implemented Multiple Linear Regression with:
   - Gradient Descent for iterative optimization
   - Normal Equation (Conjugate Gradient method) for efficient system solving
> Designed cost functions for standard regression, Lasso (L1), and Ridge (L2) regularization
> Focused on memory efficiency (cell arrays, sparse representation) and robust parsing for real-world data


A more detailed implementation can be found below:
parse_data_set_file
> Se citesc dimensiunile, iar cu ajutorul acestora se initializeaza matricea
  de tip cell[1] pentru a stoca date mixte: atat siruri de caractere
  cat si numere
> La citire, primul element de pe fiecare rand reprezinta iesirea, iar restul
  elementele vectorului de predictori ce pot fi atat stringuri cat si numere.
  Astfel, initial vom citi elementele sub forma de sir de caractere, iar apoi
  vom incerca sa le transformam in numere cu ajutorul functiei str2double[2]
  (care este mai eficienta decat functia str2num[3]). Aceasta functie returneaza
  NaN daca conversia a esuat. Verificam daca acestea pot fi transformate in
  numere (deci sunt numere) cu ajutorul functiei isnan[4],  si stocam
  informatia sub forma aferenta

prepare_for_regression
> Se creeaza un vector pentru a retine coloanele ce contin date non-numerice, 
  deoarece doar pe acele coloane trebuie operat, fiind un mod mai eficient decat
  de a parcurge toata matricea de mai multe ori.
> Se verifica daca un element nu este numeric cu ajutorul functiei isnumeric[5], 
  iar apoi daca acesta specifica tipul de furnished cu ajutorul functiei strfind[6]
  si a functiei isempty[7] ce verifica rezultatul intors de strfind[6],
  caz in care se muta toate coloanele din dreapta o pozitie la dreapta iar in spatiul
  liber se initializeaza o coloana noua.
> Se transforma string-urile in valori numerice, populand astfel si coloanele nou create.
> Se converteste matricea de celule intr-o matrice numerica cu ajutorul functiei cell2mat[8].

linear_regression_cost_function
> Se elimina coeficientul theta0 (considerat 0), si se calculeaza erorile patratice dintre
  predictii si valorile reale.
> Se parcurg toate exemplele si se aduna patratul erorilor corespunzatoare.
> Functia de cost este calculata ca media acestor erori patratice, conform definitiei.

parse_csv_file
> Se deschide fisierul .csv si se ignora primul rand, considerat antet.
> Se citesc pe rand liniile fisierului cu ajutorul functiei fgetl[9] pana ajungem la
  finalul fisierului (fapt pe care il verificam cu functia feof[10]), 
  iar separatorii ',' sunt inlocuiti cu spatii pentru o parsare mai usoara
  cu ajutorul functiei strrep[11].
> Se separa fiecare linie in elemente cu ajutorul functiei strsplit[12]:
  primul element este iesirea (valoarea y), iar restul sunt predictori.
> Fiecare predictor este convertit la numar daca este posibil, altfel este
  pastrat ca string in matricea InitialMatrix.

gradient_descent
> Se initializeaza vectorul coeficientilor Theta cu 0, iar matricea este extinsa
  cu o coloana de 1 pentru coeficientul theta0.
> In cadrul fiecarui pas al algoritmului gradientului descendent:
  - Se calculeaza predictiile folosind formula h(x) = X * Theta
  - Se calculeaza erorile ca diferenta intre predictii si iesiri
  - Se determina gradientul functiei de cost pentru toti coeficientii
  - Se actualizeaza doar coeficientii theta 1 ... n, mentinand theta0 egal cu 0
> Functia intoarce vectorul final de coeficienti dupa `iter` iteratii.

normal_equation
> Se aplica metoda gradientului conjugat pentru a rezolva sistemul (X^T * X) * x = X^T * Y,
  folosind o abordare iterativa.
> Algoritmul urmeaza pseudocodul oferit in enuntul temei (pagina 16 din PDF).
> Se initializeaza vectorul x cu 0 si se executa iteratii:
  - Se calculeaza pasul t_k si se actualizeaza vectorul x
  - Se actualizeaza reziduul r si directia de cautare v conform formulelor standard
  - Iteratia continua pana cand norma reziduului scade sub o toleranta data sau
    se atinge numarul maxim de iteratii
> La final, se construieste vectorul Theta adaugand theta0 = 0 (conform cerintei),
  iar restul coeficientilor sunt cei determinati prin gradientul conjugat.

lasso_regression_cost_function
> Se elimina coeficientul theta0 (considerat 0), si se calculeaza erorile patratice dintre
  predictii si valorile reale.
> Se adauga norma L1 a coeficientilor inmultita cu parametrul lambda, pentru a micsora
  complexitatea modelului si a reduce dependenta iesirii de unii predictori.
> Functia intoarce o valoare reala ce reprezinta functia de cost regularizata corespunzatoare
  metodei Lasso Regression.

ridge_regression_cost_function
> Se elimina coeficientul theta0 (considerat 0), iar apoi se calculeaza
  predictiile si erorile patratice dintre acestea si valorile reale.
> Se aduna patratele tuturor coeficientilor ramasi (theta 1 ... n),
  construind astfel norma L2 a modelului.
> Se adauga la functia de cost termenul de regularizare 
  L2 = lambda * suma_patratelor_coeficientilor, pentru a micsora amplitudinea
  coeficientilor si a reduce suprainvatarea.
> Rezultatul final este o valoare reala ce reprezinta functia de cost regularizata
  conform metodei Ridge Regression.

cell[1] - https://docs.octave.org/latest/Cell-Arrays.html
str2double[2] - https://octave.sourceforge.io/octave/function/str2double.html
str2double vs str2num[3] - https://docs.octave.org/v8.4.0/Numerical-Data-and-Strings.html#:~:text=Programming%20Note%3A%20str2double%20can%20replace,See%20also%3A%20str2num.&text=Convert%20the%20string%20(or%20character,number%20(or%20an%20array).&text=The%20optional%20second%20output%2C%20state,when%20the%20conversion%20is%20successful.
isnan[4] - https://octave.sourceforge.io/octave/function/isnan.html
isnumeric[5] - intoarce 1 daca e numar si 0 daca nu e - https://octave.sourceforge.io/octave/function/isnumeric.html
strfind[6] - returneaza pozitia aparitiilor unui sir in alt sir sau o celula goala daca nu exista aparitii
           - (strstr nu ar fi functionat aici deoarece nu functioneaza pe celule in MATLAB/Octave) 
           - https://octave.sourceforge.io/octave/function/strfind.html
isempty[7] - intoarce 1 daca celula e goala si 0 daca nu e - https://octave.sourceforge.io/octave/function/isempty.html
cell2mat[8] - https://octave.sourceforge.io/octave/function/cell2mat.html
fgetl[9] - https://octave.sourceforge.io/octave/function/fgetl.html
feof[10] -  intoarce 1 daca a fost gasit end-of-file - https://octave.sourceforge.io/octave/function/feof.html
strrep[11] - inlocuieste toate aparitiile unui string dintr-unul dat cu alt string - https://octave.sourceforge.io/octave/function/strrep.html
strsplit[12] - imparte un sir de caractere in mai multe parti, folosind un separator (implicit spatiu) - https://octave.sourceforge.io/octave/function/strsplit.html
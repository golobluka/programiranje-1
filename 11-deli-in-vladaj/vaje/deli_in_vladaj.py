###############################################################################
# Želimo definirati pivotiranje na mestu za tabelo [a]. Ker bi želeli
# pivotirati zgolj dele tabele, se omejimo na del tabele, ki se nahaja med
# indeksoma [start] in [end].
#
# Primer: za [start = 0] in [end = 8] tabelo
#
# [10, 4, 5, 15, 11, 2, 17, 0, 18]
#
# preuredimo v
#
# [0, 2, 5, 4, 10, 11, 17, 15, 18]
#
# (Možnih je več različnih rešitev, pomembno je, da je element 10 pivot.)
#
# Sestavi funkcijo [pivot(a, start, end)], ki preuredi tabelo [a] tako, da bo
# element [ a[start] ] postal pivot za del tabele med indeksoma [start] in
# [end]. Funkcija naj vrne indeks, na katerem je po preurejanju pristal pivot.
# Funkcija naj deluje v času O(n), kjer je n dolžina tabele [a].
#
# Primer:
#
#     >>> a = [10, 4, 5, 15, 11, 2, 17, 0, 18]
#     >>> pivot(a, 1, 7)
#     3
#     >>> a
#     [10, 2, 0, 4, 11, 15, 17, 5, 18]
###############################################################################
def zamakni(sez, stevec, razmik):
    for i in range(razmik, 0, -1):
        temp = sez[stevec+i]
        sez[stevec+i] = sez[stevec+i-1]
        sez[stevec+i-1] = temp
    return sez

def pivot(sez, minimum, maximum):
    razmik = 1
    stevec = minimum
    while razmik + stevec < maximum:
        if  sez[stevec] > sez[stevec+razmik]:
            sez = zamakni(sez, stevec, razmik)
            stevec += 1

        else:
            razmik += 1

    return stevec

ary = [4,2,7,1,3] 
print(pivot(ary, 0 , 5))
print(ary)

# def pivot2(a, start, end):
#     p = a[start]
#     left = start
#     right = end
#     while left != right:
#         if a[left] <= p:
#             left += 1
#         elif p < a[right]:
#             right -= 1
        

###############################################################################
# V tabeli želimo poiskati vrednost k-tega elementa po velikosti.
#
# Primer: Če je
#
#     >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
#
# potem je tretji element po velikosti enak 5, ker so od njega manši elementi
#  2, 3 in 4. Pri tem štejemo indekse od 0 naprej, torej je "ničti" element 2.
#
# Sestavite funkcijo [kth_element(a, k)], ki v tabeli [a] poišče [k]-ti
# element po velikosti. Funkcija sme spremeniti tabelo [a]. Cilj naloge je, da
# jo rešite brez da v celoti uredite tabelo [a].
###############################################################################

def kti_element(a, k, start = 0, stop = None):
    if stop == None:
        stop = len(a)
    if k >= stop:
        return "Indeks k izven seznama!"
    
    index_p = pivot(a, start, stop)
    if index_p > k:
        return kti_element(a, k, start, index_p)
    elif index_p < k:
        return kti_element(a, k, index_p+1, stop)
    else:
        return a[index_p] 




# Run
# a = [2, 3, 8, 1, 4, 0]
# print(kti_element(a, 1))

#########################################################
# Tabelo a želimo urediti z algoritmom hitrega urejanja (quicksort).
#
# Napišite funkcijo [quicksort(a)], ki uredi tabelo [a] s pomočjo pivotiranja.
# Poskrbi, da algoritem deluje 'na mestu', torej ne uporablja novih tabel.
#
# Namig: Definirajte pomožno funkcijo [quicksort_part(a, start, end)], ki
#        uredi zgolj del tabele [a].
#
#     >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
#     >>> quicksort(a)
#     [2, 3, 4, 5, 10, 11, 15, 17, 18]
###############################################################################

def quicksort(a, start = 0, stop=None):
    if stop == None:
        stop = len(a)
    p = pivot(a, start, stop)
    if p - start > 1: #Če je spodnji seznam dolžine več kot ena.
        quicksort(a, start, p)
    if stop - (p + 1) > 1: #Če je zgornji seznam dolžine več kot ena.
        quicksort(a, p+1, stop)
    



ary = [6, 2, 3,1, 8, 9, 0, 13]
print(ary)
quicksort(ary)
print(ary)

###############################################################################
# Če imamo dve urejeni tabeli, potem urejeno združeno tabelo dobimo tako, da
# urejeni tabeli zlijemo. Pri zlivanju vsakič vzamemo manjšega od začetnih
# elementov obeh tabel. Zaradi učinkovitosti ne ustvarjamo nove tabele, ampak
# rezultat zapisujemo v že pripravljeno tabelo (ustrezne dolžine).
# 
# Funkcija naj deluje v času O(n), kjer je n dolžina tarčne tabele.
# 
# Sestavite funkcijo [zlij(target, begin, end, list_1, list_2)], ki v del 
# tabele [target] med start in end zlije tabeli [list_1] in [list_2]. V primeru, 
# da sta elementa v obeh tabelah enaka, naj bo prvi element iz prve tabele.
# 
# Primer:
#  
#     >>> list_1 = [1,3,5,7,10]
#     >>> list_2 = [1,2,3,4,5,6,7]
#     >>> target = [-1 for _ in range(len(list_1) + len(list_2))]
#     >>> zlij(target, 0, len(target), list_1, list_2)
#     >>> target
#     [1,1,2,3,3,4,5,5,6,7,7,10]
#
###############################################################################

def zlij(target, begin, end, list_1, list_2):
    i1 = 0
    i2 = 0
    while (i1 < len(list_1)) and (i2 < len(list_2)):
        if list_1[i1] <= list_2[i2]:
            target[begin + i1 + i2] = list_1[i1]
            i1 += 1
        else:
            target[begin + i1 + i2] = list_2[i2]
            i2 += 1

    while i1 < len(list_1):
        target[begin + i1 + i2] = list_1[i1]
        i1 += 1

    while i2 < len(list_2):
        target[begin + i1 + i2] = list_2[i2]
        i2 += 1

    return target


###############################################################################
# Tabelo želimo urediti z zlivanjem (merge sort). 
# Tabelo razdelimo na polovici, ju rekurzivno uredimo in nato zlijemo z uporabo
# funkcije [zlij].
#
# Namig: prazna tabela in tabela z enim samim elementom sta vedno urejeni.
#
# Napišite funkcijo [mergesort(a)], ki uredi tabelo [a] s pomočjo zlivanja.
# Za razliko od hitrega urejanja tu tabele lahko kopirate, zlivanje pa je 
# potrebno narediti na mestu.
#
# >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
# >>> mergesort(a)
# [2, 3, 4, 5, 10, 11, 15, 17, 18]
###############################################################################

def mergesort(a, begin=0, end=None):
    if end is None:
        end = len(a)
    
    if (begin < end-1): #Preveri ali imamo seznam dolžine vsaj 2
        midpoint = (begin+end) // 2
        mergesort(a, begin, midpoint)
        mergesort(a, midpoint, end)

        prvi = a[begin:midpoint]
        drugi = a[midpoint:end]

        return zlij(a, begin, end, prvi, drugi)
    else:
        return a


# print(mergesort([1,2,8,3,5,9,4]))
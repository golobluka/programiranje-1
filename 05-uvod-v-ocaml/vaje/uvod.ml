
(* ========== Vaja 1: Uvod v OCaml  ========== *)

let rec fib = function
  | 0 -> 0
  | 1 -> 1
  | n -> fib (n - 1) + fib (n -2)

let hitri_fib n = 
  let rec aux n a b = 
    if n = 0 then a else aux (n - 1) b (a + b)
  in aux n 0 1


let rec je_sodo = function
  | 0 -> true
  | n -> je_liho (n - 1)

and je_liho = function
  | 0 -> false
  | n -> je_sodo(n - 1)

let razdalja koord1 koord2 = 
  let dx = fst koord1 -. fst koord2
  and dy = snd koord1 -. snd koord2
  in sqrt (dx ** 2. +. dy ** 2.)

let skalarni_produkt (x1, x2, x3) (y1, y2, y3) = 
  x1 *. y1 +. x2 *. y2 +. x3 *. y3


(*----------------------------------------------------------------------------*]
 Funkcija [square] vrne kvadrat podanega celega števila.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # square 2;;
 - : int = 4
[*----------------------------------------------------------------------------*)

let rec square x = x * x



(*----------------------------------------------------------------------------*]
 Funkcija [middle_of_triple] vrne srednji element trojice.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # middle_of_triple (true, false, true);;
 - : bool = false
[*----------------------------------------------------------------------------*)
let trip = (1, "Miha", 12.3)

let rec middle_of_triple (_, druga, _) =  druga

let rec middle_of_triple_2 triple = 
  let naredi_par x = (x,x) in
  let (prva, druga, tretja) = triple in
  naredi_par druga



(*----------------------------------------------------------------------------*]
 Funkcija [starting_element] vrne prvi element danega seznama. V primeru
 prekratkega seznama vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # starting_element [1; 2; 3; 4];;
 - : int = 1
[*----------------------------------------------------------------------------*)

let rec starting_element  seznam =
  match seznam with
  | a :: []  -> a 
  | _ :: b :: _ -> b 
  | [] -> failwith "Podal si prazen seznam."




(*----------------------------------------------------------------------------*]
 Funkcija [multiply] zmnoži vse elemente seznama. V primeru praznega seznama
 vrne vrednost, ki je smiselna za rekurzijo.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # multiply [2; 4; 6];;
 - : int = 48
[*----------------------------------------------------------------------------*)

let rec multiply sez =
  match sez with
  | e :: tail -> e * (multiply tail)
  | [] -> 1 

let rec multiply_func = function
  | e::tail -> e * multiply_func tail
  | [] -> 1


(*----------------------------------------------------------------------------*]
 Napišite funkcijo ekvivalentno python kodi:

  def sum_int_pairs(pair_list):
      if len(pair_list) == 0:
        return []
      else:
        x, y = pair_list[0]
        return [x + y] + sum_int_pairs(pair_list[1:])

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # sum_int_pairs [(1, -2); (3, 4); (0, -0)];;
 - : int list = [-1; 7; 0]
[*----------------------------------------------------------------------------*)

let rec sum_int_pairs = function
  | [] -> []
  | head :: tail -> (
    let (prvi, drugi) = head in 
    (prvi + drugi) :: (sum_int_pairs tail)
    )

(*----------------------------------------------------------------------------*]
 Funkcija [get k list] poišče [k]-ti element v seznamu [list]. Številčenje
 elementov seznama (kot ponavadi) pričnemo z 0. Če je k negativen, funkcija
 vrne ničti element. V primeru prekratkega seznama funkcija vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # get 2 [0; 0; 1; 0; 0; 0];;
 - : int = 1
[*----------------------------------------------------------------------------*)

let rec get k list = 
  match list with
  | [] -> failwith "Pre kratek seznam"
  | a :: rest -> (if k <= 0 then a else get (k-1) rest)

(*----------------------------------------------------------------------------*]
 Funkcija [double] podvoji pojavitve elementov v seznamu.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # double [1; 2; 3];;
 - : int list = [1; 1; 2; 2; 3; 3]
[*----------------------------------------------------------------------------*)

let rec repeat_list x n = 
match (x, n)   with
| x, 1 -> x :: []
| x, n -> x :: repeat_list  x (n-1)



let rec double sez = 
match sez with
| [] -> []
| x :: rest -> x :: x :: double rest


(*----------------------------------------------------------------------------*]
 Funkcija [insert x k list] na [k]-to mesto seznama [list] vrine element [x].
 Če je [k] izven mej seznama, ga funkcija doda na začetek oziroma na konec.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # insert 1 3 [0; 0; 0; 0; 0];;
 - : int list = [0; 0; 0; 1; 0; 0]
 # insert 1 (-2) [0; 0; 0; 0; 0];;
 - : int list = [1; 0; 0; 0; 0; 0]
[*----------------------------------------------------------------------------*)

let rec insert_2 x k list = 
  match list with
  | [] -> [x]
  | head :: tail -> (
    if k <= 0 then x :: head :: tail
    else head :: (insert_2 x (k-1) tail)
  )



let rec insert x k seznam =
  match seznam with
  | [] -> [x]
  | head :: tail ->(
    if k <= 0 then x :: head :: tail
    else head :: (insert x (k-1) tail)
  ) 
  

(*----------------------------------------------------------------------------*]
 Funkcija [divide k list] seznam razdeli na dva seznama. Prvi vsebuje prvih [k]
 elementov, drugi pa vse ostale. Funkcija vrne par teh seznamov. V primeru, ko
 je [k] izven mej seznama, je primeren od seznamov prazen.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # divide 2 [1; 2; 3; 4; 5];;
 - : int list * int list = ([1; 2], [3; 4; 5])
 # divide 7 [1; 2; 3; 4; 5];;
 - : int list * int list = ([1; 2; 3; 4; 5], [])
[*----------------------------------------------------------------------------*)

let rec divide k list  =  
  match (k, list) with
  | ( 0, list') -> ([], list')
  | (k', head :: tail) ->  (
      let (prvi, drugi) = divide (k' - 1) tail in 
      (head :: prvi , drugi)
  )
  | (_, []) -> ([], [])
(*----------------------------------------------------------------------------*]
 Funkcija [rotate n list] seznam zavrti za [n] mest v levo. Predpostavimo, da
 je [n] v mejah seznama.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # rotate 2 [1; 2; 3; 4; 5];;
 - : int list = [3; 4; 5; 1; 2]
[*----------------------------------------------------------------------------*)

let rec rotate n list = 
  match n, list with
  | (0, a) -> a 
  | (n', a :: rest) -> rotate (n-1) (rest @ [a])
  | (_, []) -> failwith "Tole je napaka"




let rec rotate_2 n list = 
  let seznam1, seznam2 = divide n list in 
  seznam2 @ seznam1


(*----------------------------------------------------------------------------*]
 Funkcija [remove x list] iz seznama izbriše vse pojavitve elementa [x].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # remove 1 [1; 1; 2; 3; 1; 2; 3; 1; 1];;
 - : int list = [2; 3; 2; 3]
[*----------------------------------------------------------------------------*)

let rec remove x list = 
  match list with
  | [] -> []
  | a :: rest -> if (a = x) then (remove x rest) else a ::(remove x rest)

(*----------------------------------------------------------------------------*]
 Funkcija [is_palindrome] za dani seznam ugotovi ali predstavlja palindrom.
 Namig: Pomagaj si s pomožno funkcijo, ki obrne vrstni red elementov seznama.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # is_palindrome [1; 2; 3; 2; 1];;
 - : bool = true
 # is_palindrome [0; 0; 1; 0];;
 - : bool = false
[*----------------------------------------------------------------------------*)

let rec is_palindrome list =
  let rec obrni l = match l with
    | [] -> []
    | a :: xs -> obrni xs @ [a]
  in
  list = obrni list

(*----------------------------------------------------------------------------*]
 Funkcija [max_on_components] sprejme dva seznama in vrne nov seznam, katerega
 elementi so večji od istoležnih elementov na danih seznamih. Skupni seznam ima
 dolžino krajšega od danih seznamov.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # max_on_components [5; 4; 3; 2; 1] [0; 1; 2; 3; 4; 5; 6];;
 - : int list = [5; 4; 3; 3; 4]
[*----------------------------------------------------------------------------*)

let rec max_on_components l1 l2 = match (l1, l2) with
  | ([], _) -> []
  |(_, []) -> []
  |(x :: xs, y :: ys) -> (if x > y then x else y) :: max_on_components xs ys

(*----------------------------------------------------------------------------*]
 Funkcija [second_largest] vrne drugo največjo vrednost v seznamu. Pri tem se
 ponovitve elementa štejejo kot ena vrednost. Predpostavimo, da ima seznam vsaj
 dve različni vrednosti.
 Namig: Pomagaj si s pomožno funkcijo, ki poišče največjo vrednost v seznamu.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # second_largest [1; 10; 11; 11; 5; 4; 10];;
 - : int = 10
[*----------------------------------------------------------------------------*)
let rec largest_element sez = 
  match sez with
  | [] -> failwith "Prazni seznam nima maksimalnega elementa"
  | head' :: [] -> head'
  | head :: tail -> max head (largest_element tail)

let rec remove_1_from_list x sez = 
   match sez with
   | [] -> failwith "sseznam je prazen!"
   | head :: tail -> (
      if head = x then tail else head :: (remove_1_from_list x tail)
   )


let rec nth_largest n sez = 
  match (n, sez) with
  | (1, sez'') -> largest_element sez
  | (n', sez') -> nth_largest  (n-1) (remove_1_from_list (largest_element sez) sez)

let rec second_largest = ()

let je_seznam_prazen sez = 
  match sez with
  | [] -> true
  | _::_ -> false




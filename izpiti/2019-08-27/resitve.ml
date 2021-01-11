
let odstej_trojici (n1, m1, k1) (n2, m2, k2) = (n1-n2, m1-m2, k1-k2)

let max_rezultat_do_n f n = 
    let rec iterator maksimalni k =
        match maksimalni with
        | None -> iterator (Some (f k)) (k-1)
        | Some m  -> (
            if k < 0 then m
            else iterator (Some (max m (f k))) (k-1)
            )
    in
    iterator None n 

let max_rezultat_do_n_2 f n = 
    let sez = List.init (n+1) f in
    match sez with
    | [] -> failwith "n mora biti pozitiven!!!"
    | glava :: rep ->
        List.fold_left max glava rep

(* max_rezultat_do_n_2 (fun x -> -x) 5 *)

let pocisti_seznam sez = 
    List.filter_map (fun x -> x) sez


let preveri_urejenost l = 
    let rec aux min_sodo max_liho = function
        | [] -> true
        | x :: xs -> 
            if x mod 2 == 0 
                then  x >= min_sodo &&  aux x max_liho xs
            else  x <= max_liho && aux min_sodo x xs
    in
    aux (-9999) 99999 l


(* Druga naloga *)

type 'a gnezdenje = 
    | Element of 'a 
    | Podseznam of 'a gnezdenje list 

let gnezdenje_primer = [Element 1;
    Element 2; 
    Podseznam [Element 3; 
        Podseznam [Element 4]; 
        Podseznam []];
    Podseznam [Element 5]]

let rec najvecja_globina sez = 
    cez_seznam 1 sez
and cez_seznam maksimalni  = function
    | [] -> maksimalni
    | Element _ :: rep  -> cez_seznam maksimalni rep
    | Podseznam sez :: rep-> cez_seznam (max ((najvecja_globina sez) + 1) maksimalni) rep

let rec preslikaj f = function
    | [] -> []
    | Element a :: rep -> Element (f a) :: preslikaj f rep
    | Podseznam sez :: rep' -> Podseznam (preslikaj f sez) :: (preslikaj f rep')

let splosci sez = 
    let rec cez_seznam acc = function
        | [] -> acc
        | Element a :: rep ->  cez_seznam (a :: acc) rep
        | Podseznam sez' :: rep -> cez_seznam ((cez_seznam [] sez') @ acc) rep
    in
    List.rev (cez_seznam [] sez)

let rec alternirajoci_konstruktorji sez = 
    match sez with
    | [] | [_] -> true
    | Element a :: (Podseznam sez :: rep as t) -> alternirajoci_konstruktorji t 
    | Podseznam sez :: (Element a :: rep as t) -> alternirajoci_konstruktorji t 
    | _ -> false


let rec  zlozi_preko_gnezdenja f acc sez = 
    match sez with
    | [] -> acc
    | Element a :: rep -> zlozi_preko_gnezdenja f (f a acc) rep
    | Podseznam sez'  :: rep -> 
    zlozi_preko_gnezdenja f (List.fold_left (zlozi f) acc sez') rep

and zlozi f acc gnez = 
        match gnez with 
        | Element a -> f a acc
        | Podseznam sez -> zlozi_preko_gnezdenja f acc sez


(*zlozi_preko_gnezdenja max 0 gnezdenje_primer
out: 5*)
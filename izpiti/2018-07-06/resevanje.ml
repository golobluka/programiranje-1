(*Naloga 1*)


let uporabi f x = f x

let ibaropu x f = f x

let zacetnih n sez = 
    let rec aux k acc sez = 
        if k <= 0 then Some (List.rev acc)
        else match sez with
            | [] -> None
            | glava :: rep -> aux (k-1) (glava :: acc) rep
    in
    aux n [] sez

(* Naloga 2 *)

type 'a neprazen_sez = 
    | Konec of 'a 
    | Sestavljen of 'a * 'a neprazen_sez

let prvi sez = 
    match sez with
    | Konec x -> x
    | Sestavljen (y , _) -> y

let rec zadnji sez =
    match sez with
    | Konec x -> x
    | Sestavljen (_ , sez2) -> zadnji sez2

let rec zlozi f acc sez = 
    match sez with
    | Sestavljen (x, sez') -> zlozi f (f acc x) sez'
    | Konec y -> f acc y

(*zlozi max 0 (Sestavljen(3, Sestavljen(4, Sestavljen(3, Konec 2))))*)

(*Naloga 3*)

let simetricen niz =
    let l = String.length niz - 1 in 
    let rec aux stevec =
        if stevec >= (l + 1) / 2 then true
        else if niz.[stevec] = niz.[l - stevec] then aux (stevec+1)
        else false
    in 
    aux 0

let simetricen_na start stop niz = 
    let l = stop - start in
    let rec aux stevec =
        if stevec >= l / 2 then true
        else if niz.[start+stevec] = niz.[start+l-stevec - 1] then aux (stevec+1)
        else false
    in 
    aux 0



let razdeli niz = 
    let l = String.length niz in
    let rec na_najvec najvec = 
        let rec razdeli_na n start =
            let generiraj a  = 
                if n = 1 then [l - start]
                else List.init (l-start-n) (fun x -> x+1) 
            in
            let rec cez_stevce stevci = 
                match stevci with
                | [] -> []
                | glava :: rep -> (
                    if simetricen_na start (start+glava) niz
                        then 
                        let odgovor =  razdeli_na (n-1) (start+glava)  in
                        if odgovor  = [] 
                            then cez_stevce rep
                        else glava :: odgovor
                    else
                        cez_stevce rep
                )
            in
            if start = l then [l]
            else
                let stevci = generiraj () in
                cez_stevce stevci
        in
        let odgovor =  razdeli_na najvec 0 in 
        if odgovor = []
            then na_najvec (najvec+1)
        else odgovor
    in
    na_najvec 1

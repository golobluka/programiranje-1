let option_sum s1 s2 = 
    match s1, s2 with
    | None , _ | _, None -> None
    | Some a, Some b -> Some (a+b)

let twostep_map razvoj f1 f2 x = 
    let x1, x2 = razvoj x in 
    (f1 x1, f2 x2)

let function_repeat f sez = 
    let rec pripni_nterico sez x n = 
        if n <= 0 then sez
        else pripni_nterico (x :: sez) x (n-1) 
    in
    let rec aux acc  = function 
        | [] -> acc
        | glava :: rep -> (
            aux (pripni_nterico acc glava (f glava)) rep
        )
    in
    List.rev (aux [] sez)

type  'a improved_list = 
    | Prazen 
    | Seznam of ('a array) * 'a improved_list


let test = Seznam ([|1;2;20|], Seznam ([|17;19;20;30|], Seznam ([|100|], Prazen)))

let rec count imp_sez  = 
    match imp_sez with
    | Prazen -> 0
    | Seznam (ary, imp_sez2) -> Array.length ary + (count imp_sez2)

let rec nth n = function
    | Prazen -> None
    | Seznam (ary, imp_sez2) -> (
        if Array.length ary <= n 
            then nth (n - (Array.length ary)) imp_sez2
        else
            Some (Array.get ary n)
    )

let is_sorted ary  =
    let rec urejen_nabor stevec ary =
        if stevec >= (Array.length ary -1)
            then true 
        else if ary.(stevec) > ary.(stevec+1)
            then false
        else urejen_nabor (stevec+1) ary
    in
    let rec aux prejsnji = function
        | Prazen -> true
        | Seznam (ary, imp_sez2) -> (
            match prejsnji with
            | None -> if urejen_nabor 0 ary 
                then aux (Some ary.((Array.length ary) - 1)) imp_sez2
                else false
            | Some z -> (
                if ary.(0) > z && urejen_nabor 0 ary
                then aux (Some ary.((Array.length ary) - 1)) imp_sez2
            else false
            )
        )
    in
    aux None ary 

let rec update imp_sez n a =
    let kopija_spremenjenega n a ary = 
        Array.mapi (fun m b -> if m = n then a else b) ary 
    in
    match imp_sez with
        |Prazen -> Prazen
        | Seznam (ary, imp_sez2) -> (
            let l = Array.length ary in
            if l > n 
                then Seznam (kopija_spremenjenega n a ary, imp_sez2)
            else 
                Seznam (ary, update imp_sez2 (n-l) a)
        )


let rec stevilo_postavitev n m l = 
    if m * l + (m-1) > n || m < 0 || l <=0  then 0
    else if m * l + (m-1) = n then 1
    else if m = 1 then n - (l-1)
    else induktivni_korak n m l

and induktivni_korak n m l = 
    if m * l + (m-1) < n then 0
    else if m * l + (m-1) = n then 1
    else
        stevilo_postavitev (n-(l+1)) (m-1) l + 
        induktivni_korak (n-1) m l








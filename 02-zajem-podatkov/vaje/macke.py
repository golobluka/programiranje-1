import csv
import os
import re
import requests

###############################################################################
# Najprej definirajmo nekaj pomožnih orodij za pridobivanje podatkov s spleta.
###############################################################################

# definirajte URL glavne strani bolhe za oglase z mačkami
cats_frontpage_url = 'http://www.bolha.com/zivali/male-zivali/macke/'
# mapa, v katero bomo shranili podatke
cat_directory = 'zajeti_podatki'
# ime datoteke v katero bomo shranili glavno stran
frontpage_filename = 'prva_stran'
# ime CSV datoteke v katero bomo shranili podatke
csv_filename = 'csv_datoteka'


def download_url_to_string(url):
    """Funkcija kot argument sprejme niz in poskusi vrniti vsebino te spletne
    strani kot niz. V primeru, da med izvajanje pride do napake vrne None.
    """
    try:
        # del kode, ki morda sproži napako

        return requests.get(url)
    except Exception:
        # koda, ki se izvede pri napaki
        # dovolj je če izpišemo opozorilo in prekinemo izvajanje funkcije
        print("Prislo je do napake pri povezovanju!")
        return None
        raise NotImplementedError()
    if page_content.status_code == requests.codes.ok:
        return page_content.text
    
    print('Težava pri vsebini strani.')
    return None
    # nadaljujemo s kodo če ni prišlo do napake
    raise NotImplementedError()


def save_string_to_file(text, directory, filename):
    """Funkcija zapiše vrednost parametra "text" v novo ustvarjeno datoteko
    locirano v "directory"/"filename", ali povozi obstoječo. V primeru, da je
    niz "directory" prazen datoteko ustvari v trenutni mapi.
    """
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w', encoding='utf-8') as file_out:
        file_out.write(text)
    return None


# Definirajte funkcijo, ki prenese glavno stran in jo shrani v datoteko.


def save_frontpage(page, directory, filename):
    """Funkcija shrani vsebino spletne strani na naslovu "page" v datoteko
    "directory"/"filename"."""
    html = download_url_to_string(page)
    if html:
        save_string_to_file(html.text, directory, filename)
        return True
    return False

    raise NotImplementedError()


###############################################################################
# Po pridobitvi podatkov jih želimo obdelati.
###############################################################################


def read_file_to_string(directory, filename):
<<<<<<< HEAD
    """Funkcija vrne celotno vsebino datoteke "directory"/"filename" kot niz"""
    with open (os.path.join(directory, filename), encoding = 'utf-8') as f:
        return f.read()
    
=======
    """Funkcija vrne celotno vsebino datoteke "directory"/"filename" kot niz."""
    raise NotImplementedError()
>>>>>>> 742481b5fc88ab201f4fa86910674b226ceac14f


# Definirajte funkcijo, ki sprejme niz, ki predstavlja vsebino spletne strani,
# in ga razdeli na dele, kjer vsak del predstavlja en oglas. To storite s
# pomočjo regularnih izrazov, ki označujejo začetek in konec posameznega
# oglasa. Funkcija naj vrne seznam nizov.


def page_to_ads(page_content):
<<<<<<< HEAD
    """Funkcija poišče posamezne ogllase, ki se nahajajo v spletni strani in
    vrne njih seznam"""
    pattern = re.compile('<li class="EntityList-item EntityList-item--Regular(.*?)</article>', re.DOTALL)
    return re.findall(pattern, page_content)
    
=======
    """Funkcija poišče posamezne oglase, ki se nahajajo v spletni strani in
    vrne seznam oglasov."""
    raise NotImplementedError()
>>>>>>> 742481b5fc88ab201f4fa86910674b226ceac14f


# Definirajte funkcijo, ki sprejme niz, ki predstavlja oglas, in izlušči
# podatke o imenu, lokaciji, datumu objave in ceni v oglasu.


def get_dict_from_ad_block(block):
    """Funkcija iz niza za posamezen oglasni blok izlušči podatke o imenu, ceni
<<<<<<< HEAD
    in opisu ter vrne slovar, ki vsebuje ustrezne podatke
    """
    
    pattern = r'alt="(?P<naslov_oglasa>.*?)"'
    result = re.search(pattern, block, re.DOTALL)
    return result.groupdict()
=======
    in opisu ter vrne slovar, ki vsebuje ustrezne podatke."""
    raise NotImplementedError()
>>>>>>> 742481b5fc88ab201f4fa86910674b226ceac14f


# Definirajte funkcijo, ki sprejme ime in lokacijo datoteke, ki vsebuje
# besedilo spletne strani, in vrne seznam slovarjev, ki vsebujejo podatke o
# vseh oglasih strani.


def ads_from_file(filename, directory):
    """Funkcija prebere podatke v datoteki "directory"/"filename" in jih
    pretvori (razčleni) v pripadajoč seznam slovarjev za vsak oglas posebej."""
    data = read_file_to_string(directory, filename)
    ad_blocks = page_to_ads(data)
    
    return [
        get_dict_from_ad_block(ad) for ad in ad_blocks
    ]


###############################################################################
# Obdelane podatke želimo sedaj shraniti.
###############################################################################


def write_csv(fieldnames, rows, directory, filename):
    """
    Funkcija v csv datoteko podano s parametroma "directory"/"filename" zapiše
    vrednosti v parametru "rows" pripadajoče ključem podanim v "fieldnames"
    """
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w', encoding='utf-8') as csv_file:
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def write_csv_moja(filednames, rows, dictionary, filename):
    os.makedirs(dictionary, exist_ok=True)
    path = os.path.join(dictionary, filename)

    with open(path, 'w', encoding='utf-8') as csv_file:
        for row in rows:
            csv_file.write(filednames + ',' + row + '\n')
        

# Definirajte funkcijo, ki sprejme neprazen seznam slovarjev, ki predstavljajo
# podatke iz oglasa mačke, in zapiše vse podatke v csv datoteko. Imena za
# stolpce [fieldnames] pridobite iz slovarjev.


def write_cat_ads_to_csv(ads, directory, filename):
    """Funkcija vse podatke iz parametra "ads" zapiše v csv datoteko podano s
    parametroma "directory"/"filename". Funkcija predpostavi, da so ključi vseh
    slovarjev parametra ads enaki in je seznam ads neprazen."""
    # Stavek assert preveri da zahteva velja
    # Če drži se program normalno izvaja, drugače pa sproži napako
    # Prednost je v tem, da ga lahko pod določenimi pogoji izklopimo v
    # produkcijskem okolju
    #assert ads and (all(j.keys() == ads[0].keys() for j in ads))
    rows = []
    filednames = [name for name in ads[0].keys()][0]
    for ad in ads:
        rows.append([naslov for naslov in ad.values()][0])
    
    write_csv_moja(filednames, rows, directory, filename)


    


# Celoten program poženemo v glavni funkciji

def main(redownload=True, reparse=True):
    """Funkcija izvede celoten del pridobivanja podatkov:
    1. Oglase prenese iz bolhe
    2. Lokalno html datoteko pretvori v lepšo predstavitev podatkov
    3. Podatke shrani v csv datoteko
    """
    # Najprej v lokalno datoteko shranimo glavno stran
    # save_frontpage(cats_frontpage_url, cat_directory, frontpage_filename )
    # # Iz lokalne (html) datoteke preberemo podatke

<<<<<<< HEAD
    # html_data = read_file_to_string(cat_directory, frontpage_filename)
    # ads = page_to_ads(html_data)
    # print(ads[0])
    # Podatke prebermo v lepšo obliko (seznam slovarjev)
    ads = ads_from_file(frontpage_filename,cat_directory)
    print(ads)
=======
    # Iz lokalne (html) datoteke preberemo podatke

    # Podatke preberemo v lepšo obliko (seznam slovarjev)
>>>>>>> 742481b5fc88ab201f4fa86910674b226ceac14f

    # Podatke shranimo v csv datoteko
    write_cat_ads_to_csv(ads, cat_directory, csv_filename)

    # Dodatno: S pomočjo parametrov funkcije main omogoči nadzor, ali se
    # celotna spletna stran ob vsakem zagon prenese (četudi že obstaja)
    # in enako za pretvorbo



if __name__ == '__main__':
    main()

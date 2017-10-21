## Exo2
1.
    `od donnees.bin` <kbd>RET</kbd>
    ```bash
    0000000 000443 000312 000000 177414 177777 177777 177777 071107
    0000020 002400 064502 066154 000171
    0000027
    ```
    *`od`, par defaut, affiche en octal octet par octet d'un fichier, en utilisant l'endianness ( little endian)*
    
    - sous forme hex: `od -t x1`
    - soud forme dec: `od -t d1`
    - afficher 1 octet par ligne: `od -t x1 -w1`

2. 
     - le champ 1 correspond à "l'offset" qui permet de donner la position dans la quelle on est dans le fichier == décalage par rapport au début du fichier.
     - par defaut sans argument `od` affiche 16 octet par ligne
     - par defaut `od` affiche de l'octal
     - `-A[doxn]` pour changer le format de l'offset


```txt
000 443 ( en octal)
0000 0001 0010 0011 [ echange des deux octets ] 0010 0011 0000 0001
                                                --------- ---------      
                                                     0x23      0x01
```
3.
`od -t x1 -v -N8 donnees.bin`  `-N8` = _pour limiter aux 8 premiers octects_

~~permet d'avoir un affichage en hexa et pas d'avoir de problème d'endianness et de lire dans le bon ordre.~~

## Exo3

Q2:
    `hexedit Secret.class`
	 - mot à trouver: sEcRet
3.
4.
    `hexedit Secret.class` <kbd>RET</kbd>
  	  - Tab (Basculer à la vue ascii et inversement)
	  - Modifier le mot sEcRet
	  - <kbd>Ctrl-X</kbd> ( sauver et quitter)
	  


## Exo4

1. $ `cho "ABCé" > texte.utf8`

2. nombre d'octet
   $ `wc -c texte.utf8`

3. nombre de car
   $ `wc -m texte.utf8`

4. texte.utf8
    - 5 car ( 6 caratère avec la fin de ligne)
    - 8 octets ( 9 avec la fin de ligne)

5. `od -tx1 texte.utf8`
    ```txt
    41  42  43  c3 a9   e2 82 ac
    °°  °°  °°  °°°°°   °°°°°°°°
    A    B   C    é         €
    c3: 1100 0011
    e2: 1110 0010
    A->0x41:
    B->0x42:
    C->0x43:
    é->0xc3 0xa9 => U+00E9
    €->0xe2 0x82 0xac => U+20AC
    ```

9. `iconv texte.utf8 -t UTF-16 -o texte.utf16` convertir texte.utf8 en un fichier UTF-16 ( texte.utf16)
11. `iconv texte.utf16 -f UTF-16 -o texte.utf8` de UTF-16 vers UTF-8
12. `iconv texte.utf8 -t UTF-32 -o texte.utf32` (UTF-16 to UTF-32)


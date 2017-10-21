**EXO1**

1. `stats image.bmp`
```bash
	Fichier : « image.bmp »
	Taille : 374       	Blocs : 8          Blocs d'E/S : 1048576 fichier
	Périphérique : 24h/36d	Inœud : 121390972   Liens : 1
	Accès : (0644/-rw-r--r--)  UID : ( 1377/    sowy)   GID : ( 1005/ infoetu)
	Accès : 2017-10-10 10:57:36.000000000 +0200
	Modif. : 2015-06-05 10:55:58.000000000 +0200
	Changt : 2017-10-10 10:57:36.277155254 +0200
	  Créé : -
```
2. `printf '%x\n' 374 -> 176`

3.  L'entête est sur 14octect donc on utilise `od -tx1 -N14 image.bmp`

4.
  - la signature est:     _0x42 0x4d_
  - la taille du fichier: _0x76 0x01 0x00 0x00_
  - l'offset de l'image:  _0x36 0x00 0x00 0x00_

5. La taille du fichier est la même qu'avec la commande stat

6. `od -tx1 -j14 -N40 image.bmp`

0000016 28 00 00 00 0a 00 00 00 0a 00 00 00 01 00 18 00
0000036 00 00 00 00 40 01 00 00 13 0b 00 00 13 0b 00 00
0000056 00 00 00 00 00 00 00 00
0000066


    - ** Permet de sauter les 14 premiers octects qui répresentent l'entête du fichier donc avec l'option -j et ensuite afficher les 40octets suivants qui permettent d'avoir l'entête de l'image. ** -

Q7:

 – la taille de l’entête de l’image : > od -tx1 -j14 -N4 image.bmp => 0x28 0x00 0x00 0x00
 – la largeur de l’image : > od -tx1 -j$((14+4)) -N4 image.bmp => 0x0a 0x00 0x00 0x00
 – la hauteur de l’image : > od -tx1 -j$((14+4+4)) -N4 image.bmp => 0x0a 0x00 0x00 0x00
 – la profondeur de chaque pixel : > od -tx1 -j$((14+4+4+4+2)) -N2 image.bmp => 0x18 0x00
 – la méthode de compression : > od -tx1 -j$((14+4+4+4+2+4)) -N4 image.bmp => 0x18 0x00
 => 00 00 40 01
 - la taille totale de l'image: > od -tx1 -j$((14+4+4+4+2+4+4)) -N4 image.bmp => 0x00 00 13 0b


=> ici palette de l'image est 0 car on a: echo $((374-(54+320))) = 0

donc le code la matrice de l'image est :

$ od -An -x -j54 -v -w30 image.bmp
 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff
 0000 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff
 ffff 0000 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff
 ffff ffff 0000 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff
 ffff ffff ffff 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000 0000 0000
 ffff ffff ffff ffff ffff ffff 0000 ffff ffff ffff ffff ffff ffff 0000 0000
 0000 ffff ffff ffff ffff ffff ffff 0000 ffff ffff ffff ffff ffff ffff 0000
 0000 0000 ffff ffff ffff ffff ffff ffff 0000 ffff ffff ffff ffff ffff ffff
 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
	   


>$ od -An -x -j54 -v -w32 image.bmp
 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000

Sur chaque ligne on doit avoir un multiple de 4, or ici on a 30 qui ne l'est pas et donc pour cooriger ça on doit ajouter 2 pour avoir 32 qui est un multiple de 4. 0n doit donc faire du "bourrage" qui consiste à ajouter des octets à 0 pour aller au multiple de 4 le plus proche strictement supérieur.


 ffffff ffffff ffffff ffffff 000000 000000 ffffff ffffff ffffff ffffff XXXX
 ffffff ffffff ffffff ffffff 000000 000000 ffffff ffffff ffffff ffffff XXXX
 ffffff ffffff ffffff ffffff 000000 000000 ffffff ffffff ffffff ffffff XXXX
 ffffff ffffff ffffff ffffff 000000 000000 ffffff ffffff ffffff ffffff XXXX
 000000 000000 000000 000000 000000 000000 000000 000000 000000 000000 XXXX
 000000 000000 000000 000000 000000 000000 000000 000000 000000 000000 XXXX
 ffffff ffffff ffffff ffffff 000000 000000 ffffff ffffff ffffff ffffff XXXX
 ffffff ffffff ffffff ffffff 000000 000000 ffffff ffffff ffffff ffffff XXXX
 ffffff ffffff ffffff ffffff 000000 000000 ffffff ffffff ffffff ffffff XXXX
 ffffff ffffff ffffff ffffff 000000 000000 ffffff ffffff ffffff ffffff XXXX

>$ od --endian=big -Ax -tx2 -j54 -v -w32 image.1.bmp 
000036 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
000056 ffff ffff 0000 ff00 00ff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
000076 ffff ffff 0000 ff00 00ff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
000096 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
0000b6 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000d6 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000f6 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
000116 ffff ff00 00ff 0000 ffff ffff 0000 0000 0000 ffff ff00 ff00 00ff 00ff ffff 0000
000136 ffff ff00 00ff 0000 ffff ffff 0000 0000 0000 ffff ff00 ff00 00ff 00ff ffff 0000
000156 ffff ffff ffff ffff ffff ffff 0000 0000 0000 ffff ffff ffff ffff ffff ffff 0000
000176
>$


EXO2: __ chasse au trésor __

$ od --endian=big -Ax -x -j54 -v -w32 secret.bmp | tac # puis regroupement en 3octect à la main
000176
000156 feffff feffff ffffff feffff 000000 000000 ffffff feffff feffff ffffff 00000 => 0010 1001 => 0x29 => )
000136 feffff feffff ffffff ffffff 000000 000000 ffffff feffff ffffff ffffff 00000 => 0011 1011 => 0x3B => ;
000116 feffff ffffff ffffff feffff 000000 000000 ffffff feffff feffff ffffff 00000 => 0110 1001 => 0x69 => i
0000f6 feffff ffffff ffffff feffff 000000 000000 ffffff ffffff ffffff feffff 00000 => 0110 1110 => 0x6D => m
0000d6 000000 000000 000000 000000 000000 000000 000000 000000 000000 000000 00000 => 
0000b6 000000 000000 000000 000000 000000 000000 000000 000000 000000 000000 00000 => 
000096 feffff ffffff ffffff feffff 000000 000000 ffffff feffff feffff ffffff 00000 => 0110 1001 => 0x69 => i
000076 feffff ffffff ffffff feffff 000000 000000 feffff ffffff ffffff feffff 00000 => 0110 0110 => 0x66 => f
000056 feffff feffff ffffff feffff 000000 000000 feffff feffff feffff feffff 00000 => 0010 0000 => 0x20 =>  
000036 feffff ffffff feffff feffff 000000 000000 feffff feffff ffffff ffffff 00000 => 0100 0011 => 0x43 => C


message caché (0x29 0x3B 0x69 0x6D 0x69 0x66 0x20 0x43)

printf "\\u0029\\u003B\\u0069\\u006D\\u0069\\u000\\u0043" | rev # pour decoder et afficher le message.

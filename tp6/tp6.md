## EXO 1 *Manipulation du système de fichiers*

1. dans le dossier **~asr** `mkdir tp6` <kbd>RET</kbd>
2. `cd tp6` pour se déplacer dans le répertoire **tp6**
3.
	- `mkdir -p fs/{a-faire,fait}`
	- `touch fs/a-faire/{Algo,Anglais,Math};touch fs/fait/{Algo,Gestion}`
	- `tree` <kbd>RET</kbd> pour voir l'arborescence

	  ```bash
	  ../tp6/
	  ├── fs
	  │   ├── a-faire
	  │   │   ├── Algo
	  │   │   ├── Anglais
	  │   │   └── Math
	  │   └── fait
	  │       ├── Algo
	  │       └── Gestion
  	  `̀``
4.
   1. `cd fs/a-faire/` pour se déplacer dans le répertoire **a-faire**
   2. `ls /home/infoetu/sowy/asr/tp6/fs/fait/Gestion` qui donne **/home/infoetu/sowy/asr/tp6/fs/fait/Gestion**
   3. `ls ./Algo` retourne **./Algo**
   4. `ls ../a-faire/Anglais` retourne **../a-faire/Anglais**
5. Vérification des chémins trouvé plus haut à la question **4**
   * `cat /home/infoetu/sowy/asr/tp6/fs/fait/Gestion`
   * `cat ./Algo`
   * `cat ../a-faire/Anglais`
6.
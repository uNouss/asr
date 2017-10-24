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
	  │   │   ├── Algo2
	  │   │   ├── Anglais
	  │   │   └── Math
	  │   └── fait
	  │       ├── Algo
	  │       └── Gestion
  	  `̀``
4.
   1. `cd fs/a-faire/` pour se déplacer dans le répertoire **a-faire**
   2. `ls /home/infoetu/sowy/asr/tp6/fs/fait/Gestion` qui donne **/home/infoetu/sowy/asr/tp6/fs/fait/Gestion**
   3. `ls ../fait/Algo` retourne **../fait/Algo**
   4. `ls ./Anglais` retourne **./Anglais**
5. Vérification des chémins trouvé plus haut à la question **4**
   * `cat /home/infoetu/sowy/asr/tp6/fs/fait/Gestion`
   * `cat ../fait/Algo`
   * `cat ./Anglais`
6.
   1. `cp Algo2 Algorithmique`
   2. `cp Algo2 ../fait/Algo`
   3. `mv Anglais English`
   4. `mv English ../fait/`
   5. `ln Math ../fait/Abandon`
   6. `echo -e "\nregret" > ../fait/Abandon`
   7. `cat Math` <kbd>RET</kbd>
      ```txt
      
      regret
      ```

   8.  `ln -s ../fait/Abandon Persevere` 
   9.  `cat Persevere` cat Persevere
       ```txt
       
       regret
       ```

   10.
   11.
   12.
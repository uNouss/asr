# Manipulations de processus

### Exercice 1: Manipulation de base

1. Démarrez la commande xeyes: `xeyes`
2. Essayez maintenant de démarrer une nouvelle fois la commande xeyes . Est-ce possible ? *Non*
3. Stoppez la commande démarrée en frappant simultanément les touches <kbd>Ctrl-Z</kbd>
4. Redémarrez la commande stoppée en arrière-plan: `bg`
5. Démarrez un nouveau processus en arrière plan exécutant la commande xeyes: `xeyes &`
6. Exécutez la ligne de commande suivante :
  `xeyes & xcalc & xlogo & xclock & xload & xterm & `

7. En utilisant la commande ps ainsi que les messages produits par la ligne de commande de la question précédente associez à chaque numéro de jobs démarré le nom du programme qu’il exécute:
   : `ps -j`

8. Vérifier votre réponse avec la commande jobs : `jobs`
9. Après avoir lu la page du manuel de la commande ps , déterminez graphiquement la hiérarchie des processus en cours. Quelle commande avez-vous utilisée ?
   ` ps f`

10. Arrêtez maintenant complètement les processus exécutant les commandes xlogo et xload en utilisant uniquement la commande kill que vous appliquez à des numéros de jobs (numéros généralement inférieur à 10) c’est-à-dire sans utiliser de PID : `jobs` pour avoir les numéros de jobs
    - xlogo : `kill -KILL %4`
    - xload : `kill -KILL %6`

11. Stoppez maintenant les processus exécutant les commandes xclock et xcalc en utilisant leur numéro de processus ( PID ). Pour stopper les processus vous devez envoyer le signal STOP aux processus concernés via la commande kill: `ps -j` pour voir les jobs avec les numéros de PID
    - xclock : `kill -STOP 13372`
    - xcalc  : `kill -STOP 13370`

12. Essayez de vous servir de la calculatrice. Que se passe-t-il ? : *Rien*

13. Utilisez la commande jobs pour faire le bilan des processus actuellement attachés à votre terminal (les jobs): `jobs`

14. Combien y a-t-il de processus stoppé ? en cours d’exécution ? Lesquels ? :

15. Faites redémarrer le processus exécutant xclock via l’envoi d’un signal ( CONT ) avec la commande kill à celui-ci: `kill -CONT %numero_jobs_xclock`

16. Le processus redémarre-t-il en arrière plan ou en avant-plan ?

17. Faites redémarrer le processus exécutant xcalc en avant plan via l’appel de la commande fg . Comment avez-vous du spécifier le processus : via son PID ou son numéro de job ? : `fg %numero_jobs`

18. Arrêtez le processus exécutant la commande xcalc sans utiliser la souris. Comment avez-vous fait ? <kbd>Ctrl-C</kbd>

19. Faites passer le processus exécutant la commande xclock en avant plan. Comment avez-vous fait ? : `fg %numero_jobs`

20. Stoppez-le, puis faites le redémarrer via la commande bg . Comment avez-vous du spécifier le processus : via son PID ou son numéro de job ? <kbd>Ctrl-Z</kbd> puis `bg`

21. Arrêtez tous les processus démarrés lors de cet exercice en une seule ligne de commande:
    `kill -KILL [liste_des_PID]`


### Exercice 2: Manipulation des processus et de leur état

1. Dans cet exercice vous allez utiliser une commande particulière nommée sleep . À l’aide du manuel informez-vous du comportement et de l’utilisation de cette commande. `man sleep`

2. Essayez et comparez les commandes suivantes :
   - ` sleep 3 ; echo A` : attend 3 secondes et affiche le caractère `A`
   - ` echo A ; sleep 3` : affiche le caractère `A` puis attend 3 seconde et revient au prompt
   - ` sleep 3 & echo A` : lance *sleep 3* et *echo A* en parallèle, *echo A* se termine avant avec la commande *sleep 3* est mis en arrière-plan pendant 3 secondes. 
   - ` echo A & sleep 3` : lance *sleep 3* et *echo A* en parallèle, *echo A* se termine en premier et la commande *sleep 3* continue pendant 3 seconde et se termine
   - ` (echo A ; sleep 3) &` : les commandes s'éxecutent en sequénce et en arrière plan, *echo A* est éxecuté pendant que *sleep 3* attend 3 secondes avant de se terminer
   - ` (sleep 3 ; echo A) &` : l'ensemble du bloc `()` est mis en attente en arrière plan pendant 3 secondes puis passe en avant plan et *echo A* est éxecutée.


3. Remplissez le tableau suivant, de façon à spécifier à quel moment le caractère A, le caractère B et le prompt du shell apparaîssent sur le terminal (par convention le caractère $ repésentera l’apparition du prompt) :


| Commandes                                 |  t=0s  |  t=3s  |  t=6s  |
|-------------------------------------------|: ----: |: -----:| -----: |
|`echo A ; sleep 3 ; echo B`                |`A`     |`B$`    |``      |
|`echo A ; sleep 3 & echo B`                |`AB`    |``      |``      |
|`( echo A ; sleep 3 ) & echo B`            |`BA`    |``      |``      |
|`echo A ; ( sleep 3 & echo B )`            |`AB`    |``      |``      |
|`echo A ; ( sleep 3 ; echo B ) &`          |`A`     |`$B`    |``      |
|`sleep 3 & echo A ; ( sleep 3 ; echo B )`  |`A`     |`B`     |``      |
|`sleep 3 & echo A & ( sleep 3 ; echo B )`  |`A`     |`B$`    |``      |
|`sleep 3 & echo A & ( sleep 3 & echo B ) &`|`AB`    |``      |``      |
|`sleep 3 & echo A & ( sleep 3 ; echo B ) &`|`A`     |`$B`    |``      |

4. Vérifiez vos réponses en exécutant les commandes de chacune des lignes.

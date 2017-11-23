# Un __chat__ simple

1. Démarrez deux terminaux graphiques (via la commande mate-terminal ) dont les fenêtres devront être nommées respectivement saisie et messages: `mate-terminal --title="saisie" & mate-terminal --title"message"`

2. Dans le terminal saisie , exécutez une commande qui fasse en sorte que les lignes saisies dans ce terminal, s’affichent dans le terminal messages: `cat > /dev/pts/2`

3. Arrêtez cette commande et modifiez là pour qu’elle ajoute les lignes saisies dans le fichier /home/public/m1101/forum : `cat >> /home/public/m1101/forum`

4. Dans le terminal messages , en vous aidant de la page tail(1) , exécutez une commande permettant de suivre en continu le contenu du fichier /home/public/m1101/forum .
   - dans le premier terminal : `cat >> /home/public/m1101/forum`
   - dans le second  terminal : `tail -f /home/puvlic/m1101/forum`

5. Modifiez la commande de saisie , pour qu’elle ajoute en début de chacune des lignes lues votre login suivi de « : ». Le fait que pour la commande s de sed le caractère ^ représente le début d’une ligne et l’option -u de sed devraient vous aider: `cat | sed -u 's/^/USERS: /g' >> /home/public/m1101/forum`

6. Créez un fichier nommé invisibles . Ce fichier devra contenir les logins de certains (au moins un) de vos camarades de groupe dont vous ne voulez pas voir les messages: `echo -e "toto\ntata\ntiti" > invisibles`

7. Arrêtez la commande de messages en utilisat <kbd>Ctrl + C </kbd>

8. Modifiez la commande de messages , pour qu’elle fonctionne de manière identique mais sans afficher aucune ligne contenant un des logins présent dans le fichier invisibles:
   `tail -f /home/public/m1101/forum | grep -v -f invisibles`

9. Quelle ligne de commandes permet de démarrer rapidement l’intégralité de votre chat ? :


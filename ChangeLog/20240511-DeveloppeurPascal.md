# 20240511 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* ajout des boutons de génération, compilation et signature pour les projets ISS en Windows 32 et 64 bits
* ajout du code pour chaque bouton, sans finaliser les opérations elles-mêmes
* codage de la méthode SignSetupExecutables() permettant de signer un installeur généré depuis le projet ISS et rapatrier la version signée en local tout en supprimant le fichier setup.exe non signé
* codage de la méthode de compilation du fichier ISS vers le setup.exe à signer
* correction de la dépendance à "TurboPack/DOSCommand" qui avait été ajouté à /ChangeLog au lieu de /lib-externes
* tests pour comprendre les paramètres à passer à ISCC.exe (compilateur de scripts d'Inno Setup)
* renommage de l'option "ISPath" en "ISCCPath" dans les fichiers de configuration et du paramètre correspondant dans TConfig
* déplacement vers TConfig de la détection du chemin par défaut de stockage du programme ISCC.exe à utiliser si l'utilisateur ne l'a pas personnalisé dans les options du programme
* finalisation de la méthode permettant de compiler un fichier ISS en Setup.exe
* finalisation de la méthode permettant de signer un Setup.exe
* ajout de l'éditeur et de l'URL à utiliser dans les installeurs en Windows 32 et 64 (à l'écran et dans les paramètres du projet)
* codage de la fonction de génération du fichier ISS "de base" (juste avec l'exe à son emplacement Delphi par défaut) à partir du modèle de script d'installation proposé par l'assistant de création d'Inno Setup.

* tests des fonctionnalités OK

* activation du bouton "ouvrir un projet" par défaut au démarrage du programme
* ajout d'un bouton pour tout faire en une fois depuis l'onglet "projet"
* "sécurisation" des accès à l'interface utilisateur depuis les threads anonymes via onError et onSuccess
* conditionnement des éléments du script Inno Setup généré concernant le "publisher" s'il n'est pas renseigné

* changement du titre de la fenêtre principale lors des modifications dans les champs de saisie afin de gérer correctement l'étoile indiquant s'il y a des données non enregistrées dans le projet

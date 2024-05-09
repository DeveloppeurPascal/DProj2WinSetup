# 20240509 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* ajout de TurboPack/DOSCommand en sous module pour traiter les appels ultérieurs à ISCC
* mise à jour de la dépendance dans les docs FR/EN
* ajout des unités nécessaires pour utiliser l'API cliente de Exe Bulk Signing
* codage du test de connexion au niveau des options de projet (mais à revoir car isConnected ne traite que la partie réseau, pas le login et donc le test de validité d'AuthKey)
* développement de l'écran d'accueil et de sa fonctionnalité d'ouverture / création de projets dproj2setup
* création de la classe TDProj2WinSetupProject pour la gestion des options des projets
* codage des options de menu restantes (enregistrement, fermeture) et finalisation de l'ouverture d'un projet
* mise à jour du menu principal en fonction de l'ouverture/fermeture d'un projet
* mise à jour du titre de la fenêtre principale
* codage des options de menu d'ouverture, enregistrement et fermeture de projets
* mise en place des onglets permettant la saisie et l'archivage des informations liées à un projet
* correction de la fermeture du projet qui ne rebasculait pas sur l'onglet d'accueil
* changement de l'extension des fichiers liés à ce projet en "dproj2winsetup"
* changement du test de modification du projet pour partir sur les informations à l'écran plutôt que le fichier de paramètres (puisqu'il n'est modifié qu'en cas d'enregistrement)
* implémentation du onCloseQuery de la fenêtre principale avec prise en charge de la sauvegarde des données modifiées si un projet était ouvert
* finalisation du traitement de File/Close avec la proposition de l'enregistrement du projet actuel s'il a été modifié
* finalisation du traitement de File/Save
* ajout d'un bouton pour générer le GUID (si non renseigné) pour le GUID des setup en Windows 32 et Windows 64

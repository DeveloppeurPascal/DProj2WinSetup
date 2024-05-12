# 20240512 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* mise à jour des dépendances
* ajout des unités provenant des librairies pour prendre en charge le contenu d'un fichier DPROJ et en extraire la liste des fichiers à déployer
* modification de la récupération du chemin+nom de l'exécutable à utiliser selon la plateforme
* conditionnement des onglets en fonction de la présence ou non d'une configuration en RELEASE pour cette plateforme (et qu'elle soit disponible dans le projet)
* conditionnement du déclenchement des étapes de génération des setup en fonction de la présence des éléments nécessaires dans le DPROJ
* mise en place de la récupération des fichiers à déployer depuis le DPROJ lors de la génération du fichier ISS
* divers changements et correctifs liés à l'installation après quelques tests, des tickets ajoutés sur Github pour une prochaine version

* déploiement de la version 1.0 du 20240512 et génération de ses installeurs
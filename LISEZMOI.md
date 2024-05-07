# DProj2WinSetup

[This page in english.](README.md)

DProj2WinSetup est un générateur de programmes d'installation pour logiciels sous Windows développés sous Delphi (dans une version récente).

La création d'installeurs se fait en plusieurs étapes :

* Analyse des options du projet Delphi pour déterminer la liste des fichiers à packager et leur emplacement (d'origine et de destination).
* Signature des programmes exécutables, DLL et autres susceptibles de déclencher des alertes à l'utilisation sous Windows par l'intermédiaire du mode client/server de [Exe Bulk Signing](http://exebulksigning.olfsoftware.fr) qui devra être installé sur le poste du développeur ou un ordinateur du réseau sur lequel se trouvent les certificats de signature de code ou token CSC.
* Génération du script d'installation dans un fichier ISS au format demandé par [Inno Setup](https://jrsoftware.org/isinfo.php).
* Lancement de la génération des installeurs en passant par Inno Setup[Inno Setup](https://jrsoftware.org/isinfo.php) qui devra être installé sur le poste du développeur et accessible de DProj2WinSetup.
* Signature des programmes d'installation générés en passant également par [Exe Bulk Signing](http://exebulksigning.olfsoftware.fr).

L'objectif étant de simplifier au maximum la génération d'installeurs pour les projets Delphi de base.

Ce dépôt de code contient un projet développé en langage Pascal Objet sous Delphi. Vous ne savez pas ce qu'est Dephi ni où le télécharger ? Vous en saurez plus [sur ce site web](https://delphi-resources.developpeur-pascal.fr/).

## Utiliser ce logiciel

Ce logiciel est disponible dans une version de production directement installable ou exécutable. Il est distribué en shareware.

Vous pouvez le télécharger et le rediffuser gratuitement à condition de ne pas en modifier le contenu (installeur, programme, fichiers annexes, ...).

[Télécharger le programme ou son installeur](https://olfsoftware.lemonsqueezy.com/buy/a6513657-bc58-4079-a813-098906cbd8f8)

Si vous utilisez régulièrement ce logiciel et en êtes satisfait vous êtes invité à en acheter une licence d'utilisateur final. L'achat d'une licence vous donnera accès aux mises à jour du logiciel en plus d'activer d'évenuelles fonctionnalités optionnelles.

[Acheter une licence](https://olfsoftware.lemonsqueezy.com/buy/5d6328a0-4ccf-40e9-87b7-784ebfdc1440)

Vous pouvez aussi [consulter le site du logiciel](https://dproj2winsetup.olfsoftware.fr) pour en savoir plus sur son fonctionnement, accéder à des vidéos et articles, connaître les différentes versions disponibles et leurs fonctionnalités, contacter le support utilisateurs...

## Installation des codes sources

Pour télécharger ce dépôt de code il est recommandé de passer par "git" mais vous pouvez aussi télécharger un ZIP directement depuis [son dépôt GitHub](https://github.com/DeveloppeurPascal/DProj2WinSetup).

Ce projet utilise des dépendances sous forme de sous modules. Ils seront absents du fichier ZIP. Vous devrez les télécharger à la main.

* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) doit être installé dans le sous dossier ./lib-externes/librairies

Pour fonctionner Le programme nécessite d'avoir accès à [Exe Bulk Signing](http://exebulksigning.olfsoftware.fr) (en mode serveur sur le même poste ou sur le réseau local) et [Inno Setup](https://jrsoftware.org/isinfo.php) (sur le même ordinateur).

## Licence d'utilisation de ce dépôt de code et de son contenu

Ces codes sources sont distribués sous licence [AGPL 3.0 ou ultérieure](https://choosealicense.com/licenses/agpl-3.0/).

Vous êtes globalement libre d'utiliser le contenu de ce dépôt de code n'importe où à condition :
* d'en faire mention dans vos projets
* de diffuser les modifications apportées aux fichiers fournis dans ce projet sous licence AGPL (en y laissant les mentions de copyright d'origine (auteur, lien vers ce dépôt, licence) obligatoirement complétées par les vôtres)
* de diffuser les codes sources de vos créations sous licence AGPL

Si cette licence ne convient pas à vos besoins vous pouvez acheter un droit d'utilisation de ce projet sous la licence [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) ou une licence commerciale dédiée ([contactez l'auteur](https://developpeur-pascal.fr/nous-contacter.php) pour discuter de vos besoins).

Ces codes sources sont fournis en l'état sans garantie d'aucune sorte.

Certains éléments inclus dans ce dépôt peuvent dépendre de droits d'utilisation de tiers (images, sons, ...). Ils ne sont pas réutilisables dans vos projets sauf mention contraire.

## Comment demander une nouvelle fonctionnalité, signaler un bogue ou une faille de sécurité ?

Si vous voulez une réponse du propriétaire de ce dépôt la meilleure façon de procéder pour demander une nouvelle fonctionnalité ou signaler une anomalie est d'aller sur [le dépôt de code sur GitHub](https://github.com/DeveloppeurPascal/DProj2WinSetup) et [d'ouvrir un ticket](https://github.com/DeveloppeurPascal/DProj2WinSetup/issues).

Si vous avez trouvé une faille de sécurité n'en parlez pas en public avant qu'un correctif n'ait été déployé ou soit disponible. [Contactez l'auteur du dépôt en privé](https://developpeur-pascal.fr/nous-contacter.php) pour expliquer votre trouvaille.

Vous pouvez aussi cloner ce dépôt de code et participer à ses évolutions en soumettant vos modifications si vous le désirez. Lisez les explications dans le fichier [CONTRIBUTING.md](CONTRIBUTING.md).

## Supportez ce projet et son auteur

Si vous trouvez ce dépôt de code utile et voulez le montrer, merci de faire une donation [à son auteur](https://github.com/DeveloppeurPascal). Ca aidera à maintenir le projet (codes sources et binaires).

Vous pouvez utiliser l'un de ces services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

ou si vous parlez français vous pouvez [vous abonner à Zone Abo](https://zone-abo.fr/nos-abonnements.php) sur une base mensuelle ou annuelle et avoir en plus accès à de nombreuses ressources en ligne (vidéos et articles).

# DProj2WinSetup

[Cette page en français.](LISEZMOI.md)

DProj2WinSetup is a generator of installation programs for Windows software developed under Delphi (in a recent version).

Installers are created in several stages:

* Analysis of Delphi project options to determine the list of files to be packaged and their location (origin and destination).
* Signing of executable programs, DLLs and other files likely to trigger alerts when used under Windows via [Exe Bulk Signing](http://exebulksigning.olfsoftware.fr)'s client/server mode, which must be installed on the developer's workstation or a network computer on which the code-signing certificates or CSC tokens are located.
* Generation of the installation script in an ISS file in the format requested by [Inno Setup](https://jrsoftware.org/isinfo.php).
* Launch of installer generation via [Inno Setup](https://jrsoftware.org/isinfo.php), which must be installed on the developer's workstation and accessible from DProj2WinSetup.
* Signing of the generated installation programs, also using [Exe Bulk Signing](http://exebulksigning.olfsoftware.fr).

The aim is to simplify installer generation as much as possible for basic Delphi projects.

This code repository contains a project developed in Object Pascal language under Delphi. You don't know what Delphi is and where to download it ? You'll learn more [on this web site](https://delphi-resources.developpeur-pascal.fr/).

## Using this software

This software is available in a directly installable or executable production version. It is distributed as shareware.

You can download and redistribute it free of charge, provided you do not modify its content (installer, program, additional files, etc.).

[Download program or installer](https://olfsoftware.lemonsqueezy.com/buy/a6513657-bc58-4079-a813-098906cbd8f8)

If you use this software regularly and are satisfied with it, you are invited to purchase an end-user license. Purchasing a license will give you access to software updates, as well as enabling optional features.

[Buy a license](https://olfsoftware.lemonsqueezy.com/buy/5d6328a0-4ccf-40e9-87b7-784ebfdc1440)

You can also [visit the software website](https://dproj2winsetup.olfsoftware.fr) to find out more about how it works, access videos and articles, find out about the different versions available and their features, contact user support...

## Source code installation

To download this code repository, we recommend using "git", but you can also download a ZIP file directly from [its GitHub repository](https://github.com/DeveloppeurPascal/DProj2WinSetup).

This project uses dependencies in the form of sub-modules. They will be absent from the ZIP file. You'll have to download them by hand.

* [YYY](ZZZ) must be installed in the ./lib-externes/YYY subfolder.
* [YYY](ZZZ) must be installed in the ./lib-externes/YYY subfolder.

To run, the program requires access to [Exe Bulk Signing](http://exebulksigning.olfsoftware.fr) (in server mode on the same workstation or on the local network) and [Inno Setup](https://jrsoftware.org/isinfo.php) (on the same computer).

## License to use this code repository and its contents

This source code is distributed under the [AGPL 3.0 or later license](https://choosealicense.com/licenses/agpl-3.0/).

You are generally free to use the contents of this code repository anywhere, provided that:
* you mention it in your projects
* distribute the modifications made to the files supplied in this project under the AGPL license (leaving the original copyright notices (author, link to this repository, license) which must be supplemented by your own)
* to distribute the source code of your creations under the AGPL license.

If this license doesn't suit your needs, you can purchase the right to use this project under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) or a dedicated commercial license ([contact the author](https://developpeur-pascal.fr/nous-contacter.php) to explain your needs).

These source codes are provided as is, without warranty of any kind.

Certain elements included in this repository may be subject to third-party usage rights (images, sounds, etc.). They are not reusable in your projects unless otherwise stated.

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/DProj2WinSetup) and [open a new issue](https://github.com/DeveloppeurPascal/DProj2WinSetup/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

or if you speack french you can [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) on a monthly or yearly basis and get a lot of resources as videos and articles.

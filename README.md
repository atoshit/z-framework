# Z FiveM Framework
![Z Framework](https://github.com/user-attachments/assets/ae84ea9e-db7e-400e-bc99-7fc2ed35117a)

## Description

Z Framework est un framework modulaire et flexible pour le développement de serveurs FiveM. Conçu pour offrir une base solide et performante, il permet aux développeurs de créer des serveurs personnalisés en facilitant la gestion de l'économie, des métiers, des interactions entre les joueurs, et bien plus encore. Que vous souhaitiez construire un serveur de Roleplay, de survie ou tout autre type de gamemode, Z Framework fournit les outils et les ressources nécessaires pour démarrer rapidement.

## Fonctionnalités Principales

- **Gestion de l'économie :** Système intégré pour gérer l'argent en banque, liquide et noir.
- **Système de métiers :** Créez et personnalisez des métiers avec des permissions et des interactions spécifiques.
- **Inventaire modulaire :** Un système d'inventaire flexible avec support des objets, armes et véhicules.
- **Interactions entre joueurs :** Mécanismes simplifiés pour les actions de base comme donner des objets, fouiller, etc.
- **Structure modulaire :** Permet l'ajout et la suppression facile de modules sans affecter le cœur du framework.
- **Performance optimisée :** Conçu pour minimiser l'impact sur le serveur et offrir une expérience fluide.

## Installation

1. **Télécharger le dépôt :**
   - Clonez le dépôt en utilisant la commande suivante :
     ```bash
     git clone https://github.com/atoshit/z-framework.git
     ```

2. **Installation des dépendances :**
   - Assurez-vous d'avoir oxmysql d'installer sur votre serveur (https://github.com/overextended/oxmysql).
   - Assurez-vous aussi d'avoir oxmysql chargé avant z-framework dans le server.cfg
   - Importez le fichier `sql/z_framework.sql` dans votre base de données.

3. **Configuration :**
   - Configurez le fichier `config.lua` pour adapter le framework à votre serveur (coordonnées, options de jeu, etc.).

4. **Démarrage :**
   - Ajoutez `ensure z-framework` dans votre fichier `server.cfg` et redémarrez votre serveur FiveM.

## Documentation
### Commandes
### Fonctions
#### Client:
   - ```Z.Io.Trace```
   - ```Z.Io.Debug```
   - ```Z.Io.Info```
   - ```Z.Io.Warn```
   - ```Z.Io.Error```
   - ```Z.Event.Register```
   - ```Z.Event.Trigger```
   - ```Z.Event.TriggerServer```
   - ```Z.Callback.Register```
   - ```Z.Callback.Remove```
   - ```Z.Callback.TriggerWithTimeout```
   - ```Z.Callback.Trigger```
   - ```Z.Callback.TriggerWithTimeoutAsync```
   - ```Z.Callback.TriggerAsync```
   - ```Z.Function.requestModel```
   - ```Z.Function.setPlayerModel```
   - ```Z.Function.setEntityCoords```
   - ```Z.Function.setEntityHeading```
   - ```Z.Function.toggleNpcDrops```
   - ```Z.Function.toggleNpcHealthRegeneration```
   - ```Z.Function.toggleDefaultWantedLevel```
   - ```Z.Function.toggleDispatchService```
   - ```Z.Function.togglePvp```
   - ```Z.Function.loadingHide```
#### Server:
   - ```Z.Io.Trace```
   - ```Z.Io.Debug```
   - ```Z.Io.Info```
   - ```Z.Io.Warn```
   - ```Z.Io.Error```
   - ```Z.Event.Register```
   - ```Z.Event.Trigger```
   - ```Z.Event.TriggerClient```
   - ```Z.Callback.Register```
   - ```Z.Callback.Remove```
   - ```Z.Callback.TriggerWithTimeout```
   - ```Z.Callback.Trigger```
   - ```Z.Callback.TriggerWithTimeoutAsync```
   - ```Z.Callback.TriggerAsync```
   - ```Z.getPlayer``` (Renvoie l'objet player)
### Events
   - ```z-framework:playerLoaded```
   - ```z-framework:playerSpawned```
## Contribution

Nous accueillons les contributions de la communauté ! Si vous souhaitez contribuer au développement de Z Framework, suivez ces étapes :

1. **Fork le dépôt :** Créez une copie du dépôt sur votre propre compte GitHub.
2. **Créer une branche :** Créez une nouvelle branche pour votre fonctionnalité ou correction de bug.
   ```bash
   git checkout -b nom-de-la-branche

--------------------------------

![Z LOGO 96](https://github.com/user-attachments/assets/71d3388d-40f0-4d5a-9d1a-25175e2447b6)

<br>
<table><tr><td><h4 align='center'>License</h4></tr></td>
<tr><td>

Copyright

© 2024 [Z Framework](https://github.com/atoshit/z-framework/). Tous droits réservés.

Z Framework est un projet open source publié sous licence MIT. Cela signifie que vous êtes libre d'utiliser, de modifier et de distribuer ce framework, à condition de respecter les termes de la licence.

**Toutefois, la revente du framework, ainsi que l'appropriation du code, en totalité ou en partie, sous un autre nom, ne sont pas autorisées.** Nous encourageons le partage et l'amélioration du projet dans l'esprit de la communauté open source, tout en protégeant le travail original des contributeurs.

Pour plus d'informations, veuillez consulter le fichier [LICENSE](./LICENSE) dans ce dépôt.
</td></tr></table>

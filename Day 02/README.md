Similaire au c

Regex

preg_match('/^Game (\d+): (.+)$/', $line, $matches);
preg_match: This is a PHP function used to perform a regular expression match. It searches a string for a pattern and, if found, it populates an array with the results.
'/^Game (\d+): (.+)$/': This is the regular expression pattern.
^Game : This matches the beginning of a string that starts with "Game ".
(\d+): This captures one or more digits (\d stands for a digit, and + means one or more). This part is for capturing the game ID.
: : This matches the literal colon and space following the game ID.
(.+): This captures everything that follows until the end of the line. This part is intended to capture the sets of cubes information.
$: This asserts the end of the line.
$line: The string being searched, which in this case is a line from the file.
$matches: An array that will be filled with the results of the search. After the execution, $matches[0] will contain the text of the entire match, $matches[1] will contain the game ID, and $matches[2] will contain the sets of cubes.

1. Utilisation de preg_match
php
Copy code
preg_match('/^Game (\d+): (.+)$/', $line, $matches);
Cette ligne utilise la fonction preg_match pour chercher un motif spécifique dans la variable $line. Décortiquons l'expression régulière :

^Game : Cette partie recherche la séquence de caractères "Game " au début d'une ligne. Le signe ^ est un ancrage qui signifie le début de la ligne.
(\d+) : Cette partie est un groupe capturant qui correspond à une séquence d'un ou plusieurs chiffres. \d est un raccourci pour [0-9], qui signifie tout chiffre de 0 à 9. Le signe + indique qu'on recherche une occurrence d'au moins un chiffre. Ce groupe capturant va extraire le numéro du jeu.
: : Cette partie correspond littéralement à la séquence de caractères ": " (deux-points suivi d'un espace).
(.+) : Un autre groupe capturant qui correspond à une séquence de un ou plusieurs caractères, quel qu'ils soient. Le . signifie "n'importe quel caractère" et le + indique "un ou plusieurs". Ce groupe va capturer le reste de la ligne après "Game X: ".
$ : Cet ancrage indique la fin de la ligne. Il garantit que le motif correspond à toute la ligne et pas seulement à une partie.
2. Utilisation de preg_match_all
php
Copy code
preg_match_all('/(\d+) (red|green|blue)/', $set, $matches, PREG_SET_ORDER);
Cette ligne utilise preg_match_all pour trouver toutes les occurrences d'un motif spécifique dans la variable $set. Examinons l'expression régulière utilisée ici :

(\d+) : Comme dans la première expression, cela correspond à une séquence d'un ou plusieurs chiffres et capture ce nombre.
: Un espace littéral qui sépare le nombre de la couleur dans la chaîne.
(red|green|blue) : Un groupe capturant qui correspond à l'un des mots "red", "green" ou "blue". Le | est un opérateur "ou" dans les regex, donc ce groupe cherche l'une de ces trois options de couleur.
PREG_SET_ORDER : Ce n'est pas une partie de l'expression régulière elle-même, mais un drapeau passé à preg_match_all. Il modifie la structure du tableau de résultats $matches pour regrouper d'abord toutes les captures d'une seule correspondance ensemble.

/////////////////////////////

Pour illustrer le fonctionnement de ce programme PHP, je vais vous présenter un schéma étape par étape :

Initialisation

Définit les constantes $MAX_RED, $MAX_GREEN, $MAX_BLUE pour le nombre maximal de cubes de chaque couleur.
Ouvre le fichier input.txt pour la lecture.
Initialise $sumOfGameIDs à 0 pour suivre la somme des ID des jeux possibles.
Lecture du Fichier

Vérifie si le fichier a été ouvert avec succès.
Lit le fichier ligne par ligne dans une boucle while.
Traitement de Chaque Ligne

Supprime les espaces blancs au début et à la fin de chaque ligne.
Ignore les lignes vides.
Extraction des Données de Jeu

Utilise preg_match pour extraire l'ID du jeu et les données des ensembles de cubes de la ligne.
Sépare les ensembles de cubes dans un tableau $sets.
Analyse de Chaque Ensemble de Cubes

Pour chaque ensemble ($set) dans le jeu :
Initialise les compteurs $red, $green, $blue à 0.
Utilise preg_match_all pour compter le nombre de cubes de chaque couleur dans l'ensemble.
Vérifie si le nombre de cubes de chaque couleur dépasse les maximums définis.
Si un ensemble dépasse les limites de couleur, marque le jeu comme impossible et sort de la boucle interne.
Évaluation du Jeu

Après avoir analysé tous les ensembles, si le jeu est possible (ne dépasse pas les limites de couleur), ajoute l'ID du jeu à $sumOfGameIDs.
Fin de la Lecture du Fichier

Ferme le fichier une fois toutes les lignes lues et traitées.
Résultat Final

Affiche la somme des ID des jeux possibles.
Ce schéma décrit le flux général du programme, de l'ouverture du fichier à la détermination des jeux possibles et à l'affichage du résultat final.

/////////////////////////////////

Expliquons comment les variables évoluent à chaque étape du traitement d'une ligne typique dans ce programme PHP. Supposons que la ligne en cours de traitement soit :

css
Copy code
Game 2: 3 red, 2 green; 4 blue, 1 red; 1 green, 1 blue
Lecture de la Ligne

$line = "Game 2: 3 red, 2 green; 4 blue, 1 red; 1 green, 1 blue"
Utilisation de preg_match

Après preg_match('/^Game (\d+): (.+)$/', $line, $matches);
$matches = ["Game 2: 3 red, 2 green; 4 blue, 1 red; 1 green, 1 blue", "2", "3 red, 2 green; 4 blue, 1 red; 1 green, 1 blue"]
$gameID = "2" (extrait de $matches[1])
Séparation des Ensembles de Cubes

Après $sets = explode(';', $matches[2]);
$sets = ["3 red, 2 green", " 4 blue, 1 red", " 1 green, 1 blue"]
Traitement de Chaque Ensemble ($set)

Pour chaque $set dans $sets, par exemple: "3 red, 2 green"
Initialise $red = 0, $green = 0, $blue = 0.
Utilise preg_match_all('/(\d+) (red|green|blue)/', $set, $matches, PREG_SET_ORDER);
Après l'exécution, pour le premier $set, $matches = [["3 red", "3", "red"], ["2 green", "2", "green"]]
Les compteurs sont mis à jour : $red = 3, $green = 2, $blue = 0.
Vérifie si les compteurs dépassent les maximums. Dans ce cas, non.
Répète pour chaque $set.
Après l'Analyse de Tous les Ensembles

Si aucun ensemble n'a dépassé les maximums, $gamePossible reste true.
$sumOfGameIDs est augmenté par l'ID du jeu si le jeu est possible. Si $gamePossible est true, alors $sumOfGameIDs += 2 (dans ce cas).
Résultat Final pour cette Ligne

Si cette ligne est la seule ligne du fichier, $sumOfGameIDs = 2 à la fin du traitement de la ligne.

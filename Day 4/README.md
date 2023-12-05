Decouverte rapide, decouverte de certain concept (ci dessous), j'ai envie de passer plus de temps sur haskell
Utilisation des tables dans le program (Cards)
Retour du regex

Introduction au concept :
Tables / metatable

Table peut servir de array simple, de map, de dictionnaire, un mix des trois
metatables sert a definir le behavior des operateurs pour les tables de manieres custom (par exemple a table myTable = {10, 15, 20}, si on dit que + append le nombre a la fin de la liste puis fait la somme, on peut avoir result = myTable + 15 qui ducoup sera egail a 70)

Table bon outil, mais les array qui commence a index 1, cest ... special

Objets :

Un objet est une instance d'une classe. Il représente une entité dans le logiciel, souvent un objet du monde réel, comme une voiture, une personne, un compte bancaire, etc.
Chaque objet a des "attributs" (également appelés "propriétés" ou "champs") qui décrivent ses caractéristiques. Par exemple, une voiture peut avoir des attributs comme la marque, le modèle, la couleur.
Les objets ont aussi des "méthodes" qui sont des fonctions ou des procédures associées à l'objet et qui définissent son comportement. Par exemple, une voiture peut avoir des méthodes comme démarrer, accélérer, freiner.
Classes :

Une classe est un "modèle" ou un "plan" pour créer des objets. Elle définit les attributs et méthodes que ses objets (instances) auront.
Prenons l'exemple de la classe "Voiture". Cette classe définira des attributs tels que la marque, le modèle, la couleur, etc., et des méthodes comme démarrer ou freiner.
Les classes permettent la réutilisation de code. Au lieu de définir les mêmes propriétés et méthodes à chaque fois pour des objets similaires, une classe permet de les définir une seule fois et de créer plusieurs objets (instances) basés sur ces définitions.
Héritage :

L'héritage est un mécanisme de la POO qui permet à une classe d'hériter des attributs et méthodes d'une autre classe.
La classe qui hérite est souvent appelée "classe dérivée" ou "sous-classe", et la classe dont elle hérite est appelée "classe de base" ou "superclasse".
L'héritage permet d'établir une relation de type "est-un". Par exemple, si vous avez une classe de base "Véhicule" avec des classes dérivées comme "Voiture", "Moto", "Camion", etc., cela signifie que chaque "Voiture" est un "Véhicule", mais avec des caractéristiques spécifiques en plus de celles héritées de "Véhicule".
L'héritage favorise la réutilisation du code (les sous-classes réutilisent le code de la classe de base) et peut faciliter la maintenance du logiciel.
En résumé, la programmation orientée objet structure un programme en utilisant des objets, des classes et l'héritage. Cela rend le code plus modulaire, réutilisable et facile à maintenir. La POO est largement utilisée dans de nombreux langages de programmation modernes comme Java, C++, Python, etc.

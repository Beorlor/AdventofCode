import 'dart:io';
import 'dart:async';
import 'dart:math';

const valueOrdering = [
  'A',
  'K',
  'Q',
  'T',
  '9',
  '8',
  '7',
  '6',
  '5',
  '4',
  '3',
  '2',
  'J',
];

class Hand {
  final List<String> cards;
  final List<String> replacedCards;
  final int bid;

  const Hand({
    required this.cards,
    required this.bid,
    required this.replacedCards,
  });

  double get entropy {
    Map<String, int> charCount = {};
    int totalChars = replacedCards.length;

    replacedCards.forEach((String char) {
      charCount[char] = (charCount[char] ?? 0) + 1;
    });

    return -charCount.values.map((int count) {
      final d = count / totalChars;
      return d * (d == 0 ? 0 : -log(d));
    }).reduce((a, b) => a + b);
  }

  @override
  String toString() {
    return "${cards.join()} | $bid [$entropy]";
  }
}

bool cardHasHigherValue(String a, String b) {
  return valueOrdering.indexOf(a) < valueOrdering.indexOf(b) ? true : false;
}

int compareHands(Hand a, Hand b) {
  if (a.entropy == b.entropy) {
    for (int i = 0; i < a.replacedCards.length; i++) {
      if (a.replacedCards[i] == b.replacedCards[i]) {
        continue;
      }
      return cardHasHigherValue(a.replacedCards[i], b.replacedCards[i]) ? -1 : 1;
    }
  }

  return a.entropy < b.entropy ? 1 : -1;
}

List<String> replaceJokers(List<String> cards) {
  int jokerCount = cards.where((c) => c == "J").length;

  if (jokerCount == 0) return cards;
  if (jokerCount == 5) return "AAAAA".split("");

  Map<String, int> frequencyMap = {};
  cards.where((c) => c != "J").forEach((card) {
    frequencyMap[card] = (frequencyMap[card] ?? 0) + 1;
  });

  final bestCard = frequencyMap.keys.reduce((a, b) => frequencyMap[a]! > frequencyMap[b]! ? a : b);

  for (var i = 0; i < jokerCount; i++) {
    cards = cards.join("").replaceFirst("J", bestCard).split("").toList();
  }

  return cards;
}

int solve(List<String> inputs) {
  final List<Hand> hands = [];

  for (final input in inputs) {
    final parts = input.split(" ");
    final cards = parts[0].split("");
    final replacedCards = replaceJokers(cards);

    final bid = int.parse(parts[1]);
    hands.add(
      Hand(cards: cards, bid: bid, replacedCards: replacedCards),
    );
  }

  hands.sort(compareHands);

  int score = 0;
  int multiplier = hands.length;
  for (final hand in hands) {
    score += (hand.bid * multiplier);
    multiplier--;
  }

  return score;
}

Future<List<String>> readLinesFromFile(String path) async {
  var file = File(path);
  var lines = <String>[];

  if (await file.exists()) {
    await for (var line in file.readAsLines()) {
      lines.add(line);
    }
  } else {
    print('File not found: $path');
  }

  return lines;
}

void main(List<String> args) async {
  const inputFile = 'input.txt';  // Changed to 'input.txt'
  final input = await readLinesFromFile(inputFile);
  final result = solve(input);

  print("---!!!!----");
  print(result);
  print("---!!!!----");
}

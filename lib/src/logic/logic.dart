import 'dart:math';

import 'package:all_english_words/all_english_words.dart';
import 'package:flutter/material.dart';
import 'package:word_rush/src/src.dart';

class GameLogic extends ChangeNotifier {
  late List<String> _wordsCollection;
  List<String> get wordCollection => _wordsCollection;

  void initialize() {
    final englishWords = AllEnglishWords();
    _wordsCollection = englishWords.allDictionaryWords;
  }

  String gameWord() {
    final words = _generatedWords();

    final random = Random();
    final index = random.nextInt(words.length);

    return words[index];
  }

  List<String> gamePlayWords(List<String> letters, [int wordLength = 0]) {
    List<String> filteredWords = filteredWordCollectionFromGameWord(letters);
    List<String> choosenWords = [];
    final pickedWord = _pickWordsRandomly(filteredWords);

    for (var word in pickedWord) {
      if (!(word.length >= 3)) {
        continue;
      } else {
        choosenWords.add(word);
      }
    }

    return choosenWords;
  }

  Set<String> _pickWordsRandomly(List<String> wordList) {
    List<String> shuffledList = List.from(wordList)..shuffle();
    Set<String> pickedWords = {};

    for (var word in shuffledList) {
      if (!pickedWords.contains(word)) {
        pickedWords.add(word);
      }
    }
    return pickedWords;
  }

  List<String> _generatedWords() {
    List<String> generatedWords = [];
    final allWords = _wordsCollection;

    for (var word in allWords) {
      if (word.length != 5) {
        continue;
      } else {
        generatedWords.add(word);
      }
    }

    return generatedWords;
  }

  List<String> filteredWordCollectionFromGameWord(List<String> letters) {
    final permutations = _generatePermutations(letters, 2);

    final filteredWords = _filterWords(permutations);
    return filteredWords;
  }

// Generate Permutation Of words
  List<String> _generatePermutations(List<String> letters, int minLength) {
    final List<String> result = [];

    void backtrack(List<String> current, List<String> remaining) {
      if (current.length >= minLength) {
        result.add(current.join());
      }

      for (int i = 0; i < remaining.length; i++) {
        final String letter = remaining[i];
        final List<String> next = List.from(current)..add(letter);
        final List<String> rest = List.from(remaining)..removeAt(i);
        backtrack(next, rest);
      }
    }

    backtrack([], letters);
    return result;
  }

// Filter and check words in the permutation generated.
  List<String> _filterWords(List<String> permutations) {
    final List<String> allWords = _wordsCollection;
    final Set<String> acceptedWords = {};

    for (final word in permutations) {
      if (allWords.contains(word)) {
        final uniqueLetters = word.split('').toSet();
        if (uniqueLetters.length == word.length) {
          acceptedWords.add(word);
        }
      }
    }

    final filteredWords = acceptedWords.toList();
    RegExp vowelRegex = RegExp(r'[aeiou]');

    filteredWords.removeWhere((filteredWord) =>
        filteredWord.length == 2 &&
        !vowelRegex.hasMatch(filteredWord.toLowerCase()));
    return filteredWords;
  }
}

import 'dart:async';
import 'dart:js_util';

import 'package:flutter/foundation.dart';

import 'presistence/player_progress_persistence.dart';

/// Encapsulates the player's progress.
class PlayerProgress extends ChangeNotifier {
  // static const maxHighestScoresPerPlayer = 10;

  final PlayerProgressPersistence _store;

  int _highestLevelReached = 0;
  int _highestCoinsCollected = 0;

  /// Creates an instance of [PlayerProgress] backed by an injected
  /// persistence [store].
  PlayerProgress(PlayerProgressPersistence store) : _store = store;

  /// The highest level that the player has reached so far.
  int get highestLevelReached => _highestLevelReached;

  int get coinsAmount => _highestCoinsCollected;

  /// Fetches the latest data from the backing persistence store.
  Future<void> getLatestFromStore() async {
    final level = await _store.getHighestLevelReached();
    final coins = await _store.getCoinValue();
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
    } else if (level < _highestLevelReached) {
      await _store.saveHighestLevelReached(_highestLevelReached);
    }
    if (coins > _highestCoinsCollected) {
      _highestCoinsCollected = coins;
      notifyListeners();
    } else if (coins < _highestCoinsCollected) {
      await _store.saveCoins(_highestCoinsCollected);
    }
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _highestLevelReached = 0;
    _highestCoinsCollected = 0;
    notifyListeners();
    _store.saveHighestLevelReached(_highestLevelReached);
    _store.saveCoins(_highestCoinsCollected);
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelReached(int level) {
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();

      unawaited(_store.saveHighestLevelReached(level));
    }
  }

  void setCoinsCollected(int coins) {
    if (coins > _highestCoinsCollected) {
      _highestCoinsCollected = coins;
      notifyListeners();

      unawaited(
        _store.saveCoins(coins),
      );
    }
  }
}

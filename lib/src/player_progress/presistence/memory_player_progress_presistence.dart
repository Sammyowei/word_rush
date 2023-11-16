import 'package:word_rush/src/player_progress/presistence/player_progress_persistence.dart';

/// An in-memory implementation of [PlayerProgressPersistence].
/// Useful for testing.
class MemoryOnlyPlayerProgressPersistence implements PlayerProgressPersistence {
  int level = 0;
  int coins = 0;

  @override
  Future<int> getHighestLevelReached() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return level;
  }

  @override
  Future<void> saveHighestLevelReached(int level) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    this.level = level;
  }

  @override
  Future<int> getCoinValue() async {
    // TODO: implement getHighScore
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return coins;
  }

  @override
  Future<void> saveCoins(int coinAmount) async {
    final coins = await getCoinValue();
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final newRecord = coins + coinAmount;
    this.coins = newRecord;
  }
}

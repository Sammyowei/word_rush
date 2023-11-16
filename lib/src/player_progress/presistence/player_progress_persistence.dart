abstract class PlayerProgressPersistence {
  Future<int> getHighestLevelReached();

  Future<void> saveHighestLevelReached(int level);

  Future<void> saveCoins(int coins);

  Future<int> getCoinValue();
}

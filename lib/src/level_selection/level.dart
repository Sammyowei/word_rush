final gameLevels = <GameLevel>[
  const GameLevel(
    level: 1,
    coinValue: 0,
    difficulty: 5, // TODO: When ready, change these achievement IDs.
    // You configure this in App Store Connect.
    achievementIdIOS: 'first_win',
    // You get this string when you configure an achievement in Play Console.
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  const GameLevel(
    level: 2,
    coinValue: 200,
    difficulty: 45,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  const GameLevel(
    level: 3,
    coinValue: 750,
    difficulty: 85,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  const GameLevel(
    level: 4,
    coinValue: 1500,
    difficulty: 125,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  const GameLevel(
    level: 5,
    coinValue: 3000,
    difficulty: 165,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  const GameLevel(
    level: 6,
    coinValue: 6000,
    difficulty: 205,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  const GameLevel(
    level: 7,
    coinValue: 9000,
    difficulty: 245,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  const GameLevel(
    level: 8,
    coinValue: 14000,
    difficulty: 285,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  const GameLevel(
    level: 9,
    coinValue: 19000,
    difficulty: 325,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  const GameLevel(
    level: 10,
    coinValue: 25000,
    difficulty: 365,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
];

class GameLevel {
  final int level;

  final int difficulty;

  final int coinValue;

  /// The achievement to unlock when the level is finished, if any.
  final String? achievementIdIOS;

  final String? achievementIdAndroid;

  bool get awardsAchievement => achievementIdAndroid != null;

  const GameLevel({
    required this.level,
    required this.coinValue,
    required this.difficulty,
    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}

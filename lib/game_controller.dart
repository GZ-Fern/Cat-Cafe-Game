import 'game_states.dart';
import 'dart:math';

// Handles game upgrades, clicks, and passive income
class GameController {
  final GameStates gameStates;

  GameController(this.gameStates);

  // Tapping action to earn catpuccinos
  void brewCatpuccino() {
    gameStates.catpuccino += gameStates.perClick;
  }

  // Upgrading click power by training server cats
  void trainServerCat() {
    if (gameStates.catpuccino >= gameStates.clickUpgradeCost) {
      gameStates.catpuccino -= gameStates.clickUpgradeCost;
      gameStates.clickUpgradeLevel++;
      gameStates.perClick++;
      gameStates.clickUpgradeCost = (gameStates.clickUpgradeCost * 1.5).round();
    }
  }

  // Upgrading passive income by recruiting cafe cats
  void recruitCafeCats() {
    if (gameStates.catpuccino >= gameStates.passiveUpgradeCost) {
      gameStates.catpuccino -= gameStates.passiveUpgradeCost;
      gameStates.passiveUpgradeLevel++;
      gameStates.passiveRate++;
      gameStates.passiveUpgradeCost = (gameStates.passiveUpgradeCost * 1.6)
          .round();
    }
  }

  // Apply passive income over time
  void applyPassiveIncome() {
    gameStates.catpuccino += gameStates.passiveRate;
  }

  String visitFromRandomCat() {
    final cats = [
      'Garfield',
      'Puss in Boots',
      'Sylvester',
      'Cheshire Cat',
      'Tom Cat',
      'Snowball',
    ];
    final random = Random();
    final catVisitor = cats[random.nextInt(cats.length)];

    bool rare = random.nextInt(10) == 0; // 1 in 10 chance
    int bonus = rare ? 100 : (10 + random.nextInt(21));

    gameStates.catpuccino += bonus;

    return rare
        ? '$catVisitor visited and brought a GENEROUS gift of $bonus Catpuccinos!!! WOOOHOO!'
        : '$catVisitor stopped by to gift you $bonus catpuccinos!';
  }

  // Reset the game to initial state
  void resetGame() {
    gameStates.reset();
  }
}

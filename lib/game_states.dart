// Game state management for the idle game
class GameStates {
  int catpuccino; // Main resource
  int perClick; // Catpuccinos per click
  int clickUpgradeLevel; // Level of click upgrade
  int clickUpgradeCost; // Cost to upgrade click

  int passiveRate; // Catpuccinos per second
  int passiveUpgradeLevel; // Level of passive income
  int passiveUpgradeCost; // Cost to upgrade passive income
  GameStates({
    this.catpuccino = 0,
    this.perClick = 1,
    this.clickUpgradeLevel = 1,
    this.clickUpgradeCost = 20,
    this.passiveRate = 0,
    this.passiveUpgradeLevel = 0,
    this.passiveUpgradeCost = 50,
  });

  // Reset game state to initial values
  void reset() {
    catpuccino = 0;
    perClick = 1;
    clickUpgradeLevel = 1;
    clickUpgradeCost = 20;
    passiveRate = 0;
    passiveUpgradeLevel = 0;
    passiveUpgradeCost = 50;
  }
}

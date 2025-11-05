import 'dart:async';
import 'package:flutter/material.dart';
import 'game_controller.dart';
import 'game_states.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

// Main game page UI and logic
class _GamePageState extends State<GamePage> {
  final GameStates gameStates = GameStates();
  late final GameController controller;

  late Timer passiveTimer; // Timer for passive income
  late Timer catVisitorTimer;

  @override
  void initState() {
    super.initState();
    controller = GameController(gameStates);

    // Set up a timer to apply passive income every second
    passiveTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => controller.applyPassiveIncome());
    });

    // Random cat visitor every set seconds
    catVisitorTimer = Timer.periodic(const Duration(seconds: 25), (_) {
      final message = controller.visitFromRandomCat();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 4)),
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    passiveTimer.cancel();
    catVisitorTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Cafe Idle Game')),
      backgroundColor: const Color.fromARGB(255, 226, 216, 204),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/cat-coffee-game.gif',
                  width: 200,
                  height: 200,
                ),

                const SizedBox(height: 12),

                Text(
                  'Welcome to the Cat Cafe!\n',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Instructions
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(182, 142, 119, 98),
                    border: Border.all(
                      color: const Color.fromARGB(255, 35, 28, 28),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'How to be an expert Cafe owner:\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      Text(
                        '> Tap to "Brew" a Catpuccino!\n\n'
                        '> Train Server Cats to brew more per tap (+1 per upgrade)!\n\n'
                        '> Recruit Cafe Cats to brew Catpuccinos automatically (+1 per second)!\n\n'
                        '> The more you upgrade, the more Catpuccinos you earn!\n\n'
                        '> Close the cafe for cleaning to reset your progress.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'You have ${gameStates.catpuccino} Catpuccinos',
                  style: const TextStyle(fontSize: 24),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    setState(() => controller.brewCatpuccino());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 172, 208, 239),
                  ),
                  child: Text('Brew Catpuccino! (+${gameStates.perClick})'),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    setState(() => controller.trainServerCat());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 172, 208, 239),
                  ),
                  child: Text(
                    'Train Server Cat (Level ${gameStates.passiveUpgradeLevel}) - ${gameStates.clickUpgradeCost}',
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    setState(() => controller.recruitCafeCats());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 172, 208, 239),
                  ),
                  child: Text(
                    'Recruit Cafe Cats (Level ${gameStates.passiveUpgradeLevel}) - ${gameStates.passiveUpgradeCost}',
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Recruited Cafe Cats are brewing ${gameStates.passiveRate} Catpuccinos per second',
                  style: const TextStyle(fontSize: 15),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    setState(() => controller.resetGame());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 241, 191, 207),
                  ),
                  child: const Text('Close Cafe for Cleaning (Reset Game)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

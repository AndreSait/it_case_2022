import 'package:flutter/material.dart';
import '../../game_components/memory_game/flip_card.dart';

class MemoryGame extends StatefulWidget {
  static const routeName = "memory-game";

  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  @override
  Widget build(BuildContext context) {
    // final routeArgs =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final categoryTitle = routeArgs["title"];
    // final categoryId = routeArgs["id"];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Memory Game"),
            Container(
                width: double.infinity,
                height: 450,
                child: GridView(
                  padding: const EdgeInsets.all(25),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  children: [
                    FlipCard(),
                    FlipCard(),
                    FlipCard(),
                    FlipCard(),
                    FlipCard(),
                    FlipCard(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

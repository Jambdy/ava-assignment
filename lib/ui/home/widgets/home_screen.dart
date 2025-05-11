import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            // Handle menu button press
          },
        ),
        title: Text('Home', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: Placeholder(),
    );
  }
}

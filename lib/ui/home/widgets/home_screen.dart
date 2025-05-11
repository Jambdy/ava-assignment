import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/home_viewmodel.dart';
import 'credit_history_card.dart';
import 'credit_score_card.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

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
      body: homeState.when(
        data: (data) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: CreditScoreCard(
                      currentScore: data.creditScore.currentScore,
                      creditScoreStatus: data.creditScoreStatus,
                      scoreChange: data.creditScore.scoreChange,
                      lastUpdated: data.creditScore.lastUpdated,
                      nextUpdate: data.creditScore.nextUpdate,
                      creditAgency: data.creditScore.creditAgency,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 375,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40.0,
                            bottom: 20.0,
                          ),
                          child: Text(
                            'Chart',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        CreditHistoryCard(
                          scoreChange: data.creditScore.scoreChange,
                          lastUpdated: data.creditScore.lastUpdated,
                          nextUpdate: data.creditScore.nextUpdate,
                          creditAgency: data.creditScore.creditAgency,
                          creditScoreGraphData: data.creditScoreGraphData,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

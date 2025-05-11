import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/themes/theme.dart';
import '../../core/widgets/ava_title.dart';
import '../view_models/home_viewmodel.dart';
import 'account_details_card.dart';
import 'credit_card_accounts_card.dart';
import 'credit_card_balance_card.dart';
import 'credit_factors_card.dart';
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
        title: Text(
          'Home',
          style: AppTheme.bodyEmphasis.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
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
                        AvaTitle(title: 'Chart'),
                        CreditHistoryCard(
                          scoreChange: data.creditScore.scoreChange,
                          lastUpdated: data.creditScore.lastUpdated,
                          nextUpdate: data.creditScore.nextUpdate,
                          creditAgency: data.creditScore.creditAgency,
                          creditScoreGraphData: data.creditScoreGraphData,
                        ),
                        AvaTitle(title: 'Credit Factors'),
                        CreditFactorsCard(
                          creditFactorsDisplay: data.creditFactorsDisplay,
                        ),
                        AvaTitle(title: 'Account Details'),
                        AccountDetailsCard(accountDetails: data.accountDetails),
                        SizedBox(height: 34),
                        CreditCardBalanceCard(
                          cCData: data.creditCardAccountsAggregate,
                        ),
                        AvaTitle(title: 'Open credit card accounts'),
                        CreditCardAccountsCard(
                          cCAccounts:
                              data
                                  .creditCardAccountsAggregate
                                  .creditCardAccountsDisplay,
                        ),
                        SizedBox(height: 34),
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

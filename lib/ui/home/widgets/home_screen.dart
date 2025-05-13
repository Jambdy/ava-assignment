import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../routing/router.gr.dart';
import '../../../utils/layout_utils.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava.dart';
import '../../feedback/widgets/feedback_overlay.dart';
import '../view_models/home_viewmodel.dart';
import 'account_details_card.dart';
import 'credit_card_accounts_card.dart';
import 'credit_card_balance_card.dart';
import 'credit_factors_card.dart';
import 'credit_history_card.dart';
import 'credit_score_card.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  final bool requestFeedback;

  const HomeScreen({super.key, this.requestFeedback = false});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.requestFeedback) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          builder:
              (_) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: const FeedbackOverlay(),
              ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            context.router.push(const EmploymentRoute());
          },
        ),

        /// TODO: Remove if app actually released
        /// Included to demonstrate the animations during refresh
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).refresh();
            },
          ),
        ],
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
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: CreditScoreCard(
                      currentScore: data.creditScoreDisplay.currentScore,
                      creditScoreStatus:
                          data.creditScoreDisplay.creditScoreStatus,
                      scoreChangeDisplay:
                          data.creditScoreDisplay.scoreChangeDisplay,
                      scoreChangeColor:
                          data.creditScoreDisplay.scoreChangeColor,
                      lastUpdated: data.creditScoreDisplay.lastUpdated,
                      nextUpdate: data.creditScoreDisplay.nextUpdate,
                      creditAgency: data.creditScoreDisplay.creditAgency,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: LayoutUtils.constrainedWidth(context),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.paddingDefault,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AvaTitle(title: 'Chart'),
                        CreditHistoryCard(
                          scoreChange:
                              data.creditScoreDisplay.scoreChangeDisplay,
                          scoreChangeColor:
                              data.creditScoreDisplay.scoreChangeColor,
                          lastUpdated: data.creditScoreDisplay.lastUpdated,
                          nextUpdate: data.creditScoreDisplay.nextUpdate,
                          creditAgency: data.creditScoreDisplay.creditAgency,
                          creditScoreGraphData: data.creditScoreGraphData,
                        ),
                        const AvaTitle(title: 'Credit Factors'),
                        CreditFactorsCard(
                          creditFactorsDisplay: data.creditFactorsDisplay,
                        ),
                        const AvaTitle(title: 'Account Details'),
                        AccountDetailsCard(details: data.accountDetails),
                        const SizedBox(height: 34),
                        CreditCardBalanceCard(
                          cCData: data.creditCardAccountsAggregate,
                        ),
                        const AvaTitle(title: 'Open credit card accounts'),
                        CreditCardAccountsCard(
                          cCAccounts:
                              data
                                  .creditCardAccountsAggregate
                                  .creditCardAccountsDisplay,
                        ),
                        const SizedBox(height: 34),
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

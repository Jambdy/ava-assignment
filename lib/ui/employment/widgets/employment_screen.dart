import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../utils/layout_utils.dart';
import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../view_models/employment_viewmodel.dart';
import 'employment_form.dart';

@RoutePage()
class EmploymentScreen extends ConsumerWidget {
  const EmploymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employmentState = ref.watch(employmentViewModelProvider);
    final employmentViewModel = ref.read(employmentViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.manilla,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.textPrimaryDark,
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: employmentState.when(
        data: (data) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: LayoutUtils.constrainedWidth(context),
                padding: const EdgeInsets.fromLTRB(
                  Constants.paddingDefault,
                  0,
                  Constants.paddingDefault,
                  Constants.paddingDefault,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Confirm your employment', style: AppTheme.titleLarge),
                    Text(
                      'Please review and confirm the below employment details are up-to-date.',
                      style: AppTheme.bodyRegular.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    const SizedBox(height: 32),
                    EmploymentInfoForm(eState: data, eVM: employmentViewModel),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

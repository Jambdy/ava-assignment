import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../state/employment_state.dart';
import '../view_models/employment_viewmodel.dart';

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
                width: 343,
                padding: const EdgeInsets.all(16.0),
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
                    const SizedBox(height: 32.0),
                    EmploymentInfoForm(
                      employmentDisplay: data.employmentDisplay,
                      employmentTypeOptions:
                          employmentViewModel.getEmploymentTypes(),
                      payFrequencyOptions:
                          employmentViewModel.getPayFrequencies(),
                    ),
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

enum _TextInputs {
  employer,
  jobTitle,
  grossAnnualIncome,
  nextPayday,
  employerAddress,
}

class EmploymentInfoForm extends StatefulWidget {
  final EmploymentDisplay employmentDisplay;
  final List<String> employmentTypeOptions;
  final List<String> payFrequencyOptions;

  const EmploymentInfoForm({
    super.key,
    required this.employmentDisplay,
    required this.employmentTypeOptions,
    required this.payFrequencyOptions,
  });

  @override
  State<EmploymentInfoForm> createState() => _EmploymentInfoFormState();
}

class _EmploymentInfoFormState extends State<EmploymentInfoForm> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingController for each text input field
  final _controllerMap = <_TextInputs, TextEditingController>{
    _TextInputs.employer: TextEditingController(),
    _TextInputs.jobTitle: TextEditingController(),
    _TextInputs.grossAnnualIncome: TextEditingController(),
    _TextInputs.nextPayday: TextEditingController(),
    _TextInputs.employerAddress: TextEditingController(),
  };

  // Properties for dropdown fields
  String? _selectedEmploymentType;
  String? _selectedPayFrequency;
  String? _selectedEmploymentYears;
  final List<String> _employmentYearsOptions =
      Iterable<int>.generate(50).map((e) => e.toString()).toList();
  String? _selectedEmploymentMonths;
  final List<String> _employmentMonthsOptions =
      Iterable<int>.generate(12).map((e) => e.toString()).toList();

  // Property for radio buttons
  String? _isDirectDeposit;

  bool _enabled = false;

  @override
  void dispose() {
    _controllerMap.forEach((_, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = MaterialLocalizations.of(
          context,
        ).formatFullDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvaInput(
                displayValue: widget.employmentDisplay.employmentTypeDisplay,
                label: 'Employment type',
                inputWidget: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Select Employment Type',
                  ),
                  value: _selectedEmploymentType,
                  items:
                      widget.employmentTypeOptions
                          .map(
                            (opt) => DropdownMenuItem(
                              value: opt,
                              child: Text(opt, style: AppTheme.bodyRegular),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) =>
                          setState(() => _selectedEmploymentType = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an employment type';
                    }
                    return null;
                  },
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                ),
                enabled: _enabled,
              ),
              AvaInput(
                displayValue: widget.employmentDisplay.employer,
                label: 'Employer',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.employer],
                  decoration: InputDecoration(
                    hintText: 'Enter your employment details',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an employer';
                    }
                    return null;
                  },
                ),
                enabled: _enabled,
              ),
              AvaInput(
                displayValue: widget.employmentDisplay.jobTitle,
                label: 'Job Title',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.jobTitle],
                  decoration: InputDecoration(hintText: 'Enter your job title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a job title';
                    }
                    return null;
                  },
                ),
                enabled: _enabled,
              ),
              AvaInput(
                displayValue: widget.employmentDisplay.grossAnnualIncomeDisplay,
                label: 'Gross annual income',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.grossAnnualIncome],
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Enter your annual income',
                    prefixText: '\$',
                    suffixText: '/year',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an annual income';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    final formattedValue = NumberFormat(
                      '#,###',
                    ).format(int.tryParse(value) ?? 0);
                    _controllerMap[_TextInputs.grossAnnualIncome]!.text =
                        formattedValue;
                    _controllerMap[_TextInputs.grossAnnualIncome]!
                        .selection = TextSelection.fromPosition(
                      TextPosition(offset: formattedValue.length),
                    );
                  },
                ),
                enabled: _enabled,
              ),
              AvaInput(
                displayValue: widget.employmentDisplay.payFrequencyDisplay,
                label: 'Pay Frequency',
                inputWidget: DropdownButtonFormField<String>(
                  decoration: InputDecoration(hintText: 'Select Pay Frequency'),
                  value: _selectedPayFrequency,
                  items:
                      widget.payFrequencyOptions
                          .map(
                            (opt) => DropdownMenuItem(
                              value: opt,
                              child: Text(opt, style: AppTheme.bodyRegular),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) => setState(() => _selectedPayFrequency = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an pay frequency';
                    }
                    return null;
                  },
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                ),
                enabled: _enabled,
              ),
              AvaInput(
                displayValue: widget.employmentDisplay.payFrequencyDisplay,
                label: 'My next payday is',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.nextPayday],
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Select Date',
                    suffixIcon: Icon(Icons.calendar_month_rounded),
                  ),
                  onTap:
                      () => _pickDate(
                        context,
                        _controllerMap[_TextInputs.nextPayday]!,
                      ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),

                enabled: _enabled,
              ),
              AvaInput(
                displayValue: widget.employmentDisplay.employerAddress,
                label: 'Employer address',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.employerAddress],
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Enter your employer address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    // Simple validation: starts with number and space
                    final regex = RegExp(r'^\d+\s+.+');
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid address (e.g., 123 Main St)';
                    }
                    return null;
                  },
                ),
                enabled: _enabled,
              ),
              AvaInput(
                displayValue: widget.employmentDisplay.timeWithEmployerDisplay,
                label: 'Time with employer',
                inputWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 146,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(hintText: 'Select Year'),
                        value: _selectedEmploymentYears,
                        items:
                            _employmentYearsOptions
                                .map(
                                  (opt) => DropdownMenuItem(
                                    value: opt,
                                    child: Text(
                                      opt,
                                      style: AppTheme.bodyRegular,
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (value) => setState(
                              () => _selectedEmploymentYears = value,
                            ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select year';
                          }
                          return null;
                        },
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                    ),
                    SizedBox(
                      width: 146,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(hintText: 'Select Month'),
                        value: _selectedEmploymentMonths,
                        items:
                            _employmentMonthsOptions
                                .map(
                                  (opt) => DropdownMenuItem(
                                    value: opt,
                                    child: Text(
                                      opt,
                                      style: AppTheme.bodyRegular,
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (value) => setState(
                              () => _selectedEmploymentMonths = value,
                            ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select month';
                          }
                          return null;
                        },
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                    ),
                  ],
                ),
                enabled: _enabled,
              ),
              AvaInput(
                displayValue: widget.employmentDisplay.isDirectDepositDisplay,
                label: 'Is your pay a direct deposit?',
                inputWidget: FormField<String>(
                  initialValue: _isDirectDeposit,
                  validator: (v) => v == null ? 'Please select one' : null,
                  builder: (field) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...['Yes', 'No'].map(
                          (value) => SizedBox(
                            width: 120,
                            child: RadioListTile<String>(
                              title: Text(value, style: AppTheme.bodyRegular),
                              value: value,
                              groupValue: field.value,
                              onChanged: (v) {
                                field.didChange(v);
                                setState(() => _isDirectDeposit = v);
                              },
                            ),
                          ),
                        ),
                        // if (field.hasError)
                        //   Text(field.errorText!,
                        //       style: TextStyle(color: Colors.red[700], fontSize: 12)),
                      ],
                    );
                  },
                ),
                enabled: _enabled,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                _enabled = true;
              });
            },
            child: Text('Edit'),
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _enabled = false;
              });
            },
            child: Text('Confirm'),
          ),
        ),
      ],
    );
  }
}

class AvaInput extends StatelessWidget {
  /// Value to display if disabled
  final String displayValue;

  /// Input label
  final String label;

  /// Input widget (text, dropdown, etc.) Shown if input is enabled
  final Widget inputWidget;

  /// Whether the input is enabled or not
  final bool enabled;

  const AvaInput({
    super.key,
    required this.displayValue,
    required this.label,
    required this.inputWidget,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            label,
            style:
                enabled
                    ? AppTheme.detailEmphasis
                    : AppTheme.overlineRegular.copyWith(
                      color: AppColors.textLight,
                    ),
          ),
        ),
        enabled ? inputWidget : Text(displayValue, style: AppTheme.bodyRegular),
        const SizedBox(height: 16),
      ],
    );
  }
}

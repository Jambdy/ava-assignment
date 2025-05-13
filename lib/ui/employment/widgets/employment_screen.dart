import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../models/employment.dart';
import '../../../routing/router.gr.dart';
import '../../../utils/layout_utils.dart';
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
                    EmploymentInfoForm(
                      eState: data,
                      employmentTypeOptions:
                          employmentViewModel.getEmploymentTypes(),
                      payFrequencyOptions:
                          employmentViewModel.getPayFrequencies(),
                      getFormattedDate: employmentViewModel.getFormattedDate,
                      getFormattedNumber:
                          employmentViewModel.getFormattedNumber,
                      updateEmploymentInfo:
                          employmentViewModel.updateEmploymentInfo,
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
  final EmploymentState? eState;
  final Map<EmploymentType, String> employmentTypeOptions;
  final Map<PayFrequency, String> payFrequencyOptions;
  final Function(DateTime) getFormattedDate;
  final Function(num) getFormattedNumber;
  final Function(EmploymentUpdate) updateEmploymentInfo;

  const EmploymentInfoForm({
    super.key,
    required this.eState,
    required this.employmentTypeOptions,
    required this.payFrequencyOptions,
    required this.getFormattedDate,
    required this.getFormattedNumber,
    required this.updateEmploymentInfo,
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

  // Additional property for date picker
  DateTime? _selectedDate;

  // Properties for dropdown fields
  EmploymentType? _selectedEmploymentType;
  PayFrequency? _selectedPayFrequency;
  int? _selectedEmploymentYears;
  final List<int> _employmentYearsOptions = Iterable<int>.generate(50).toList();
  int? _selectedEmploymentMonths;
  final List<int> _employmentMonthsOptions =
      Iterable<int>.generate(12).toList();

  // Property for radio buttons
  String? _isDirectDeposit;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.eState?.employment != null) {
      // Initialize the selected values with the current values from the widget
      _selectedEmploymentType = widget.eState!.employment!.employmentType;
      _selectedPayFrequency = widget.eState!.employment!.payFrequency;
      _selectedEmploymentYears = widget.eState!.yearsPartWithEmployer;
      _selectedEmploymentMonths = widget.eState!.monthsPartWithEmployer;
      _isDirectDeposit = widget.eState!.isDirectDepositDisplay;
      _selectedDate = widget.eState!.employment!.nextPayDay;

      // Initialize the text controllers with the current values
      _controllerMap[_TextInputs.employer]!.text =
          widget.eState!.employment!.employer;
      _controllerMap[_TextInputs.jobTitle]!.text =
          widget.eState!.employment!.jobTitle;
      _controllerMap[_TextInputs.grossAnnualIncome]!.text =
          widget.eState!.grossAnnualIncomeString;
      _controllerMap[_TextInputs.nextPayday]!.text =
          widget.eState!.nextPayDayDisplay;
      _controllerMap[_TextInputs.employerAddress]!.text =
          widget.eState!.employment!.employerAddress;
    } else {
      // If no employment display is provided, enable inputs for initial collection
      _isEditing = true;
    }
  }

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
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        controller.text = widget.getFormattedDate(_selectedDate!);
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
              InputWrapper(
                displayValue: widget.eState?.employmentTypeDisplay,
                label: 'Employment type',
                inputWidget: DropdownButtonFormField<EmploymentType>(
                  decoration: const InputDecoration(
                    hintText: 'Select Employment Type',
                  ),
                  value: _selectedEmploymentType,
                  items:
                      widget.employmentTypeOptions.entries
                          .map(
                            (entry) => DropdownMenuItem(
                              value: entry.key,
                              child: Text(
                                entry.value,
                                style: AppTheme.bodyRegular,
                              ),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) =>
                          setState(() => _selectedEmploymentType = value),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an employment type';
                    }
                    return null;
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                ),
                enabled: _isEditing,
              ),
              InputWrapper(
                displayValue: widget.eState?.employment?.employer,
                label: 'Employer',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.employer],
                  decoration: const InputDecoration(
                    hintText: 'Enter your employment details',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an employer';
                    }
                    return null;
                  },
                ),
                enabled: _isEditing,
              ),
              InputWrapper(
                displayValue: widget.eState?.employment!.jobTitle,
                label: 'Job Title',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.jobTitle],
                  decoration: const InputDecoration(
                    hintText: 'Enter your job title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a job title';
                    }
                    return null;
                  },
                ),
                enabled: _isEditing,
              ),
              InputWrapper(
                displayValue: widget.eState?.grossAnnualIncomeDisplay,
                label: 'Gross annual income',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.grossAnnualIncome],
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
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
                    final formattedValue = widget.getFormattedNumber(
                      int.tryParse(value) ?? 0,
                    );
                    _controllerMap[_TextInputs.grossAnnualIncome]!.text =
                        formattedValue;
                    _controllerMap[_TextInputs.grossAnnualIncome]!
                        .selection = TextSelection.fromPosition(
                      TextPosition(offset: formattedValue.length),
                    );
                  },
                ),
                enabled: _isEditing,
              ),
              InputWrapper(
                displayValue: widget.eState?.payFrequencyDisplay,
                label: 'Pay Frequency',
                inputWidget: DropdownButtonFormField<PayFrequency>(
                  decoration: const InputDecoration(
                    hintText: 'Select Pay Frequency',
                  ),
                  value: _selectedPayFrequency,
                  items:
                      widget.payFrequencyOptions.entries
                          .map(
                            (entry) => DropdownMenuItem<PayFrequency>(
                              value: entry.key,
                              child: Text(
                                entry.value,
                                style: AppTheme.bodyRegular,
                              ),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) => setState(() => _selectedPayFrequency = value),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an pay frequency';
                    }
                    return null;
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                ),
                enabled: _isEditing,
              ),
              InputWrapper(
                displayValue: widget.eState?.payFrequencyDisplay,
                label: 'My next payday is',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.nextPayday],
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Select Date',
                    suffixIcon: Icon(Icons.calendar_month_rounded),
                  ),
                  onTap: () {
                    _pickDate(context, _controllerMap[_TextInputs.nextPayday]!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),

                enabled: _isEditing,
              ),
              InputWrapper(
                displayValue: widget.eState?.employment!.employerAddress,
                label: 'Employer address',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.employerAddress],
                  maxLines: 2,
                  decoration: const InputDecoration(
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
                enabled: _isEditing,
              ),
              InputWrapper(
                displayValue: widget.eState?.timeWithEmployerDisplay,
                label: 'Time with employer',
                inputWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          hintText: 'Select Year',
                        ),
                        value: _selectedEmploymentYears,
                        items:
                            _employmentYearsOptions
                                .map(
                                  (opt) => DropdownMenuItem(
                                    value: opt,
                                    child: Text(
                                      '$opt ${opt == 1 ? 'year' : 'years'}',
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
                          if (value == null) {
                            return 'Please select year';
                          }
                          return null;
                        },
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                    ),
                    const SizedBox(width: Constants.paddingDefault),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          hintText: 'Select Month',
                        ),
                        value: _selectedEmploymentMonths,
                        items:
                            _employmentMonthsOptions
                                .map(
                                  (opt) => DropdownMenuItem(
                                    value: opt,
                                    child: Text(
                                      '$opt ${opt == 1 ? 'month' : 'months'}',
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
                          if (value == null) {
                            return 'Please select month';
                          }
                          return null;
                        },
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                    ),
                  ],
                ),
                enabled: _isEditing,
              ),
              InputWrapper(
                displayValue: widget.eState?.isDirectDepositDisplay,
                label: 'Is your pay a direct deposit?',
                inputWidget: FormField<String>(
                  initialValue: _isDirectDeposit,
                  validator: (v) => v == null ? 'Please select one' : null,
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...['Yes', 'No'].map(
                              (value) => SizedBox(
                                width: 130,
                                child: RadioListTile<String>(
                                  title: Text(
                                    value,
                                    style: AppTheme.bodyRegular,
                                  ),
                                  value: value,
                                  groupValue: field.value,
                                  onChanged: (v) {
                                    field.didChange(v);
                                    setState(() => _isDirectDeposit = v);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (field.hasError)
                          Text(
                            field.errorText!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                enabled: _isEditing,
              ),
            ],
          ),
        ),
        const SizedBox(height: Constants.paddingDefault),
        Visibility(
          visible: !_isEditing,
          child: Container(
            width: double.infinity,
            height: 44,
            margin: const EdgeInsets.only(bottom: 8),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              child: const Text('Edit'),
            ),
          ),
        ),
        Visibility(
          visible: !_isEditing,
          child: SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                context.router.push(HomeRoute(requestFeedback: true));
              },
              child: const Text('Confirm'),
            ),
          ),
        ),
        Visibility(
          visible: _isEditing,
          child: SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.updateEmploymentInfo(
                    EmploymentUpdate(
                      employmentType: _selectedEmploymentType!,
                      employer: _controllerMap[_TextInputs.employer]!.text,
                      jobTitle: _controllerMap[_TextInputs.jobTitle]!.text,
                      grossAnnualIncomeString:
                          _controllerMap[_TextInputs.grossAnnualIncome]!.text,
                      payFrequency: _selectedPayFrequency!,
                      employerAddress:
                          _controllerMap[_TextInputs.employerAddress]!.text,
                      yearsPartWithEmployer: _selectedEmploymentYears!,
                      monthsPartWithEmployer: _selectedEmploymentMonths!,
                      nextPayDay: _selectedDate!,
                      isDirectDeposit: _isDirectDeposit == 'Yes',
                    ),
                  );
                  setState(() {
                    _isEditing = false;
                  });
                }
              },
              child: const Text('Continue'),
            ),
          ),
        ),
        const SizedBox(height: Constants.paddingDefault),
      ],
    );
  }
}

class InputWrapper extends StatelessWidget {
  /// Value to display if disabled
  final String? displayValue;

  /// Input label
  final String label;

  /// Input widget (text, dropdown, etc.) Shown if input is enabled
  final Widget inputWidget;

  /// Whether the input is enabled or not
  final bool enabled;

  const InputWrapper({
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
          padding: const EdgeInsets.only(bottom: 2),
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
        enabled
            ? inputWidget
            : Text(displayValue ?? '', style: AppTheme.bodyRegular),
        const SizedBox(height: Constants.paddingDefault),
      ],
    );
  }
}

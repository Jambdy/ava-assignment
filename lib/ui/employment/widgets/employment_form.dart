import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/constants.dart';
import '../../../models/employment.dart';
import '../../../routing/router.gr.dart';
import '../../../utils/format_utils.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava.dart';
import '../state/employment_state.dart';
import '../view_models/employment_viewmodel.dart';

enum _TextInputs {
  employer,
  jobTitle,
  grossAnnualIncome,
  nextPayday,
  employerAddress,
}

class EmploymentInfoForm extends StatefulWidget {
  final EmploymentState? eState;
  final EmploymentViewModel eVM;

  const EmploymentInfoForm({
    super.key,
    required this.eState,
    required this.eVM,
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
      // Initialize the selected values with the current values
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
      // Start in editing mode if employment data not currently set
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
        controller.text = FormatUtils.formatDateFull(_selectedDate!);
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
              // Dropdown for Employment Type
              AvaInputWrapper(
                displayValue: widget.eState?.employmentTypeDisplay,
                label: 'Employment type',
                inputWidget: DropdownButtonFormField<EmploymentType>(
                  decoration: const InputDecoration(
                    hintText: 'Select Employment Type',
                  ),
                  value: _selectedEmploymentType,
                  items:
                      widget.eVM
                          .getEmploymentTypes()
                          .entries
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
                  validator: widget.eVM.validateEmploymentType,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                ),
                enabled: _isEditing,
              ),

              // Text input for Employer
              AvaInputWrapper(
                displayValue: widget.eState?.employment?.employer,
                label: 'Employer',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.employer],
                  decoration: const InputDecoration(
                    hintText: 'Enter your employment details',
                  ),
                  validator: widget.eVM.validateEmployer,
                ),
                enabled: _isEditing,
              ),

              // Text input for Job Title
              AvaInputWrapper(
                displayValue: widget.eState?.employment!.jobTitle,
                label: 'Job Title',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.jobTitle],
                  decoration: const InputDecoration(
                    hintText: 'Enter your job title',
                  ),
                  validator: widget.eVM.validateJobTitle,
                ),
                enabled: _isEditing,
              ),

              // Text input for Gross Annual Income
              AvaInputWrapper(
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
                  validator: widget.eVM.validateGrossAnnualIncome,
                  onChanged: (value) {
                    final formattedValue = FormatUtils.formatNumberComma(
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

              // Dropdown for Pay Frequency
              AvaInputWrapper(
                displayValue: widget.eState?.payFrequencyDisplay,
                label: 'Pay Frequency',
                inputWidget: DropdownButtonFormField<PayFrequency>(
                  decoration: const InputDecoration(
                    hintText: 'Select Pay Frequency',
                  ),
                  value: _selectedPayFrequency,
                  items:
                      widget.eVM
                          .getPayFrequencies()
                          .entries
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
                  validator: widget.eVM.validatePayFrequency,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                ),
                enabled: _isEditing,
              ),

              // Date picker for Next Pay Day
              AvaInputWrapper(
                displayValue: widget.eState?.nextPayDayDisplay,
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
                  validator: widget.eVM.validateNextPayday,
                ),

                enabled: _isEditing,
              ),

              // Radio buttons for Direct Deposit
              AvaInputWrapper(
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

              // Text input for Employer Address
              AvaInputWrapper(
                displayValue: widget.eState?.employment!.employerAddress,
                label: 'Employer address',
                inputWidget: TextFormField(
                  controller: _controllerMap[_TextInputs.employerAddress],
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Enter your employer address',
                  ),
                  validator: widget.eVM.validateEmployerAddress,
                ),
                enabled: _isEditing,
              ),

              // Dropdown for Time with Employer
              AvaInputWrapper(
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
                        validator: widget.eVM.validateEmploymentYears,
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
                        validator: widget.eVM.validateEmploymentMonths,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                    ),
                  ],
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
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.eVM.updateEmploymentInfo(
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
                      isDirectDepositDisplay: _isDirectDeposit!,
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

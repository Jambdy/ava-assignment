import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/employment_repository.dart';
import '../../../models/employment.dart';
import '../../../utils/format_utils.dart';
import '../state/employment_state.dart';

part 'employment_viewmodel.g.dart';

@Riverpod(keepAlive: false)
class EmploymentViewModel extends _$EmploymentViewModel {
  @override
  Future<EmploymentState?> build() async {
    print('Building EmploymentViewModel');
    final employment =
        await ref.read(employmentRepositoryProvider).getEmploymentInfo();
    return employment != null ? _mapToEmploymentState(employment) : null;
  }

  /// Update employment information state
  Future<void> updateEmploymentInfo(EmploymentUpdate employmentUpdate) async {
    state = AsyncValue.data(
      _mapToEmploymentState(
        Employment(
          employmentType: employmentUpdate.employmentType,
          employer: employmentUpdate.employer,
          jobTitle: employmentUpdate.jobTitle,
          grossAnnualIncome: int.parse(
            employmentUpdate.grossAnnualIncomeString.replaceAll(',', ''),
          ),
          payFrequency: employmentUpdate.payFrequency,
          employerAddress: employmentUpdate.employerAddress,
          monthsWithEmployer:
              (employmentUpdate.yearsPartWithEmployer * 12) +
              employmentUpdate.monthsPartWithEmployer,
          nextPayDay: employmentUpdate.nextPayDay,
          isDirectDeposit: employmentUpdate.isDirectDepositDisplay == 'Yes',
        ),
      ),
    );
  }

  /// Persist employment information on confirm
  Future<void> persistEmploymentInfo() async {
    await ref
        .read(employmentRepositoryProvider)
        .persistEmploymentInfo(state.value!.employment!);
  }

  EmploymentState _mapToEmploymentState(Employment employment) {
    var employmentTypeDisplay = _mapEmploymentTypeDisplay(
      employment.employmentType,
    );
    var grossAnnualIncomeString = FormatUtils.formatNumberComma(
      employment.grossAnnualIncome,
    );
    var grossAnnualIncomeDisplay = '\$$grossAnnualIncomeString/year';
    var payFrequencyDisplay = _mapPayFrequencyDisplay(employment.payFrequency);
    var nextPayDayDisplay = FormatUtils.formatDateFull(employment.nextPayDay);
    var yearsEmp = employment.monthsWithEmployer ~/ 12;
    var monthsEmp = employment.monthsWithEmployer % 12;
    var timeWithEmployerDisplay =
        '$yearsEmp ${yearsEmp == 1 ? 'year' : 'years'} '
        '$monthsEmp ${monthsEmp == 1 ? 'month' : 'months'}';
    var isDirectDepositDisplay = employment.isDirectDeposit ? 'Yes' : 'No';

    return EmploymentState(
      employment: employment.copyWith(),
      employmentTypeDisplay: employmentTypeDisplay,
      grossAnnualIncomeString: grossAnnualIncomeString,
      grossAnnualIncomeDisplay: grossAnnualIncomeDisplay,
      payFrequencyDisplay: payFrequencyDisplay,
      nextPayDayDisplay: nextPayDayDisplay,
      timeWithEmployerDisplay: timeWithEmployerDisplay,
      yearsPartWithEmployer: yearsEmp,
      monthsPartWithEmployer: monthsEmp,
      isDirectDepositDisplay: isDirectDepositDisplay,
    );
  }

  String _mapEmploymentTypeDisplay(EmploymentType value) {
    switch (value) {
      case EmploymentType.fullTime:
        return 'Full Time';
      case EmploymentType.partTime:
        return 'Part Time';
      case EmploymentType.student:
        return 'Student';
      case EmploymentType.retired:
        return 'Retired';
      case EmploymentType.unemployed:
        return 'Unemployed';
    }
  }

  String _mapPayFrequencyDisplay(PayFrequency value) {
    switch (value) {
      case PayFrequency.weekly:
        return 'Weekly';
      case PayFrequency.biWeekly:
        return 'Bi-Weekly';
      case PayFrequency.monthly:
        return 'Monthly';
      case PayFrequency.other:
        return 'Other';
    }
  }

  /// Get Employment Type dropdown values
  Map<EmploymentType, String> getEmploymentTypes() {
    return EmploymentType.values.asMap().map(
      (_, value) => MapEntry(value, _mapEmploymentTypeDisplay(value)),
    );
  }

  /// Get Pay Frequency dropdown values
  Map<PayFrequency, String> getPayFrequencies() {
    return PayFrequency.values.asMap().map(
      (_, value) => MapEntry(value, _mapPayFrequencyDisplay(value)),
    );
  }

  /// Validate Employment Type dropdown
  String? validateEmploymentType(EmploymentType? value) {
    if (value == null) {
      return 'Please select an employment type';
    }
    return null;
  }

  /// Validate Employer text field
  String? validateEmployer(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an employer';
    }
    return null;
  }

  /// Validate Job Title text field
  String? validateJobTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a job title';
    }
    return null;
  }

  /// Validate Gross Annual Income text field
  String? validateGrossAnnualIncome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an annual income';
    }
    // Remove non-digit characters and parse
    final numeric = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeric.isEmpty) {
      return 'Income must be a number';
    }
    return null;
  }

  /// Validate Pay Frequency dropdown
  String? validatePayFrequency(PayFrequency? value) {
    if (value == null) {
      return 'Please select a pay frequency';
    }
    return null;
  }

  /// Validate Next Payday date picker
  String? validateNextPayday(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a date';
    }
    return null;
  }

  /// Validate Employer Address text field
  String? validateEmployerAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an address';
    }
    final regex = RegExp(r'^\d+\s+.+');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid address (e.g., 123 Main St)';
    }
    return null;
  }

  /// Validate Time with Employer - Years dropdown
  String? validateEmploymentYears(int? value) {
    if (value == null) {
      return 'Please select year';
    }
    return null;
  }

  /// Validate Time with Employer - Months dropdown
  String? validateEmploymentMonths(int? value) {
    if (value == null) {
      return 'Please select month';
    }
    return null;
  }

  /// Validate Direct Deposit radio field
  String? validateDirectDeposit(String? value) {
    if (value == null) {
      return 'Please select one';
    }
    return null;
  }
}

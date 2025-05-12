import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/employment_repository.dart';
import '../../../models/employment.dart';
import '../state/employment_state.dart';

part 'employment_viewmodel.g.dart';

@riverpod
class EmploymentViewModel extends _$EmploymentViewModel {
  @override
  Future<EmploymentState> build() async {
    final employment =
        await ref.read(employmentRepositoryProvider).getEmploymentInfo();
    return EmploymentState(
      employmentDisplay: _mapToEmploymentDisplay(employment),
    );
  }

  EmploymentDisplay _mapToEmploymentDisplay(Employment employment) {
    var employmentTypeDisplay = _mapEmploymentTypeDisplay(
      employment.employmentType,
    );
    var grossAnnualIncomeDisplay =
        '\$${NumberFormat('#,###').format(employment.grossAnnualIncome)}/year';
    var payFrequencyDisplay = _mapPayFrequencyDisplay(employment.payFrequency);
    var nextPayDayDisplay = DateFormat(
      "MMM d'${_getDaySuffix(employment.nextPayDay.day)}', y (EEEE)",
    ).format(employment.nextPayDay);
    var yearsEmp = employment.monthsWithEmployer ~/ 12;
    var monthsEmp = employment.monthsWithEmployer % 12;
    var timeWithEmployerDisplay =
        '$yearsEmp ${yearsEmp == 1 ? 'year' : 'years'} '
        '$monthsEmp ${monthsEmp == 1 ? 'month' : 'months'}';
    var isDirectDepositDisplay = employment.isDirectDeposit ? 'Yes' : 'No';

    return EmploymentDisplay(
      employmentType: employment.employmentType,
      employer: employment.employer,
      jobTitle: employment.jobTitle,
      grossAnnualIncome: employment.grossAnnualIncome,
      payFrequency: employment.payFrequency,
      employerAddress: employment.employerAddress,
      monthsWithEmployer: employment.monthsWithEmployer,
      nextPayDay: employment.nextPayDay,
      isDirectDeposit: employment.isDirectDeposit,
      employmentTypeDisplay: employmentTypeDisplay,
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

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  List<String> getEmploymentTypes() {
    return EmploymentType.values
        .map((e) => _mapEmploymentTypeDisplay(e))
        .toList();
  }

  List<String> getPayFrequencies() {
    return PayFrequency.values.map((e) => _mapPayFrequencyDisplay(e)).toList();
  }
}

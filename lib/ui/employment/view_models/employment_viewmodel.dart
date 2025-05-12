import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/employment_repository.dart';
import '../../../models/employment.dart';
import '../state/employment_state.dart';

part 'employment_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class EmploymentViewModel extends _$EmploymentViewModel {
  @override
  Future<EmploymentState?> build() async {
    final employment =
        await ref.read(employmentRepositoryProvider).getEmploymentInfo();
    return employment != null ? _mapToEmploymentState(employment) : null;
  }

  Future<void> updateEmploymentInfo(EmploymentUpdate employmentUpdate) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updated = await ref
          .read(employmentRepositoryProvider)
          .updateEmploymentInfo(
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
              isDirectDeposit: employmentUpdate.isDirectDeposit,
            ),
          );
      return _mapToEmploymentState(updated);
    });
  }

  EmploymentState _mapToEmploymentState(Employment employment) {
    var employmentTypeDisplay = _mapEmploymentTypeDisplay(
      employment.employmentType,
    );
    var grossAnnualIncomeString = getFormattedNumber(
      employment.grossAnnualIncome,
    );
    var grossAnnualIncomeDisplay = '\$$grossAnnualIncomeString/year';
    var payFrequencyDisplay = _mapPayFrequencyDisplay(employment.payFrequency);
    var nextPayDayDisplay = getFormattedDate(employment.nextPayDay);
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

  Map<EmploymentType, String> getEmploymentTypes() {
    return EmploymentType.values.asMap().map(
      (_, value) => MapEntry(value, _mapEmploymentTypeDisplay(value)),
    );
  }

  Map<PayFrequency, String> getPayFrequencies() {
    return PayFrequency.values.asMap().map(
      (_, value) => MapEntry(value, _mapPayFrequencyDisplay(value)),
    );
  }

  String getFormattedDate(DateTime date) {
    return DateFormat(
      "MMM d'${_getDaySuffix(date.day)}', y (EEEE)",
    ).format(date);
  }

  String getFormattedNumber(num number) {
    return NumberFormat('#,###').format(number);
  }
}

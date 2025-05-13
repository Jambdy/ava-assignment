import '../../../models/employment.dart';

class EmploymentState {
  final Employment? employment;
  final String employmentTypeDisplay;
  final String grossAnnualIncomeString;
  final String grossAnnualIncomeDisplay;
  final String payFrequencyDisplay;
  final String nextPayDayDisplay;
  final String timeWithEmployerDisplay;
  final int yearsPartWithEmployer;
  final int monthsPartWithEmployer;
  final String isDirectDepositDisplay;

  EmploymentState({
    required this.employment,
    required this.employmentTypeDisplay,
    required this.grossAnnualIncomeString,
    required this.grossAnnualIncomeDisplay,
    required this.payFrequencyDisplay,
    required this.nextPayDayDisplay,
    required this.timeWithEmployerDisplay,
    required this.yearsPartWithEmployer,
    required this.monthsPartWithEmployer,
    required this.isDirectDepositDisplay,
  });
}

class EmploymentUpdate {
  final EmploymentType employmentType;
  final String employer;
  final String jobTitle;
  final String grossAnnualIncomeString;
  final PayFrequency payFrequency;
  final String employerAddress;
  final int yearsPartWithEmployer;
  final int monthsPartWithEmployer;
  final DateTime nextPayDay;
  final String isDirectDepositDisplay;

  EmploymentUpdate({
    required this.employmentType,
    required this.employer,
    required this.jobTitle,
    required this.grossAnnualIncomeString,
    required this.payFrequency,
    required this.employerAddress,
    required this.yearsPartWithEmployer,
    required this.monthsPartWithEmployer,
    required this.nextPayDay,
    required this.isDirectDepositDisplay,
  });
}

import '../../../models/employment.dart';

class EmploymentState {
  final EmploymentDisplay? employmentDisplay;

  EmploymentState({required this.employmentDisplay});
}

class EmploymentDisplay extends Employment {
  final String employmentTypeDisplay;
  final String grossAnnualIncomeString;
  final String grossAnnualIncomeDisplay;
  final String payFrequencyDisplay;
  final String nextPayDayDisplay;
  final String timeWithEmployerDisplay;
  final int yearsPartWithEmployer;
  final int monthsPartWithEmployer;
  final String isDirectDepositDisplay;

  EmploymentDisplay({
    required super.employmentType,
    required super.employer,
    required super.jobTitle,
    required super.grossAnnualIncome,
    required super.payFrequency,
    required super.employerAddress,
    required super.monthsWithEmployer,
    required super.nextPayDay,
    required super.isDirectDeposit,
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
  final bool isDirectDeposit;

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
    required this.isDirectDeposit,
  });
}

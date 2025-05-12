import '../../../models/employment.dart';

class EmploymentState {
  final EmploymentDisplay employmentDisplay;

  EmploymentState({required this.employmentDisplay});
}

class EmploymentDisplay extends Employment {
  final String employmentTypeDisplay;
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
    required this.grossAnnualIncomeDisplay,
    required this.payFrequencyDisplay,
    required this.nextPayDayDisplay,
    required this.timeWithEmployerDisplay,
    required this.yearsPartWithEmployer,
    required this.monthsPartWithEmployer,
    required this.isDirectDepositDisplay,
  });
}

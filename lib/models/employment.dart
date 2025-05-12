class Employment {
  final EmploymentType employmentType;
  final String employer;
  final String jobTitle;
  final int grossAnnualIncome;
  final PayFrequency payFrequency;
  final String employerAddress;
  final int monthsWithEmployer;
  final DateTime nextPayDay;
  final bool isDirectDeposit;

  Employment({
    required this.employmentType,
    required this.employer,
    required this.jobTitle,
    required this.grossAnnualIncome,
    required this.payFrequency,
    required this.employerAddress,
    required this.monthsWithEmployer,
    required this.nextPayDay,
    required this.isDirectDeposit,
  });
}

enum EmploymentType { fullTime, partTime, student, retired, unemployed }

enum PayFrequency { weekly, biWeekly, monthly, other }

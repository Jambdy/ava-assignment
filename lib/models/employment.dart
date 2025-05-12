import 'package:freezed_annotation/freezed_annotation.dart';

part 'employment.freezed.dart';
part 'employment.g.dart';

enum EmploymentType { fullTime, partTime, student, retired, unemployed }

enum PayFrequency { weekly, biWeekly, monthly, other }

@freezed
abstract class Employment with _$Employment {
  const factory Employment({
    required EmploymentType employmentType,
    required String employer,
    required String jobTitle,
    required int grossAnnualIncome,
    required PayFrequency payFrequency,
    required String employerAddress,
    required int monthsWithEmployer,
    required DateTime nextPayDay,
    required bool isDirectDeposit,
  }) = _Employment;

  factory Employment.fromJson(Map<String, dynamic> json) =>
      _$EmploymentFromJson(json);
}

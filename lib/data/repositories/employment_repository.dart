import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/employment.dart';

part 'employment_repository.g.dart';

@riverpod
EmploymentRepository employmentRepository(Ref ref) => EmploymentRepository();

class EmploymentRepository {
  Future<Employment> getEmploymentInfo() async {
    // TODO: Implement conversion from mock API response
    return Employment(
      employmentType: EmploymentType.fullTime,
      employer: 'Tech Corp',
      jobTitle: 'Software Engineer',
      grossAnnualIncome: 85000,
      payFrequency: PayFrequency.monthly,
      employerAddress: '123 Tech Street, Silicon Valley, CA',
      monthsWithEmployer: 24,
      nextPayDay: DateTime.now().add(Duration(days: 15)),
      isDirectDeposit: true,
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/employment.dart';

part 'employment_repository.g.dart';

@riverpod
EmploymentRepository employmentRepository(Ref ref) => EmploymentRepository();

class EmploymentRepository {
  Future<Employment?> getEmploymentInfo() async {
    // TODO: Implement conversion from mock API response
    return null;
    // return Employment(
    //   employmentType: EmploymentType.fullTime,
    //   employer: 'Tech Corp',
    //   jobTitle: 'Software Engineer',
    //   grossAnnualIncome: 85000,
    //   payFrequency: PayFrequency.monthly,
    //   employerAddress: '123 Tech Street, Silicon Valley, CA',
    //   monthsWithEmployer: 24,
    //   nextPayDay: DateTime.now().add(Duration(days: 15)),
    //   isDirectDeposit: true,
    // );
  }

  Future<Employment> updateEmploymentInfo(Employment employment) async {
    // Dummy call to simulate an API request
    await Future.delayed(const Duration(milliseconds: 200));
    return employment;
  }
}

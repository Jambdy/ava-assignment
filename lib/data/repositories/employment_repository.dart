import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/employment.dart';
import '../services/shared_preferences_service.dart';

part 'employment_repository.g.dart';

@riverpod
EmploymentRepository employmentRepository(Ref ref) {
  final sharedPrefService = ref.read(sharedPreferencesServiceProvider);
  return EmploymentRepository(sharedPrefService);
}

class EmploymentRepository {
  final SharedPreferencesService _sharedPrefService;
  final String _key = 'employment';

  EmploymentRepository(this._sharedPrefService);

  Future<Employment?> getEmploymentInfo() async {
    final storedEmployment = await _sharedPrefService.getValue<String>(_key);
    if (storedEmployment != null) {
      final Map<String, dynamic> json = jsonDecode(storedEmployment);
      return Employment.fromJson(json);
    }
    return null;
  }

  Future<Employment> updateEmploymentInfo(Employment employment) async {
    // Wait to simulate an API latency
    await Future.delayed(const Duration(milliseconds: 200));
    await _sharedPrefService.setValue(_key, jsonEncode(employment.toJson()));
    return employment;
  }
}

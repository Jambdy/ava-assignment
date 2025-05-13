import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/employment.dart';
import '../services/api_client.dart';
import '../services/shared_preferences_service.dart';

part 'employment_repository.g.dart';

@riverpod
EmploymentRepository employmentRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  final sharedPrefService = ref.read(sharedPreferencesServiceProvider);
  return EmploymentRepository(apiClient, sharedPrefService);
}

class EmploymentRepository {
  final ApiClient _apiClient;
  final SharedPreferencesService _sharedPrefService;
  final String _key = 'employment';

  EmploymentRepository(this._apiClient, this._sharedPrefService);

  Future<Employment?> getEmploymentInfo() async {
    final storedEmployment = await _sharedPrefService.getValue<String>(_key);
    if (storedEmployment != null) {
      final Map<String, dynamic> json = jsonDecode(storedEmployment);
      return Employment.fromJson(json);
    }
    return null;
  }

  Future<void> persistEmploymentInfo(Employment employment) async {
    await _apiClient.updateEmploymentInfo(employment);
    await _sharedPrefService.setValue(_key, jsonEncode(employment.toJson()));
  }
}

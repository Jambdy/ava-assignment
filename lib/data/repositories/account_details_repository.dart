import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/account_details.dart';
import '../services/api_client.dart';

part 'account_details_repository.g.dart';

@riverpod
AccountDetailsRepository accountDetailsRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return AccountDetailsRepository(apiClient);
}

class AccountDetailsRepository {
  final ApiClient _apiClient;

  AccountDetailsRepository(this._apiClient);

  Future<AccountDetails> getAccountDetails() async {
    var accountDetails = await _apiClient.getAccountDetails();
    return accountDetails.copyWith();
  }
}

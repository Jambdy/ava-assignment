import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/account_details.dart';

part 'account_details_repository.g.dart';

@riverpod
AccountDetailsRepository accountDetailsRepository(Ref ref) =>
    AccountDetailsRepository();

class AccountDetailsRepository {
  Future<AccountDetails> getAccountDetails() async {
    // TODO: Implement conversion from mock API response
    return AccountDetails(
      balance: Random().nextInt(101).toDouble(),
      spendLimit: 100,
      creditLimit: 6000,
    );
  }
}

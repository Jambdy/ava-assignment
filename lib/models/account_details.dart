import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_details.freezed.dart';
part 'account_details.g.dart';

@freezed
abstract class AccountDetails with _$AccountDetails {
  const factory AccountDetails({
    required double spendLimit,
    required double balance,
    required double creditLimit,
  }) = _AccountDetails;

  factory AccountDetails.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsFromJson(json);
}

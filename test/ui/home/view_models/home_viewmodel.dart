// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'package:riverpod/riverpod.dart';
//
// import '../../../lib/data/repositories/credit_score_repository.dart';
// import '../../../lib/models/credit_score.dart';
// import '../../../lib/ui/home/state/home_state.dart';
// import '../../../lib/ui/home/view_models/home_viewmodel.dart';
//
// // Generate a mock for CreditScoreRepository
// @GenerateMocks([CreditScoreRepository])
// import 'home_viewmodel_test.mocks.dart';
//
// void main() {
//   late MockCreditScoreRepository mockCreditScoreRepository;
//   late ProviderContainer container;
//
//   setUp(() {
//     mockCreditScoreRepository = MockCreditScoreRepository();
//     container = ProviderContainer(
//       overrides: [
//         creditScoreRepositoryProvider.overrideWithValue(mockCreditScoreRepository),
//       ],
//     );
//   });
//
//   tearDown(() {
//     container.dispose();
//   });
//
//   test('HomeViewModel.build returns correct HomeState', () async {
//     // Arrange
//     final mockCreditScore = CreditScore(
//       currentScore: 750,
//       scoreHistory: [
//         ScoreEntry(score: 700, date: DateTime(2023, 1, 1)),
//         ScoreEntry(score: 750, date: DateTime(2023, 2, 1)),
//       ],
//     );
//
//     when(mockCreditScoreRepository.getCreditScore())
//         .thenAnswer((_) async => mockCreditScore);
//
//     final homeViewModel = container.read(homeViewModelProvider.notifier);
//
//     // Act
//     final result = await homeViewModel.build();
//
//     // Assert
//     expect(result.creditScore, mockCreditScore);
//     expect(result.creditScoreStatus, 'Very Good');
//     expect(result.creditScoreGraphData.data, [700.0, 750.0]);
//     expect(result.creditScoreGraphData.minScore, 700);
//     expect(result.creditScoreGraphData.maxScore, 750);
//     expect(result.creditScoreGraphData.midScore, 725);
//   });
// }

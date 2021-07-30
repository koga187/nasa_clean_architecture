import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture/core/errors/failures.dart';
import 'package:nasa_clean_architecture/features/domain/usescases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_architecture/features/presenter/controller/home_store.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

class GetSpaceMediaFromDateUseCaseMock extends Mock
    implements GetSpaceMediaFromDateUseCase {}

void main() {
  late HomeStore homeStore;
  late GetSpaceMediaFromDateUseCase mockGetSpaceMediaFromDateUseCase;

  setUp(() {
    mockGetSpaceMediaFromDateUseCase = GetSpaceMediaFromDateUseCaseMock();

    homeStore = HomeStore(
      getSpaceMediaFromDateUseCase: mockGetSpaceMediaFromDateUseCase,
    );

    registerFallbackValue<DateTime>(DateTime(0, 0, 0));
  });

  test('should return a SpaceMedia from the usecase', () {
    when(() => mockGetSpaceMediaFromDateUseCase(any())).thenAnswer(
      (_) => Future.value(Right(tSpaceMedia)),
    );

    homeStore.getSpaceMediaFromDate(tDate);

    homeStore.observer(onState: (state) {
      expect(state, tSpaceMedia);
      verify(() => mockGetSpaceMediaFromDateUseCase(tDate)).called(1);
    });
  });
  test('should return Failure when usecase has an error', () {
    when(() => mockGetSpaceMediaFromDateUseCase(any())).thenAnswer(
      (_) => Future.value(Left(ServerFailure())),
    );

    homeStore.getSpaceMediaFromDate(tDate);

    homeStore.observer(onError: (error) {
      expect(error, Failures);
      verify(() => mockGetSpaceMediaFromDateUseCase(tDate)).called(1);
    });
  });
}

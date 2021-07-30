import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture/core/errors/failures.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_architecture/features/domain/usescases/get_space_media_from_date_usecase.dart';

import '../../../mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUseCase useCase;
  late ISpaceMediaRepository repository;

  late DateTime tDateTime;

  setUp(() {
    repository = MockSpaceMediaRepository();
    useCase = GetSpaceMediaFromDateUseCase(repository: repository);
    tDateTime = DateTime.now();
    registerFallbackValue(tDateTime);
  });
  test(
    'should get space media entity for a given date from the repository',
    () async {
      when(() => repository.getSpaceMediaFromDate(date: tDateTime)).thenAnswer(
          (_) async => Right<Failures, SpaceMediaEntity>(tSpaceMedia));

      final result = await useCase(
        tDateTime,
      ); // é chamado direto pois ele ja esta com o método call dentro dele que quando é o unico método implementado ele é chamado no invoke da classe.

      expect(Right(tSpaceMedia), result);
      verify(() => repository.getSpaceMediaFromDate(date: tDateTime)).called(1);
    },
  );
  test(
    'should return a Failure when dont\`t succed',
    () async {
      when(() =>
              repository.getSpaceMediaFromDate(date: captureAny(named: 'date')))
          .thenAnswer(
              (_) async => Left<Failures, SpaceMediaEntity>(ServerFailure()));

      final result = await useCase(
        tDateTime,
      ); // é chamado direto pois ele ja esta com o método call dentro dele que quando é o unico método implementado ele é chamado no invoke da classe.

      expect(Left(ServerFailure()), result);
      verify(() => repository.getSpaceMediaFromDate(date: tDateTime)).called(1);
    },
  );
  test(
    'should return a NullParamFailure when receives a null param',
    () async {
      final result = await useCase(null);

      expect(result, Left(NullParamFailure()));
      verifyNever(() => repository.getSpaceMediaFromDate(date: tDateTime));
    },
  );
}

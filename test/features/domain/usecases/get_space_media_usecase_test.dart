import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture/core/usecase/use_case.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_architecture/features/domain/usescases/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUseCase useCase;
  late ISpaceMediaRepository repository;

  final tSpaceMedia = SpaceMediaEntity(
    description:
        "What celestial body wears the Necklace Nebula? First, analyses indicate that the Necklace is a planetary nebula, a gas cloud emitted by a star toward the end of its life. Also, what appears to be diamonds in the Necklace are actually bright knots of glowing gas.  In the center of the Necklace Nebula are likely two stars orbiting so close together that they share a common atmosphere and appear as one in the featured image by the Hubble Space Telescope.  The red-glowing gas clouds on the upper left and lower right are the results of jets from the center.  Exactly when and how the bright jets formed remains a topic of research.  The Necklace Nebula is only about 5,000 years old, spans about 5 light years, and can best be found with a large telescope toward the direction of the constellation of the Arrow (Sagitta).",
    mediaType: "image",
    title: "Jets from the Necklace Nebula",
    mediaUrl: "https://apod.nasa.gov/apod/image/2105/Necklace_Hubble_960.jpg",
  );


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
      when(() => repository.getSpaceMediaFromDate(dateTime: tDateTime)).thenAnswer(
          (_) async => Right<Failures, SpaceMediaEntity>(tSpaceMedia));

      final result = await useCase(
        tDateTime,
      ); // é chamado direto pois ele ja esta com o método call dentro dele que quando é o unico método implementado ele é chamado no invoke da classe.

      expect(Right(tSpaceMedia), result);
      verify(() => repository.getSpaceMediaFromDate(dateTime: tDateTime)).called(1);
    },
  );
  test(
    'should return a Failure when dont\`t succed',
    () async {
      when(() => repository.getSpaceMediaFromDate(dateTime: captureAny(named: 'dateTime'))).thenAnswer(
          (_) async => Left<Failures, SpaceMediaEntity>(ServerFailure()));

      final result = await useCase(
        tDateTime,
      ); // é chamado direto pois ele ja esta com o método call dentro dele que quando é o unico método implementado ele é chamado no invoke da classe.

      expect(Left(ServerFailure()), result);
      verify(() => repository.getSpaceMediaFromDate(dateTime: tDateTime)).called(1);
    },
  );
}

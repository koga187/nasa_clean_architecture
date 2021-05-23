import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture/core/errors/exceptions.dart';
import 'package:nasa_clean_architecture/core/errors/failures.dart';
import 'package:nasa_clean_architecture/features/data/datasource/space_media_data_source.dart';
import 'package:nasa_clean_architecture/features/data/models/space_media_model.dart';
import 'package:nasa_clean_architecture/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDataSource extends Mock implements ISpaceMediaDataSource {}

void main() {
  late SpaceMediaRepository repository;
  late ISpaceMediaDataSource datasource;

  setUp(() {
    datasource = MockSpaceMediaDataSource();
    repository = SpaceMediaRepository(datasource: datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description:
        "What celestial body wears the Necklace Nebula? First, analyses indicate that the Necklace is a planetary nebula, a gas cloud emitted by a star toward the end of its life. Also, what appears to be diamonds in the Necklace are actually bright knots of glowing gas.  In the center of the Necklace Nebula are likely two stars orbiting so close together that they share a common atmosphere and appear as one in the featured image by the Hubble Space Telescope.  The red-glowing gas clouds on the upper left and lower right are the results of jets from the center.  Exactly when and how the bright jets formed remains a topic of research.  The Necklace Nebula is only about 5,000 years old, spans about 5 light years, and can best be found with a large telescope toward the direction of the constellation of the Arrow (Sagitta).",
    mediaType: "image",
    title: "Jets from the Necklace Nebula",
    mediaUrl: "https://apod.nasa.gov/apod/image/2105/Necklace_Hubble_960.jpg",
  );

  final tDate = DateTime(2021, 05, 20);

  test(
      'should return space media model (SpaceMediaModel) when calls the datasource ',
      () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);

    final result = await repository.getSpaceMediaFromDate(date: tDate);

    expect(result, Right(tSpaceMediaModel));
    
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'should return server failure (exception) when calls the datasource is unsucessfull',
      () async {
    //Arrange o que o mock tem que reponder
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => throw ServerException());

    final result = await repository.getSpaceMediaFromDate(date: tDate);

    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}

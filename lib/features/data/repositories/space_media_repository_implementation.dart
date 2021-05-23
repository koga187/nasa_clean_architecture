import 'package:nasa_clean_architecture/core/errors/exceptions.dart';
import 'package:nasa_clean_architecture/features/data/datasource/space_media_data_source.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture/features/domain/repositories/space_media_repository.dart';

class SpaceMediaRepository implements ISpaceMediaRepository {
  final ISpaceMediaDataSource datasource;

  SpaceMediaRepository({required this.datasource});

  @override
  Future<Either<Failures, SpaceMediaEntity>> getSpaceMediaFromDate(
        {required DateTime date}
      ) async {
        try {
          final result = await datasource.getSpaceMediaFromDate(date);

          return Right(result);
        } on ServerException {
          return Left(ServerFailure());
        }
  }
}

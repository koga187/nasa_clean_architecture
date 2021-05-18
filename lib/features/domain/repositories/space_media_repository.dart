import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failures, SpaceMediaEntity>> getSpaceMediaFromDate({DateTime dateTime});
}

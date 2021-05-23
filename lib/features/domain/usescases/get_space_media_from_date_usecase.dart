import 'package:nasa_clean_architecture/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture/core/usecase/use_case.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUseCase implements UseCase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failures, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaFromDate(date: date);
  }
}

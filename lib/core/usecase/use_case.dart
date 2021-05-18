import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nasa_clean_architecture/core/usecase/errors/failures.dart';

abstract class UseCase<Output, Input> {
  Future<Either<Failures, Output>> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

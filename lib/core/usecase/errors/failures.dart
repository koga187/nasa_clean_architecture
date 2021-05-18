import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {}

class ServerFailure extends Failures {
  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {}

class ServerFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class NullParamFailure extends Failures {
  @override
  // TODO: implement props
  List<Object?> get props => [];

  @override
  // TODO: implement stringify
  bool? get stringify => false;
}

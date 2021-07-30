import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_clean_architecture/core/errors/failures.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture/features/domain/usescases/get_space_media_from_date_usecase.dart';

class HomeStore extends NotifierStore<Failures, SpaceMediaEntity> {
  HomeStore({
    required this.getSpaceMediaFromDateUseCase,
  }) : super(SpaceMediaEntity(
          description: '',
          mediaType: '',
          title: '',
          mediaUrl: null,
        ));

  final GetSpaceMediaFromDateUseCase getSpaceMediaFromDateUseCase;

  Future<void> getSpaceMediaFromDate(DateTime date) async {
    // executeEither(() => getSpaceMediaFromDateUseCase(date));
    setLoading(true);
    final result = await getSpaceMediaFromDateUseCase(date);
    result.fold(
      (error) => setError(error),
      (success) => update(success),
    );
  }
}

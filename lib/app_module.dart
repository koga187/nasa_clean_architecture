// app_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_clean_architecture/core/utils/conversor.dart/date_to_string_converter.dart';
import 'package:nasa_clean_architecture/features/data/datasource/nasa_space_media_datasource_implementation.dart';
import 'package:nasa_clean_architecture/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_clean_architecture/features/domain/usescases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_architecture/features/presenter/controller/home_store.dart';
import 'package:nasa_clean_architecture/features/presenter/pages/home_page.dart';
import 'package:nasa_clean_architecture/features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [
        Bind((i) => HomeStore(getSpaceMediaFromDateUseCase: i())),
        Bind((i) => GetSpaceMediaFromDateUseCase(repository: i())),
        Bind((i) => SpaceMediaRepository(datasource: i())),
        Bind((i) => NasaSpaceMediaDataSourceImplementation(i())),
        Bind((i) => http.Client()),
        Bind((i) => DateToStringConverter()),
      ];

  // Provide all the routes for your module
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => HomePage()),
        ChildRoute('/picture', child: (_, __) => PicturePage()),
      ];
}

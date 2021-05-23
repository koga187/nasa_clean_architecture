import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture/core/utils/keys/nasa_api_key.dart';
import 'package:nasa_clean_architecture/features/data/datasource/space_media_data_source.dart';
import 'package:nasa_clean_architecture/features/data/datasource/nasa_space_media_datasource_implementation.dart';

import '../../../mocks/data/models/space_media_mock.dart';

class ClientMocking extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDataSource dataSource;
  late HttpClient client;

  setUp(() {
    client = ClientMocking();
    dataSource = NasaSpaceMediaDataSourceImplementation(client);
  });

  final tDateTime = DateTime(2021, 02, 02);
  final urlExpected =
      'https://api.nasa.gov/planetary/apod?api_key=${NasaApiKeys.apiKey}?date=${tDateTime.year}-${tDateTime.month}-${tDateTime.day}';

  test('should call the get method with correct url', () async {
    when(() => client.get(any())).thenAnswer(
      (invocation) async => HttpResponse(
        data: tSpaceMediaMock,
        statusCode: 200,
      ),
    );

    await dataSource.getSpaceMediaFromDate(
      tDateTime,
    );

    verify(() => client.get(any())).called(1);
  });
}

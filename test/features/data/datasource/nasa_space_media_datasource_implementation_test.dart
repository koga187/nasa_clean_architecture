import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture/core/errors/exceptions.dart';
import 'package:nasa_clean_architecture/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture/core/utils/keys/nasa_api_key.dart';
import 'package:nasa_clean_architecture/features/data/datasource/space_media_data_source.dart';
import 'package:nasa_clean_architecture/features/data/datasource/nasa_space_media_datasource_implementation.dart';
import 'package:nasa_clean_architecture/features/data/models/space_media_model.dart';

import '../../../mocks/data/models/space_media_mock.dart';

class ClientMocking extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDataSource dataSource;
  late HttpClient client;

  setUp(() {
    client = ClientMocking();
    dataSource = NasaSpaceMediaDataSourceImplementation(client);
  });

  void _successHttpClientMock() {
    when(() => client.get(any())).thenAnswer(
      (invocation) async => HttpResponse(
        data: tSpaceMediaMock,
        statusCode: 200,
      ),
    );
  }

  final tDateTime = DateTime(2021, 02, 02);

  final tSpaceMediaMapMock = jsonDecode(tSpaceMediaMock);

  final tSpaceMediaModelMock =
      SpaceMediaModel.fromJson(tSpaceMediaMapMock);

  test('should call the get method with correct url', () async {
    _successHttpClientMock();

    final urlExpected =
        'https://api.nasa.gov/planetary/apod?api_key=${NasaApiKeys.apiKey}?date=${tDateTime.year}-0${tDateTime.month}-0${tDateTime.day}';

    await dataSource.getSpaceMediaFromDate(
      tDateTime,
    );

    verify(() => client.get(any())).called(1);
  });

  test('should return a SpaceMediaModel when is successful', () async {
    _successHttpClientMock();

    final response = await dataSource.getSpaceMediaFromDate(
      tDateTime,
    );

    expect(response, tSpaceMediaModelMock);
  });

  test('should return a SpaceMediaModel when is successful', () async {
    _successHttpClientMock();

    final response = await dataSource.getSpaceMediaFromDate(
      tDateTime,
    );

    expect(response, tSpaceMediaModelMock);
  });

  test('should throw a ServerException when call is unccessful', () async {
    when(() => client.get(any())).thenAnswer((invocation) async => HttpResponse(data: 'something went wrong', statusCode: 500));

    final result = dataSource.getSpaceMediaFromDate(tDateTime);

    expect(result, throw ServerException());
  });
}

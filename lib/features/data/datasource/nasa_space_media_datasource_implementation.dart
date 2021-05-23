import 'dart:convert';

import 'package:nasa_clean_architecture/core/errors/exceptions.dart';
import 'package:nasa_clean_architecture/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture/core/utils/conversor.dart/date_to_string_converter.dart';
import 'package:nasa_clean_architecture/core/utils/keys/nasa_api_key.dart';
import 'package:nasa_clean_architecture/features/data/datasource/endpoints/nada_endpoint.dart';
import 'package:nasa_clean_architecture/features/data/datasource/space_media_data_source.dart';
import 'package:nasa_clean_architecture/features/data/models/space_media_model.dart';

class NasaSpaceMediaDataSourceImplementation implements ISpaceMediaDataSource {
  final HttpClient client;

  NasaSpaceMediaDataSourceImplementation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(
      NasaApiKeys.apiKey,
      DateToStringConverter().convert(date),
    ));

    if (response.statusCode == 200) {
      print('json decode - ${jsonDecode(response.data)}');
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    }

    throw ServerException();
  }
}

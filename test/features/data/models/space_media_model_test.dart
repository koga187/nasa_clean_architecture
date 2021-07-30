import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_architecture/features/data/models/space_media_model.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
    description:
        "Near the heart of the Virgo Galaxy Cluster the string of galaxies known as Markarian's Chain stretches across this deep telescopic field of view. Anchored in the frame at bottom center by prominent lenticular galaxies, M84 (bottom) and M86, you can follow the chain up and to the right. Near center you'll spot the pair of interacting galaxies NGC 4438 and NGC 4435, known to some as Markarian's Eyes. Its center an estimated 50 million light-years distant, the Virgo Cluster itself is the nearest galaxy cluster. With up to about 2,000 member galaxies, it has a noticeable gravitational influence on our own Local Group of Galaxies. Within the Virgo Cluster at least seven galaxies in Markarian's Chain  appear to move coherently, although others may appear to be part of the chain by chance.",
    mediaType: "image",
    title: "Markarian's Chain",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2105/MarkariansChainAnvik1024.jpg",
  );

  test('should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('should return a valid model (SpaceMediaModel)', () async {
    final Map<String, dynamic> jsonMap = json.decode(tSpaceMediaMock);

    final result = SpaceMediaModel.fromJson(jsonMap);
    // print(result);
    expect(result, tSpaceMediaModel);
  });
}

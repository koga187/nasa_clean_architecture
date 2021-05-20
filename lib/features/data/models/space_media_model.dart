import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';

class SpaceMediaModel extends SpaceMediaEntity {
  late String explanation;

  SpaceMediaModel({
    required String explanation,
    required String mediaType,
    required String title,
    required String mediaUrl,
  }) : super(
          description: explanation,
          mediaType: mediaType,
          title: title,
          mediaUrl: mediaUrl,
        );

  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) =>
      SpaceMediaModel(
        explanation: json['explanation'],
        mediaType: json['mediaType'],
        title: json['title'],
        mediaUrl: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'explanation': explanation,
        'mediaType': mediaType,
        'title': title,
        'url': mediaType
      };
}

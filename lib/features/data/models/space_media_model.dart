import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';

class SpaceMediaModel extends SpaceMediaEntity {
  final String explanation;

  SpaceMediaModel({
    required String description,
    required String mediaType,
    required String title,
    required String mediaUrl,
  }) : explanation = description, super(
      description: description,
      mediaType: mediaType,
      title: title,
      mediaUrl: mediaUrl,
    );
  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) =>
      SpaceMediaModel(
        description: json['explanation'],
        mediaType: json['media_type'],
        title: json['title'],
        mediaUrl: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'explanation': explanation,
        'media_type': mediaType,
        'title': title,
        'url': mediaUrl
      };
}

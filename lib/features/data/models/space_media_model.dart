import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';

class SpaceMediaModel extends SpaceMediaEntity {
  late String explanation;

  SpaceMediaModel({
    required String description,
    required String mediaType,
    required String title,
    required String mediaUrl,
  }) : super(
      description: description,
      mediaType: mediaType,
      title: title,
      mediaUrl: mediaUrl,
    )
  {
    explanation = description;
  }
  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) =>
      SpaceMediaModel(
        description: json['explanation'],
        mediaType: json['media_type'],
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

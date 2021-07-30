import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture/features/presenter/controller/home_store.dart';
import 'package:nasa_clean_architecture/features/presenter/widgets/custom_shimmer.dart';
import 'package:nasa_clean_architecture/features/presenter/widgets/description_bottom_sheet.dart';
import 'package:nasa_clean_architecture/features/presenter/widgets/image_network_with_loader.dart';

class PicturePage extends StatefulWidget {
  const PicturePage({Key? key}) : super(key: key);

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends ModularState<PicturePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return ScopedBuilder(
        store: store,
        onLoading: (context) => Center(
              child: CircularProgressIndicator(),
            ),
        onError: (context, error) => Center(
              child: Text(
                'Um erro ocorreu tente novamente mais tarde.',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
        onState: (context, SpaceMediaEntity spaceMedia) => GestureDetector(
              onVerticalDragUpdate: (update) {
                if (update.delta.dy < 0) {
                  showDescriptionBottomSheet(
                    context: context,
                    title: spaceMedia.title,
                    description: spaceMedia.description,
                  );
                }
              },
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: spaceMedia.mediaType == 'video'
                        ? Center(
                            child: Text('Não consigo reproduzir videos'),
                          )
                        : spaceMedia.mediaUrl != null
                            ? ImageNetworkWithLoader(url: spaceMedia.mediaUrl!)
                            : Container(),
                  ),
                  Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: Colors.black26.withOpacity(0.2),
                      child: CustomShimmer(
                        child: Column(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_up,
                              size: 35,
                            ),
                            Text(
                              'Deslise para cima para ver a descrição',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}

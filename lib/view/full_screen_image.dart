import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart' hide CarouselController ;
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatefulWidget {
  const FullScreenImage({Key? key}) : super(key: key);

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  List carImageList = [];

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null) {
      carImageList = setting.arguments as List;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cardBlackColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FlutterCarousel(
        items: carImageList
            .map(
              (item) => PhotoView(
                imageProvider:
                    NetworkImage(Config.imageUrl! + item['image'].substring(1)),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                initialScale: PhotoViewComputedScale.contained,
                backgroundDecoration: BoxDecoration(
                  color: cardBlackColor,
                ),
                loadingBuilder: (BuildContext context, ImageChunkEvent? chunk) {
                  return chunk == null
                      ? Center(
                          child: CircularProgressIndicator(color: colorEmber),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            value: chunk.expectedTotalBytes != null
                                ? chunk.cumulativeBytesLoaded /
                                    chunk.expectedTotalBytes!
                                : null,
                          ),
                        );
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                },
                enableRotation: true,
                controller: PhotoViewController(),
                scaleStateChangedCallback: (PhotoViewScaleState scaleState) {
                  // Ваш код
                },
              ),
            )
            .toList(),
        options: CarouselOptions(
          showIndicator: false,
          autoPlay: false,
          // controller: buttonCarouselController,
          enlargeCenterPage: true,
          viewportFraction: 1,
          aspectRatio: 1,
          initialPage: 0,
          height: MediaQuery.of(context).size.height / 1.1,
        ),
      ),
    );
  }
}

// import 'package:avto_baraka/screen/imports/imports_announcement.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/box_decoration.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevate_btn_cam_gall.dart';
import 'package:avto_baraka/view/camera.dart';
import 'package:avto_baraka/widgets/announcement/form_step_title.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key, required this.onImageFile}) : super(key: key);

  final ValueChanged<List<XFile>> onImageFile;

  @override
  Step8ImageState createState() => Step8ImageState();
}

class Step8ImageState extends State<AddImage> {
  final ImagePicker imagePicker = ImagePicker();
  late List<XFile> imageFileList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        formStepsTitle(S.of(context).rasmlarniYuklang, context),
        const SizedBox(
          height: 23.0,
        ),
        GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: (itemWidth / itemHeight),
            childAspectRatio: 3,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 0,
            // mainAxisExtent: ,
          ),
          children: [
            ElevatedButton(
              style: elevatedBtnCamGall(backgrounColor: elevatedButtonColor),
              onPressed: () => selectImages(),
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.file_upload,
                          size: 14.0,
                          color: elevatedButtonTextColor,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: S.of(context).gallereyadanTanlash,
                      style: TextStyle(color: elevatedButtonTextColor),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: elevatedBtnCamGall(
                backgrounColor: colorEmber,
              ),
              onPressed: () {
                dataCamera();
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(FontAwesomeIcons.camera, size: 14.0),
                      ),
                    ),
                    TextSpan(
                      text: S.of(context).rasimgaOlish,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 17.0,
        ),
        GridView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: (itemWidth / itemHeight),
            childAspectRatio: 1.0,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            // mainAxisExtent: ,
          ),
          children: imageFileList
              .map((img) => Container(
                    decoration: boxDecoration(),
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            child: Image.file(
                              File(img.path),
                              fit: BoxFit.cover,
                              // height: 157.0,
                              width: MediaQuery.of(context).size.width,
                            )),
                        Positioned(
                          top: 3.0,
                          right: 5.0,
                          child: CircleAvatar(
                            backgroundColor: colorRed,
                            radius: 15.0,
                            child: IconButton(
                              onPressed: () => onDeleteImage(img.path),
                              icon: const Icon(
                                Icons.clear,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }

  // ::::::::::::::::::::::GALLERY IMAGE PICKER:::::::::::::::::::::
  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    widget.onImageFile(imageFileList);
    setState(() {});
  }

  // ::::::::::::::::::::::PICK IMAGE CAMERA::::::::::::::::::::::::
  void dataCamera() async {
    final camera = await availableCameras().then((value) {
      return value;
    });
    Route route = MaterialPageRoute(
      builder: (_) => CameraPage(cameras: camera),
    );
    final result = await Navigator.push(context, route);

    setState(() {
      if (result != null) {
        imageFileList.add(result);
      }
      widget.onImageFile(imageFileList);
    });

    // ImagetoBase64();
  }

  //::::::::::::::::::::::::УДАЛЕНИЕ ИЗОБРАЖЕНИЯ ::::::::::::::::::::
  onDeleteImage(String path) {
    List<XFile> img = imageFileList.where((el) => el.path != path).toList();
    setState(() {
      imageFileList = img;
    });
    widget.onImageFile(imageFileList);
  }
}

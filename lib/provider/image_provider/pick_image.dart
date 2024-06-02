// ignore_for_file: use_build_context_synchronously

import 'package:avto_baraka/screen/imports/imports_announcement.dart';

class PickImage {
  PickImage({required this.context});

  final BuildContext context;

  List<XFile> imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();
  // ::::::::::::::::::::::GALLERY IMAGE PICKER::::::::::::::::::::::::
  Future<List<XFile>> gallery() async {
    imageFileList = await imagePicker.pickMultiImage();
    if (imageFileList.isNotEmpty) {
      return imageFileList;
    }
    return [];
  }

  // ::::::::::::::::::::::PICK IMAGE CAMERA::::::::::::::::::::::::
  Future<List<XFile>> camera() async {
    imageFileList.clear();
    final camera = await availableCameras().then((value) {
      return value;
    });
    Route route = MaterialPageRoute(
      builder: (_) => CameraPage(cameras: camera),
    );
    final result = await Navigator.push(context, route);
    if (result != null) {
      imageFileList.add(result);
    }
    return imageFileList;
  }
}

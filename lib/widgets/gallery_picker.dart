import 'dart:io';
import 'package:flutter/cupertino.dart';

Column viewImage(imageFileList) {
  return Column(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: imageFileList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return Image.file(
                  File(imageFileList![index].path),
                  fit: BoxFit.cover,
                );
              }),
        ),
      ),
    ],
  );
}

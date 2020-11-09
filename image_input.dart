import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspath;

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function saveImg;
  ImageInput(this.saveImg);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePic() async {
    final picker = ImagePicker();
    final takedImg =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (takedImg == null) return;
    setState(() {
      _storedImage = File(takedImg.path);
    });

    final appDirectory = await syspath.getApplicationDocumentsDirectory();
    final imgName = path.basename(takedImg.path);
    final savedImg = await _storedImage.copy("${appDirectory.path}/$imgName");
    widget.saveImg(savedImg);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
          child: _storedImage == null
              ? Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePic,
            icon: Icon(Icons.camera),
            label: Text(
              "Take picture",
            ),
            textColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}

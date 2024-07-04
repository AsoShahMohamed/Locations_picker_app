import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;
import '../helpers/sql_functions.dart';

class ImagePreview extends StatefulWidget {
  final Function _setImage;
  ImagePreview(this._setImage);
  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  File? imageFile;

  Future<void> _takeImage() async {
    final XFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 600);
    if (XFile == null) {
      return;
    }
    setState(() {
      imageFile = File(XFile.path);
    });
    final Directory appDir = await sysPath.getApplicationDocumentsDirectory();

    final imageName = path.basename(XFile.path);

    final copiedImage = await imageFile!.copy('${appDir.path}/${imageName}');

    widget._setImage(copiedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            alignment: Alignment.center,
            width: 150,
            height: 100,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: imageFile != null
                ? Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  )
                : Text('image preview')),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.white.withOpacity(0),
            elevation: 0,
          ),
          icon: Icon(Icons.camera),
          onPressed: _takeImage,
          label: Text('Take Image'),
        ),
      ],
    );
  }
}

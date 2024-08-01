import 'dart:io';
import 'package:eventique_company_app/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImagePicker extends StatefulWidget {
  final void Function(List<File>) onImagesPicked;

  MultiImagePicker({required this.onImagesPicked});

  @override
  _MultiImagePickerState createState() => _MultiImagePickerState();
}

class _MultiImagePickerState extends State<MultiImagePicker> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles == null) {
      return;
    }
    setState(() {
      if (_selectedImages.length + pickedFiles.length <= 5) {
        _selectedImages.addAll(
          pickedFiles.map((pickedFile) => File(pickedFile.path)).toList(),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You can select a maximum of 5 images')),
        );
      }
    });
    widget.onImagesPicked(_selectedImages);
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    widget.onImagesPicked(_selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.42,
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
            border: Border.all(color: secondary, width: 2),
          ),
          child: Center(
            child: _selectedImages.isEmpty
                ? TextButton(
                    onPressed: _pickImages,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 30,
                          color: secondary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Pick Images',
                          style: TextStyle(
                            fontFamily: 'IrishGrover',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: _selectedImages.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (ctx, index) {
                            return GridTile(
                              child: Image.file(
                                _selectedImages[index],
                                fit: BoxFit.cover,
                              ),
                              header: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () => _removeImage(index),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      if (_selectedImages.length < 5)
                        TextButton(
                          onPressed: _pickImages,
                          child: Text(
                            'Pick More Images',
                            style: TextStyle(
                              fontFamily: 'IrishGrover',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: secondary,
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

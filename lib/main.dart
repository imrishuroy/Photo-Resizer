import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _imageFile;
  File? _image;

  _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Resizer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if (_image != null)
          //   Center(
          //     child: Container(
          //       height: 250.0,

          //       child: Image.file(_image!),
          //     ),
          //   ),
          Center(
            child: InkWell(
              onTap: () {
                _getImage();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                height: 250.0,
                width: 250.0,

                /// child: Center(
                //   child: Icon(
                //     Icons.image,
                //     color: Colors.green,
                //   ),
                // )),
                child: _image == null
                    ? Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.green,
                        ),
                      )
                    : Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () {},
            child: Text('Resize Image'),
          ),
          // Image.file(File(_imageFile!.path))
        ],
      ),
    );
  }
}

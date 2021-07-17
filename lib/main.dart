import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
  File? _image;

  final CollectionReference _photosRef =
      FirebaseFirestore.instance.collection('photos');

  _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _upload() async {
    await _photosRef.add({'data': 'Image Added'});
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
                  borderRadius: BorderRadius.circular(10),
                ),
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
            onPressed: () {
              _upload();
            },
            child: Text('Resize Image'),
          ),
          // Image.file(File(_imageFile!.path))
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  AddPicture({
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  _AddPictureState createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;

  Future<void> selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = Uint8List.fromList(bytes);
      });
    }
  }

  Future<void> selectImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = Uint8List.fromList(bytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 28),
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50,
              ),
            ),
            Image.network('../../assets/images/logo.webp', width: 80, height: 60),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${widget.username} Welcome to\nHolbegram.',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const Text(
                        'Choose an image from your gallery or take a new one.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ]
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: _image != null
                      ? CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(_image!),
                      )
                      : CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: Image.network('../../assets/images/user_icon.png'),
                      )
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.photo_library_outlined, size: 40,),
                        onPressed: selectImageFromCamera,
                        color: const Color.fromARGB(218, 226, 37, 24),
                      ),
                      IconButton(
                        icon: const Icon(Icons.camera_alt_outlined, size: 40,),
                        onPressed: selectImageFromGallery,
                        color: const Color.fromARGB(218, 226, 37, 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color.fromARGB(218, 226, 37, 24)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder( borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            User? currentUser = FirebaseAuth.instance.currentUser;
                            String? imageBase64 = _image != null ? base64Encode(_image!) : '';
                            
                            if (currentUser != null) {
                              await FirebaseFirestore.instance
                                .collection('users')
                                .doc(currentUser.uid)
                                .update({'photoUrl': imageBase64});
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("User image updated"),
                                  backgroundColor: Color.fromARGB(218, 25, 189, 66)
                                ),
                              );
                            }
                          } catch (e) {
                            print('Error updating profile image: $e');
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

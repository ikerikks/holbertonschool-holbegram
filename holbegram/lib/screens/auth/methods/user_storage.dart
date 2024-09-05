import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
    bool isPost,
    String childName,
    Uint8List file,

  ) async {
    Reference ref =_storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

// import 'package:flutter/material.dart';
// import 'package:utils/post_storage.dart';

// class MyWidget extends StatelessWidget {
//   final String postId;
//   final PostStorage postStorage = PostStorage(FirebaseFirestore.instance);

//   MyWidget({Key? key, required this.postId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.delete),
//       onPressed: () async {
//         // Call deletePost method before showing snackbar
//         await postStorage.deletePost(postId);
        
//         // Show snackbar after post deletion
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Post Deleted')),
//         );
//       },
//     );
//   }
// }

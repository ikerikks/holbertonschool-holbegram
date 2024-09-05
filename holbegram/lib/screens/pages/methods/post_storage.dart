import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
// import '../../auth/methods/upload_image_screen.dart';
// import '../../auth/methods/user_storage.dart';
import 'package:holbegram/utils/posts.dart';

class PostStorage {
  final FirebaseFirestore _firestore;

  PostStorage(this._firestore);

  Future<String> uploadPost(
      String caption, String uid, String username, String profImage, Uint8List image) async {
    try {
      // Upload image to storage
      String imageUrl = await uploadImageToStorage(image);

      // Save post data to Firestore
      await _firestore.collection('posts').add({
        'caption': caption,
        'uid': uid,
        'username': username,
        'profImage': profImage,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      return "Ok";
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      // Delete post from Firestore
      await _firestore.collection('posts').doc(postId).delete();
    } catch (error) {
      print("Error deleting post: $error");
    }
  }
  
}

import 'package:flutter/material.dart';
import 'package:holbegram/models/user.dart';
import 'package:holbegram/methods/auth_methods.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final AuthMethode _authMethod = AuthMethode();

  Users? get user => _user;

  Future<void> refreshUser() async {
    try {
      Users userDetails = await _authMethod.getUserDetails();
      _user = userDetails;
      notifyListeners();
    } catch (e) {
      throw("Error refreshing user: $e");
    }
  }
}

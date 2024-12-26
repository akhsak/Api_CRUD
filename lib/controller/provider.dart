import 'package:flutter/material.dart';
import 'package:machine_test/service/service.dart';
import 'package:machine_test/model/model.dart';

class UserProvider with ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GetService _service = GetService();
  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  // Fetch all users
  Future<void> fetchUsers() async {
    try {
      _users = await _service.getdata();
      notifyListeners();
    } catch (e) {
      print('Error fetching users: $e');
    }
  }
}

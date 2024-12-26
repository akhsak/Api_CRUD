import 'package:dio/dio.dart';
import 'package:machine_test/model/model.dart';

class GetService {
  final Dio dio = Dio();

  // Fetch all users (GET)
  Future<List<UserModel>> getdata() async {
    try {
      final response = await dio.get(
          'https://ceikerala.niveosys.org/api-project/public/api/fetch-all-users');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  // Add a new user (POST)
  Future<void> addUser(UserModel user) async {
    try {
      final response = await dio.post(
        'https://ceikerala.niveosys.org/api-project/public/api/create-user',
        data: {
          'name': user.name,
          'phone': user.phone,
          'email': user.email,
          'address': user.address,
          'gender': user.gender,
          'description': user.description,
        },
      );

      if (response.statusCode == 200) {
        print('User added successfully');
      } else {
        throw Exception(
            'Failed to add user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding user: $e');
      if (e is DioError && e.response?.statusCode == 404) {
        print('Error: Endpoint not found. Please verify the URL.');
      }
      throw Exception('Error adding user: $e');
    }
  }

  // Delete a user (DELETE)
  Future<void> deleteUser(int userId) async {
    try {
      final response = await dio.post(
        'https://ceikerala.niveosys.org/api-project/public/api/delete-user/$userId',
      );

      if (response.statusCode == 200) {
        print('User deleted successfully');
      } else if (response.statusCode == 405) {
        print(
            'Error: Method Not Allowed (405). The server does not support DELETE for this endpoint.');
        throw Exception('Failed to delete user. Method Not Allowed (405)');
      } else {
        print('Error: Unexpected status code: ${response.statusCode}');
        throw Exception(
            'Failed to delete user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting user: $e');
      throw Exception('Error deleting user: $e');
    }
  }

  // Update a user (PUT)
  Future<void> updateUser(UserModel user) async {
    try {
      final response = await dio.post(
        'https://ceikerala.niveosys.org/api-project/public/api/update-user/${user.id}',
        data: {
          'name': user.name,
          'phone': user.phone,
          'email': user.email,
          'address': user.address,
          'gender': user.gender,
          'description': user.description,
        },
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
      } else {
        throw Exception(
            'Failed to update user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating user: $e');
      throw Exception('Error updating user: $e');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:machine_test/controller/provider.dart';
import 'package:machine_test/model/model.dart';
import 'package:machine_test/service/service.dart';
import 'package:machine_test/view/text.dart';
import 'package:provider/provider.dart';
import 'package:machine_test/view/welcome_screen.dart'; // import WelcomeScreen

class AddUserScreen extends StatelessWidget {
  final GetService _service = GetService();

  AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final createprovider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: textAbel(name: "Add User", color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 8, 82),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter User Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              // Full Name
              TextFormField(
                controller: createprovider.userNameController,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Phone
              TextFormField(
                controller: createprovider.phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Email
              TextFormField(
                controller: createprovider.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Address
              TextFormField(
                controller: createprovider.addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Gender
              TextFormField(
                controller: createprovider.genderController,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Description
              TextFormField(
                controller: createprovider.descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Add User Button
              Center(
                child: SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () async {
                      final newUser = UserModel(
                        name: createprovider.userNameController.text,
                        phone: createprovider.phoneController.text,
                        email: createprovider.emailController.text,
                        address: createprovider.addressController.text,
                        gender: createprovider.genderController.text,
                        description: createprovider.descriptionController.text,
                      );

                      try {
                        await _service.addUser(newUser);

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User added successfully!'),
                          ),
                        );

                        // Navigate to WelcomeScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.toString()}'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 47, 8, 95),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Add User',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

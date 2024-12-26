// import 'package:flutter/material.dart';
// import 'package:machine_test/controller/provider.dart';
// import 'package:machine_test/model/model.dart';
// import 'package:machine_test/service/service.dart';
// import 'package:machine_test/view/text.dart';
// import 'package:provider/provider.dart';
// import 'package:machine_test/view/welcome_screen.dart'; // import WelcomeScreen

// class Detail extends StatelessWidget {
//   final GetService _service = GetService();
//   final UserModel model;

//   Detail({super.key, required this.model});

//   @override
//   Widget build(BuildContext context) {
//     final createprovider = Provider.of<UserProvider>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         title: textAbel(name: "Add User", color: Colors.white),
//         backgroundColor: const Color.fromARGB(255, 21, 8, 82),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Enter User Details',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Full Name
//               TextFormField(
//                 controller: createprovider.userNameController,
//                 decoration: InputDecoration(
//                   labelText: ('${model.name}'),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Phone
//               TextFormField(
//                 controller: createprovider.phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: ('${model.phone}'),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Email
//               TextFormField(
//                 controller: createprovider.emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.email),
//                   labelText: ('${model.email}'),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Address
//               TextFormField(
//                 controller: createprovider.addressController,
//                 decoration: InputDecoration(
//                   labelText: ('${model.address}'),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Gender
//               TextFormField(
//                 controller: createprovider.genderController,
//                 decoration: InputDecoration(
//                   labelText: ('${model.gender}'),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Description
//               TextFormField(
//                 controller: createprovider.descriptionController,
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   labelText: ('${model.description}'),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Add User Button
//               Center(
//                 child: SizedBox(
//                   width: 350,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final newUser = UserModel(
//                         name: createprovider.userNameController.text,
//                         phone: createprovider.phoneController.text,
//                         email: createprovider.emailController.text,
//                         address: createprovider.addressController.text,
//                         gender: createprovider.genderController.text,
//                         description: createprovider.descriptionController.text,
//                       );

//                       try {
//                         await _service.addUser(newUser);

//                         // Show success message
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('User added successfully!'),
//                           ),
//                         );

//                         // Navigate to WelcomeScreen
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const WelcomeScreen(),
//                           ),
//                         );
//                       } catch (e) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Error: ${e.toString()}'),
//                           ),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 47, 8, 95),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 40, vertical: 20),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                     ),
//                     child: const Text(
//                       'Add User',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:machine_test/controller/provider.dart';
import 'package:machine_test/model/model.dart';
import 'package:machine_test/service/service.dart';
import 'package:machine_test/view/text.dart';
import 'package:provider/provider.dart';
import 'package:machine_test/view/welcome_screen.dart'; // import WelcomeScreen

class Detail extends StatefulWidget {
  final GetService _service = GetService();
  final UserModel model;

  Detail({super.key, required this.model});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Pre-fill form fields with existing data
    userProvider.userNameController.text = widget.model.name ?? '';
    userProvider.phoneController.text = widget.model.phone ?? '';
    userProvider.emailController.text = widget.model.email ?? '';
    userProvider.addressController.text = widget.model.address ?? '';
    userProvider.genderController.text = widget.model.gender ?? '';
    userProvider.descriptionController.text = widget.model.description ?? '';

    return Scaffold(
      appBar: AppBar(
        title: textAbel(name: "Update User", color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 8, 82),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Update User Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                // Full Name
                TextFormField(
                  controller: userProvider.userNameController,
                  decoration: InputDecoration(
                    labelText: ('Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Phone
                TextFormField(
                  controller: userProvider.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: ('Phone'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Email
                TextFormField(
                  controller: userProvider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: ('Email'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Address
                TextFormField(
                  controller: userProvider.addressController,
                  decoration: InputDecoration(
                    labelText: ('Address'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Gender
                TextFormField(
                  controller: userProvider.genderController,
                  decoration: InputDecoration(
                    labelText: ('Gender'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Description
                TextFormField(
                  controller: userProvider.descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: ('Description'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Update User Button
                Center(
                  child: SizedBox(
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final updatedUser = UserModel(
                            id: widget
                                .model.id, // Ensure ID is included for update
                            name: userProvider.userNameController.text,
                            phone: userProvider.phoneController.text,
                            email: userProvider.emailController.text,
                            address: userProvider.addressController.text,
                            gender: userProvider.genderController.text,
                            description:
                                userProvider.descriptionController.text,
                          );

                          try {
                            await widget._service.updateUser(updatedUser);

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('User updated successfully!'),
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
                        'Update User',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ... rest of the code (GetService class, etc.)
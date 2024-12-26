import 'package:flutter/material.dart';
import 'package:machine_test/model/model.dart';
import 'package:machine_test/service/service.dart';
import 'package:machine_test/view/add_screen.dart';
import 'package:machine_test/view/detail.dart';
import 'package:machine_test/view/text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GetService _service = GetService();
  late Future<List<UserModel>> _usersFuture;
  bool _showLatestFirst = true;

  @override
  void initState() {
    super.initState();
    _usersFuture = _service.getdata();
  }

  // Refresh users list
  void refreshUsers() {
    setState(() {
      _usersFuture = _service.getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textAbel(name: "welcome", color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 33, 9, 90),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUserScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: textAbel(name: "Add User", color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 32, 15, 103),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: _usersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No users found"));
                } else {
                  final users = snapshot.data!;
                  final displayedUsers =
                      _showLatestFirst ? users.reversed.toList() : users;
                  return ListView.builder(
                    itemCount: displayedUsers.length,
                    itemBuilder: (context, index) {
                      final user = displayedUsers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(user.name ?? 'No Name'),
                          subtitle: Text(user.email ?? 'No Email'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detail(
                                              model: user,
                                            )),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Are you sure?'),
                                        content: const Text(
                                            'Do you really want to delete this user?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // Ensure user.id is not null
                                              if (user.id != null) {
                                                print(
                                                    'Attempting to delete user with ID: ${user.id}');

                                                try {
                                                  // Call delete function
                                                  await _service
                                                      .deleteUser(user.id!);
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                  refreshUsers(); // Refresh the list of users
                                                } catch (e) {
                                                  print(
                                                      'Error deleting user: $e');
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                }
                                              } else {
                                                print(
                                                    'User ID is null or invalid');
                                              }
                                            },
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

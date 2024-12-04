import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_eccomerce/models/UserModel.dart';
import 'package:simple_eccomerce/screens/home_screen.dart';
import 'package:simple_eccomerce/services/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initState() {
    super.initState();
    // Fetch the products when the screen is initialized
    Provider.of<UserProvider>(context, listen: false).getUsersProvider();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  void goToHome(UserModel userData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          user: userData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Get the entered email and password
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                // Call the provider's verify function
                UserModel? userData =
                    Provider.of<UserProvider>(context, listen: false)
                        .verifyEmailPassword(email, password);

                if (userData == null) {
                  // Navigate to HomeScreen or another screen
                  setState(() {
                    errorMessage = 'Invalid email or password';
                  });
                  // Show error message
                  print('Login failed!');
                } else {
                  setState(() {
                    errorMessage = null; // Clear error if successful
                  });
                  // Proceed to next screen (e.g., HomeScreen)
                  print('Login successful!');
                  goToHome(userData);
                }
              },
              child: Text('Login'),
            ),
            if (errorMessage != null) ...[
              SizedBox(height: 10),
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
 /*  Consumer<UserProvider> GetUserList() {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        // Check if users are still loading
        if (value.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        // If there's an error, display the error message
        if (value.errorMessage != null) {
          return Center(
            child: Text(
              value.errorMessage!,
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }

        // If users data is available
        return ListView.builder(
          itemCount: value.users.length, // Length of users list
          itemBuilder: (context, index) {
            UserModel user = value.users[index]; // Get each user from the list
            print('User ID: ${user.id}');
            print('User Name: ${user.name?.firstname} ${user.name?.lastname}');
            print('User Email: ${user.email}');
            print('User Phone: ${user.phone}');
            print('---'); // Separator for clarity

            // Return the widget for displaying the user
            return ListTile(
              title: Text('${user.name?.firstname} ${user.name?.lastname}'),
              subtitle: Text(user.email ?? 'No email'),
              trailing: Text(user.phone ?? 'No phone'),
            );
          },
        );
      },
    );
  }
}
 */
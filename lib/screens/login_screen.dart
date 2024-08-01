//taghreed
import 'package:eventique_company_app/screens/navigation_bar_page.dart';

import '/color.dart';
import 'package:eventique_company_app/providers/auth_vendor.dart';
import '/screens/verification_screen.dart';
import '../widgets/login/login_form.dart';
import '/widgets/login/circular_shape.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  Future<void> _submitLoginForm(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<AuthVendor>(context, listen: false)
          .login(email, password);
      Navigator.of(ctx).popAndPushNamed(NavigationBarPage.routeName);
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('sign in completed successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print(error.toString());
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: size.height * 0.75,
              width: double.infinity,
              color: primary,
            ),
          ),
          LoginForm(_submitLoginForm, _isLoading),
        ],
      ),
    );
  }
}

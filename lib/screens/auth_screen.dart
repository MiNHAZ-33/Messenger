import 'package:chat_app/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false;

  void _submitAuthForm(String email, String username, String password,
      bool islogin, BuildContext ctx) async {
    var authResult;

    try {
      setState(() {
        isLoading = true;
      });
      if (islogin) {
        UserCredential authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        UserCredential authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({'username': username, 'email': email});
      }
    } on PlatformException catch (e) {
      var message = 'An error occured';
      if (e.message != null) {
        message = e.message.toString();
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text(message),
        ),
      );
      setState(() {
        isLoading = true;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitFn: _submitAuthForm, isLoading: isLoading),
    );
  }
}

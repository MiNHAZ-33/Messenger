import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm({Key? key, required this.submitFn, required this.isLoading})
      : super(key: key);

  var isLoading;

  final void Function(
    String email,
    String username,
    String password,
    bool islogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _userEmail = '';
  String _userName = '';
  String _password = '';
  var isLogin = true;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
          _userEmail.trim(), _userName.trim(), _password, isLogin, context);
    }
  }

  @override
  void dispose() {
    
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _emailController,
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!isLogin)
                    TextFormField(
                      controller: _userNameController,
                      key: const ValueKey('user name'),
                      decoration: const InputDecoration(
                        labelText: 'User name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Enter at least 4 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    controller: _passwordController,
                    key: const ValueKey('Pass word'),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Enter at least 8 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(isLogin ? 'Log in' : 'Sign up'),
                        ),
                   FlatButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                      _emailController.clear();
                      _userNameController.clear();
                      _passwordController.clear();
                    },
                    child: Text(isLogin
                        ? 'Create an account'
                        : 'I already have an account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

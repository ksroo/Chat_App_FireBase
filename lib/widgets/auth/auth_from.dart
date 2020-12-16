import 'dart:io';

import 'package:chat_chat_chat/widgets/pickers/user_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username, File image,
      bool isLogin, BuildContext ctx) submitFn;
  final bool isLoading;
  AuthForm(this.submitFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _fromKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = " ";
  String _password = " ";
  String _username = " ";
  File _userImageFile;

  void _pickedImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  void _submit() {
    final isValid = _fromKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "Please pick an image",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _fromKey.currentState.save();
      widget.submitFn(
        _email.trim(),
        _password.trim(),
        _username.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (val) {
                    if (val.isEmpty || !val.contains("@")) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email Address"),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 4) {
                        return "Please enter a least 4 character";
                      }
                      return null;
                    },
                    onSaved: (val) => _username = val,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val) {
                    if (val.isEmpty || val.length < 7) {
                      return "Please enter a least 7 character";
                    }
                    return null;
                  },
                  onSaved: (val) => _password = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : "Sign Up"),
                    onPressed: _submit,
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? "Create new account"
                        : "I already have an account"),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

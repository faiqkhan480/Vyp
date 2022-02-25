import 'package:flutter/material.dart';
import 'package:vyv/components/login_form.dart';
import 'package:vyv/components/signup_form.dart';

class DialogComponent extends StatefulWidget {
  const DialogComponent({Key? key}) : super(key: key);

  @override
  _DialogComponentState createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent> {
  bool isLogin = true;

  void handleChange(bool val) => setState(() => isLogin = val);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: isLogin ? LoginForm(action: handleChange) : SignupForm(action: handleChange,),
    );
  }
}


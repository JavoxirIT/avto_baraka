import 'package:avto_baraka/widgets/carousel/main_carousel_form_registration.dart';
import 'package:flutter/material.dart';

class LoginToAnotherAccount extends StatefulWidget {
  const LoginToAnotherAccount({Key? key}) : super(key: key);

  @override
  LoginToAnotherAccountState createState() => LoginToAnotherAccountState();
}

class LoginToAnotherAccountState extends State<LoginToAnotherAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: const MainCarouselFormRegistration(),
    );
  }
}

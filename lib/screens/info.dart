// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:komik_app/widgets/custom_title.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(title: "Info"),
              SizedBox(height: 10),
              Text(
                  "Hello, thanks for your appreciate using my app, please give me a feedback. For more info about me, check my social media : "),
              _info("Email : ", "muhammadfaizalghozi1@gmail.com"),
              _info("Phone : ", "+62 878 1819 7732"),
              _info("Instagram : ", "@faizghozy23"),
              _info("Github : ", "github.com/Al-Ghozy03"),
            ],
          ),
        ),
      )),
    );
  }

  Widget _info(String title, String value) {
    return Column(
      children: [
        SizedBox(height: 8),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: title, style: TextStyle(fontFamily: "semibold")),
          TextSpan(text: value),
        ], style: TextStyle(fontFamily: "montserrat")))
      ],
    );
  }
}

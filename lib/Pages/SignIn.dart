import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khana_mobile_application/Services/FirebaseServicesAuth.dart';
import 'package:khana_mobile_application/UI/khana_icons_icons.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool isVisable = false;
  double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/background.png"),
                alignment: Alignment.topLeft)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 9),
              ////////////////////////////////////////////////////////////////////
              /// Image
              Container(
                  width: 130,
                  height: 210,
                  child: SvgPicture.asset(
                    "assets/img/big.svg",
                    fit: BoxFit.contain,
                  )),
              ////////////////////////////////////////////////////////////////////
              /// welcome
              Text(
                "Welcome to your\nkhana application",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3589E0),
                ),
              ),
              ////////////////////////////////////////////////////////////////////
              /// Email address
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Email Address",
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: Color(0xFFE2F8FE).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none,
                      hintText: "name@example.com"),
                ),
              ),
              ////////////////////////////////////////////////////////////////////
              /// Password
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  child: Text(
                    "Password",
                    textAlign: TextAlign.start,
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                    color: Color(0xFFE2F8FE).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: pass,
                  obscureText: isVisable,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(
                            isVisable ? Feather.eye_off : Feather.eye,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isVisable = !isVisable;
                            });
                          }),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none,
                      hintText: "123456"),
                ),
              ),
              ////////////////////////////////////////////////////////////////////
              /// Login Button
              Container(
                width: double.infinity,
                height: 55,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                decoration: BoxDecoration(
                    color: Color(0xFF43A0E7),
                    borderRadius: BorderRadius.circular(10)),
                child: FlatButton(
                  onPressed: () {
                    context.read<FirebaseAuthServices>().signIn(
                      email: email.text.trim(),
                      password: pass.text.trim(),
                    );
                  },
                  child: Text(
                    'login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

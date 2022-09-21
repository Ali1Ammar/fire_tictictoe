//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictictoeproject1223/src/helper/route_helper.dart';
import 'package:tictictoeproject1223/src/page/profile_page.dart';

import 'fire_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final global = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isLogin = false;

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      Future.microtask(() {
            goToPage(context,const ProfilePage());
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: 300,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 198, 200, 203),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/coupon-test-18a.appspot.com/o/undraw_access_account_re_8spm.png?alt=media"),
              ),
            ),
            if (!isLogin)
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isLogin = true;
                    });
                  },
                  child: Text("do you have account?")),
            if (isLogin)
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                  },
                  child: Text("create new account?")),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Form(
                key: global,
                child: Column(
                  children: [
                    Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            isLogin ? "Login" : "create account",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    if (!isLogin)
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Name",
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                            .hasMatch(text!)) {
                          return "enter valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(30)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: passController,
                      validator: (text) {
                        if (!RegExp(
                                r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
                            .hasMatch(text!)) {
                          return "enter valida password";
                        }

                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(30)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (global.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          if (isLogin) {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text);
                          } else {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text);
                            await FirebaseAuth.instance.currentUser!
                                .updateDisplayName(nameController.text);
                          }

                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: SizedBox(
                          width: double.maxFinite,
                          height: 40,
                          child: Center(child: Text("Sign in"))),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

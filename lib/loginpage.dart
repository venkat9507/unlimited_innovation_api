import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unlimited_innovation/api_page.dart';
import 'package:unlimited_innovation/registration_screen.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  bool secureText = true;
  bool showSpinner = false;
  var emailKey = GlobalKey<FormState>();
  var passwordKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.green.shade300,
          title: Text('LoginPage',style: TextStyle(color: Colors.white),),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Form(
              key: emailKey,
              child: TextFormField(
              validator: (String value){
                if(value.length < 5)
                  return 'Enter atleast 8 character from yout email';
              },
              controller: nameController,
              onChanged: (value){
                email = value;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: Color(0xFF87837e),
                  ),
                  suffixIcon: Icon(Icons.email_rounded),
                  hoverColor: Colors.yellow,
                  filled: true,
                  focusColor: Colors.yellow),
            ),),
            SizedBox(
              height: 10,
            ),
            Form(
              key: passwordKey,
              child: TextFormField(
                validator: (String value){
                  if(value.length < 8)
                    return " Enter at least 8 character from your password";
                  else
                    return null;
                },
                obscureText: secureText,
                onChanged: (value){
                  password =value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Color(0xFF87837e),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon( secureText ? Icons.remove_red_eye_outlined : Icons.security),
                      onPressed: () {
                        setState(() {
                          secureText = !secureText;
                        });

                      },
                      color: Colors.lightGreenAccent,
                    ),
                    hoverColor: Colors.yellow,
                    filled: true,
                    focusColor: Colors.yellow),
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.pink,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth
                          .signInWithEmailAndPassword(
                          email: email, password: password)
                          .then((FirebaseUser) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Api()),
                        );
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(' deleted'),
                        ));
                      }).catchError((e) {
                        print(e);
                        var snackbar = SnackBar(
                            content: Text(
                                'User name and password is incorrect please check the user name and password....'));
                        scaffoldKey.currentState.showSnackBar(snackbar);
                      });
                       //Go to login screen.

                      setState(() {
                        showSpinner = false;
                        emailKey.currentState.validate();
                        passwordKey.currentState.validate();
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  minWidth: 100,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()),
                    );
                  });
                },
                child: Text(
                  "Don't have an account? Register now",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                )),
          ],
        )),
      ),
    );
  }
}

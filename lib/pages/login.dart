import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackdu/pages/searchPage.dart';
import 'package:hackdu/pages/signup.dart';

class Login extends StatefulWidget {
   Login({super.key});
  bool isPressed = false;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "L O G I N",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Email"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Password"),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if (email.text.isNotEmpty) {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Password reset link sent to ${email.text}")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Enter your email first")));
                    }
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 150,
                onPressed: () async {
                  if (email.text.isEmpty || password.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("One of the fields are empty")));
                  } else {
                    try {
                      setState(() {
                        widget.isPressed = true;
                      });
                      UserCredential user = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email.text, password: password.text);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SearchPage();
                      }));
                      // final googleSignIn = await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
                    } on FirebaseAuthException catch (e) {

                      if (e.code == "user-not-found") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Account doesn't exist")));
                      } else if (e.code == "wrong-password") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Account doesn't exist")));
                      }
                      // setState(() {
                      //   widget.isPressed = false;
                      // });
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                color: Colors.black12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: widget.isPressed?const CircularProgressIndicator(): const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey),
                  ),
                  InkWell(
                    child: const Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const Register();
                      }));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

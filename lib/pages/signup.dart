import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackdu/database/database.dart';
import 'package:hackdu/pages/searchPage.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false; // Added a state variable to track loading state

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController rePassword = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "R E G I S T E R",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Full name"),
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
                height: 20,
              ),
              TextField(
                controller: rePassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Re-enter password"),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {
                  if (name.text.isEmpty ||
                      email.text.isEmpty ||
                      password.text.isEmpty ||
                      rePassword.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("One of the fields is empty")));
                  } else if (password.text != rePassword.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Passwords do not match")));
                  } else {
                    setState(() {
                      _isLoading = true; // Set loading state to true
                    });
                    try {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email.text, password: password.text);
                      CollectionReference userDB =
                      FirebaseFirestore.instance.collection('users');
                      userDB.add({
                        'name': name.text,
                        'email': email.text
                      });
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                            return SearchPage();
                          }));
                    } on FirebaseAuthException catch (e) {
                      print(e.code);
                      setState(() {
                        _isLoading = false; // Set loading state to false
                      });
                      if (e.code == "weak-password") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Use a stronger password")));
                      } else if (e.code == "email-already-in-use") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Email is already in use")));
                      }
                      else if (e.code == "invalid-email") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Email format is invalid")));
                      }
                    } catch (e) {
                      setState(() {
                        _isLoading = false; // Set loading state to false
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Some error occurred. Please try again later")));
                    }
                  }
                },
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                color: Colors.black12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    child: const Text(
                      "Login",
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                            return Login();
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
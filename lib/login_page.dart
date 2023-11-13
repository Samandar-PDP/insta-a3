import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _manager = FirebaseManager();
  bool _isLoading = false;
  final _email = TextEditingController();
  final _password = TextEditingController();

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    _manager.login(_email.text, _password.text)
    .then((value) {
      if(value == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Container()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color(0xFFd62976),
              Color(0xffaf4d00),
            ],
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Instagram',
                        style: GoogleFonts.dancingScript(
                            fontSize: 45, color: Colors.white)),
                    const SizedBox(height: 50),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: const TextStyle(color: Colors.white70),
                          fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.white70),
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey,width: 2)
                        ),
                        child: const Center(
                          child: Text("Log in",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => const RegisterPage()));
                  },
                  child: const Text("Don't have an accaunt? Sign Up",style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
                  children: [
                    Text('Instagram',
                        style: GoogleFonts.dancingScript(
                            fontSize: 25, color: Colors.white)),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                          fillColor: Colors.grey[200]
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          fillColor: Colors.grey[200]
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey,width: 2)
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4AC64),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 100),
              Image.asset('assets/images/icon.png', width: 300),
              SizedBox(height: 50),
              TextFormField(
                style: TextStyle(
                  fontFamily: "Kanit",
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFFF4AC64),
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    fontFamily: "Kanit",
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFF4AC64),
                  ),
                  hintText: "Username",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  prefixIcon: Icon(Icons.person_rounded),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                style: TextStyle(
                  fontFamily: "Kanit",
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFFF4AC64),
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    fontFamily: "Kanit",
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFF4AC64),
                  ),
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  prefixIcon: Icon(Icons.password),
                ),
                obscureText: true,
              ),
              SizedBox(height: 25),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // context.read<CategoryBloc>().add(CategoryGet());
                    // context.read<ProductBloc>().add(GetProductAll());
                    Navigator.popAndPushNamed(context, '/home');
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Kanit",
                      color: Color(0xFFF4AC64),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

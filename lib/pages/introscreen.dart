import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({super.key});

  @override
  State<Introscreen> createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();

    return IntroductionScreen(
      globalBackgroundColor: Color(0xFFF4AC64),

      key: introKey,
      pages: [
        PageViewModel(
          titleWidget: Column(
            children: [
              SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Image.asset('assets/images/bg1.png', width: 300),
                    SizedBox(height: 100),
                    Text(
                      'Manage Ur Store Easyly & quickly',
                      style: TextStyle(
                        fontFamily: "Kanit",
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bodyWidget: Column(
            children: [
              SizedBox(height: 50),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontFamily: "Kanit"),
              ),
            ],
          ),
        ),
        PageViewModel(
          titleWidget: Column(
            children: [
              SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset('assets/images/icon.png', width: 300),
                    SizedBox(height: 100),
                    Text(
                      'Store Manage App',
                      style: TextStyle(
                        fontFamily: "Kanit",
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bodyWidget: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontFamily: "Kanit"),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  child: Text(
                    "Get Started",
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
      ],
      showNextButton: false,
      showDoneButton: false,
    );
  }
}

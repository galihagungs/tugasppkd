import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_new/bloc/category/category_bloc.dart';
import 'package:ui_new/bloc/product/product_bloc.dart';
import 'package:ui_new/pages/homepage.dart';
import 'package:ui_new/pages/introscreen.dart';
import 'package:ui_new/pages/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ProductBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          '/': (context) => Introscreen(),
          '/login': (context) => Loginpage(),
          '/home': (context) => Homepage(),
        },
      ),
    );
  }
}

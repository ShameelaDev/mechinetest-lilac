import 'package:flutter/material.dart';
import 'package:mechinetest/pages/course_page.dart';
import 'package:mechinetest/pages/login_page.dart';
import 'package:mechinetest/pages/splash_screen.dart';

void main(){
runApp(MechineTest());
}

class MechineTest extends StatelessWidget {
  const MechineTest({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.purple),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const CoursePage(), 
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'mainpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigatetoMainPage();
  }

  _navigatetoMainPage() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainContent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFFF800B),
                Color(0xFFCE1010),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.network(
                  "https://slumberjer.com/rentaroom/images/3_1.jpg",
                  height: 300.0,
                  width: 300.0,
                ),
                const Text(
                  "A perfect place for your\n stay",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                ),
                const Text(
                  "RentARoom",
                  style: TextStyle(
                      fontSize: 48,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}

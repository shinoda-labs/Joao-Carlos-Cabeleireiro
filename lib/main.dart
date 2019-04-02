import 'package:flutter/material.dart';
import 'package:joao_carlos_cabelereiro/ui/home_activity.dart';

void main() => runApp(JoaoCarlosCabelereiro());

class JoaoCarlosCabelereiro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "João Carlos Cabelereiro",
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 33, 33, 33),
        primarySwatch: Colors.yellow
      ),
      debugShowCheckedModeBanner: false,
      home: HomeActivity(),
    );
  }
}
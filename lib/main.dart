import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carrinho.dart';
import 'login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => Carrinho(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S&M Hotel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}

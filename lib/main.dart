import 'package:ecommerce/pages/cart_details.dart';
import 'package:ecommerce/pages/favorite_screen.dart';
import 'package:ecommerce/pages/home_screen.dart';
import 'package:ecommerce/pages/profile_screen.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
    ],
    child: MaterialApp(
      title: 'E - Commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  List screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E - Commerce Shop",
        style: TextStyle(
          color: Colors.white, // Cambia el color del texto aquí
          fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartDetails())),
            icon: const Icon(Icons.add_shopping_cart),
          )
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() => currentIndex = value);
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            label:"Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label:"Favorite",
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label:"Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

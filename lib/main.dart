import 'package:crypto_owl/app_preferences.dart';
import 'package:crypto_owl/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'coins_list_screen.dart';
import 'following_coins_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppState(),
      child: MaterialApp(
        title: 'Crypto Owl',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  initState() {
    super.initState();
    loadFollowedCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/owl_icon.png",
            width: 30,
          ),
          Padding(padding: EdgeInsets.only(right: 5, left: 5)),
          Text(
            "Crypto Owl",
            style: TextStyle(color: Colors.black87),
          )
        ]),
      ),
      body: _selectedIndex == 0 ? CoinsListScreen() : FollowingCoinsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: 'Coins',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Following',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.yellow[800],
      ),
    );
  }

  void loadFollowedCoins() {
    AppPreferences().retrieveAllCoins().then((coinsList) {
      var appState = Provider.of<AppState>(context, listen: false);
      appState.followedCoinsIds = coinsList;
    });
  }
}

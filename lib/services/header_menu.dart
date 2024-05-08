import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:play_ground/screens/main-menu-screen.dart';
import 'package:play_ground/screens/play-session-screen.dart';
import 'package:play_ground/services/theme_manager.dart';
import 'package:provider/provider.dart';

class HeaderMenu with ChangeNotifier {
  Widget InitHeaderMenu(
      {required BuildContext context,
      required String title,
      required Widget body}) {
    var themeManger = Provider.of<ThemeManager>(context);
    int _selectedIndex = 0;
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    const List<Widget> _widgetOptions = <Widget>[
      MainMenuScreen(),
      PlaySessionScreen()
    ];

    void _onItemTapped(int index) {
      _selectedIndex = index;
      notifyListeners();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
        drawer: Drawer(
          shape: const RoundedRectangleBorder(),
          child: ListView(
            // Important: Remove any padding from the ListView.
            // padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                // decoration: BoxDecoration(
                //     color: Colors.blue,
                //     image: DecorationImage(
                //         image: AssetImage("assets/images/tunghai-icon.png"),
                //         fit: BoxFit.cover)),
                child: Text('選項',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              ListTile(
                title: const Text('Home'),
                selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(0);
                  // GoRouter.of(context).go('/');
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Business'),
                selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(1);
                  // GoRouter.of(context).go('/play');
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:play_ground/services/theme_manager.dart';
import 'package:provider/provider.dart';

Widget InitHeaderMenu(
    {required BuildContext context,
    required String title,
    required Widget body}) {
  var themeManger = Provider.of<ThemeManager>(context);

  return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: body,
      // child: _widgetOptions[_selectedIndex],
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
              onTap: () {
                // Update the state of the app
                // _onItemTapped(0);
                // GoRouter.of(context).go('/');
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              onTap: () {
                // Update the state of the app
                // _onItemTapped(1);
                // GoRouter.of(context).go('/play');
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ));
}

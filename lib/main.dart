import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:play_ground/screens/play-session-screen.dart';
import 'package:play_ground/services/header_menu.dart';
import 'package:play_ground/services/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:play_ground/screens/main-menu-screen.dart';
import 'package:play_ground/style/my_transition.dart';
import 'package:play_ground/style/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => Palette()),
          ChangeNotifierProvider<ThemeManager>(
            create: (context) => ThemeManager(),
          ),
          ChangeNotifierProvider<HeaderMenu>(
            create: (context) => HeaderMenu(),
          )
        ],
        child: Builder(builder: (context) {
          final palette = context.watch<Palette>();
          final themeManager = context.watch<ThemeManager>();

          return MaterialApp.router(
              title: 'Game',
              theme: ThemeData.light(), // Provide light theme.
              darkTheme: ThemeData.from(
                colorScheme: ColorScheme.fromSeed(
                  primary: Colors.red[200],
                  seedColor: palette.darkPen,
                  background: palette.backgroundMain,
                ),
                textTheme: TextTheme(
                  bodyMedium: TextStyle(color: palette.ink),
                ),
                useMaterial3: true,
              ), // Provide dark theme.
              themeMode: themeManager.mode, // Decides which theme to show.
              // theme: ThemeData.from(
              //   colorScheme: ColorScheme.fromSeed(
              //     primary: Colors.red[200],
              //     seedColor: palette.darkPen,
              //     background: palette.backgroundMain,
              //   ),
              //   textTheme: TextTheme(
              //     bodyMedium: TextStyle(color: palette.ink),
              //   ),
              //   useMaterial3: true,
              // ),
              builder: EasyLoading.init(),
              routerConfig: router);
        }));
  }
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
        builder: (
          BuildContext context,
          GoRouterState state,
          Widget child,
        ) {
          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Menu',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: child,
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
                        GoRouter.of(context).go('/');
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Business'),
                      onTap: () {
                        // Update the state of the app
                        // _onItemTapped(1);
                        GoRouter.of(context).go('/play');
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ));
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
                child: MainMenuScreen(key: Key('main menu'))),
          ),
          GoRoute(
            path: '/play',
            pageBuilder: (context, state) => const NoTransitionPage(
                child: PlaySessionScreen(key: Key('main menu'))),
          ),
        ]),
  ],
);

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:play_ground/screens/header-menu.dart';
import 'package:play_ground/services/header_menu.dart';
import 'package:play_ground/services/theme_manager.dart';
import 'package:provider/provider.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeManger = Provider.of<ThemeManager>(context);

    return Container(
        child: Row(
      children: [
        OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
          onPressed: () {
            themeManger.toggleMode();
          },
          child: const Text('Change Theme'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            GoRouter.of(context).go('/play');
          },
          child: Text('Go To PlaySession'),
        ),
      ],
    ));
  }

  static const _gap = SizedBox(height: 10);
}

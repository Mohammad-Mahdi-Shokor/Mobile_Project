import 'package:flutter/material.dart';
import '../navigation_screen.dart';
import '../services/dataBase.dart';
import 'inituserScreen.dart';

class BootstrapScreen extends StatefulWidget {
  const BootstrapScreen(this.onToggleTheme, {super.key});
  final void Function() onToggleTheme;
  @override
  State<BootstrapScreen> createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<BootstrapScreen> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    final db = await DBHelper.instance.database;
    final res = await db.query('users', limit: 1);

    if (!mounted) return;

    if (res.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => InitUserScreen(widget.onToggleTheme)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => NavigationScreen(onToggleTheme: widget.onToggleTheme),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

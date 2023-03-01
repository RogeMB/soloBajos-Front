import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solo_bajos/blocs/authentication/authentication.dart';
import 'package:solo_bajos/themes/app_theme.dart';
import '../models/models.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    void displayDialogIOS(BuildContext context) {
      final authBloc = BlocProvider.of<AuthenticationBloc>(context);
      showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: () {
                        authBloc.add(UserLoggedOut());
                        Navigator.pop(context);
                        const Duration(milliseconds: 300);
                      },
                      child: const Text('Ok'))
                ],
                title: const Text('Segunda alerta'),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('¿Estás seguro de que quieres salir?'),
                    SizedBox(height: 10),
                    FlutterLogo(size: 100)
                  ],
                ));
          });
    }

    void displayDialogAndroid(BuildContext context) {
      final authBloc = BlocProvider.of<AuthenticationBloc>(context);
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar',
                          style: TextStyle(color: Colors.red))),
                  TextButton(
                      onPressed: () {
                        authBloc.add(UserLoggedOut());
                        Navigator.pop(context);
                        const Duration(milliseconds: 300);
                      },
                      child: const Text('Ok'))
                ],
                elevation: 5,
                title: const Text('Primera alerta'),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('¿Estás seguro de que quieres salir?'),
                    SizedBox(height: 10),
                    FlutterLogo(size: 100)
                  ],
                ));
          });
    }

    int selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
        backgroundColor: AppTheme.primary,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Bienvenido, ${user.fullName}',
                style: const TextStyle(fontSize: 24),
              ),
              Text('${user.avatar}',
                  style: TextStyle(
                      color: const Color.fromARGB(220, 19, 18, 18)
                          .withOpacity(0.6),
                      fontWeight: FontWeight.bold)),
              Text('${user.enabled}',
                  style: TextStyle(
                      color: const Color.fromARGB(220, 19, 18, 18)
                          .withOpacity(0.6),
                      fontWeight: FontWeight.bold)),
              Text('${user.username}',
                  style: TextStyle(
                      color: const Color.fromARGB(220, 19, 18, 18)
                          .withOpacity(0.6),
                      fontWeight: FontWeight.bold)),
              Text('${user.roles}',
                  style: TextStyle(
                      color: const Color.fromARGB(220, 19, 18, 18)
                          .withOpacity(0.6),
                      fontWeight: FontWeight.bold)),
              Text('${user.createdAt}',
                  style: TextStyle(
                      color: const Color.fromARGB(220, 19, 18, 18)
                          .withOpacity(0.6),
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(
                  'Logout',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 238, 238, 238)
                          .withOpacity(0.9),
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Platform.isAndroid
                      ? displayDialogAndroid(context)
                      : displayDialogIOS(context);
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.two_wheeler),
            activeIcon: const Icon(Icons.music_note_rounded),
            label: 'Bass',
            backgroundColor: AppTheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_3_outlined),
            activeIcon: const Icon(Icons.person_3),
            label: 'Users',
            backgroundColor: AppTheme.primary,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solo_bajos/blocs/authentication/authentication.dart';
import '../models/models.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
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
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 238, 238, 238)
                          .withOpacity(0.9),
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  authBloc.add(UserLoggedOut());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

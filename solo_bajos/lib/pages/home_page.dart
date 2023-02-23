import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solo_bajos/blocs/authentication/authentication.dart';
import 'package:solo_bajos/config/locator.dart';
import 'package:solo_bajos/services/services.dart';
import '../models/models.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Welcome, ${user.fullName}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text('Logout'),
                onPressed: () {
                  authBloc.add(UserLoggedOut());
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (kDebugMode) {
                      print("Check");
                    }
                    JwtAuthenticationService service =
                        getIt<JwtAuthenticationService>();
                    await service.getCurrentUser();
                  },
                  child: const Text('Check'))
            ],
          ),
        ),
      ),
    );
  }
}

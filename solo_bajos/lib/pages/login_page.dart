import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solo_bajos/config/locator.dart';
import 'package:solo_bajos/widgets/auth_background.dart';
import 'package:solo_bajos/widgets/cart_container.dart';
import '../blocs/blocs.dart';
import '../services/services.dart';
import '../utils/input_decorations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Solo Bajos')),
        titleTextStyle: const TextStyle(fontSize: 35),
      ),
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 150),
            Center(
                child: Text('Login',
                    style: Theme.of(context).textTheme.headlineLarge)),
            const CardContainer(
              child: formulario(),
            ),
            const SizedBox(height: 30),
            const Text('Registrar una nueva cuenta',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}

class formulario extends StatelessWidget {
  const formulario({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final authBloc = BlocProvider.of<AuthenticationBloc>(context);
        if (state is AuthenticationNotAuthenticated) {
          return _AuthForm();
        }
        if (state is AuthenticationFailure || state is SessionExpiredState) {
          var msg = (state as AuthenticationFailure).message;
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(msg),
              TextButton(
                //textColor: Theme.of(context).primaryColor,
                child: const Text('Retry'),
                onPressed: () {
                  authBloc.add(AppLoaded());
                },
              )
            ],
          ));
        }
        // return splash screen
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      },
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authService = getIt<JwtAuthenticationService>();
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    // ignore: no_leading_underscores_for_local_identifiers
    _onLoginButtonPressed() {
      if (_key.currentState!.validate()) {
        loginBloc.add(LoginInWithUsernameButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _key,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'ejemplo: rogemb',
                        labelText: 'Username',
                        prefixIcon: Icons.person_2_rounded),
                    controller: _usernameController,
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null) {
                        return 'Username es obligatorio.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'ejemplo: Password!1',
                        labelText: 'Password',
                        prefixIcon: Icons.password_outlined),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null) {
                        return 'Password es obligatoria.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  MaterialButton(
                    autofocus: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    onPressed:
                        state is LoginLoading ? () {} : _onLoginButtonPressed,
                    color: Colors.deepPurple,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 20),
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }
}

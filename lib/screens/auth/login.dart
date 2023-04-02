import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:todo_app/blocs/auth-bloc/auth.bloc.dart';
import 'package:todo_app/components/buttons.dart';
import 'package:todo_app/components/input.fields.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/screens/auth/signup.dart';
import 'package:todo_app/screens/todo/todo.page.dart';
import 'package:todo_app/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
              key: formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraint.maxHeight - 70,
                ),
                child: IntrinsicHeight(
                  child: BlocConsumer<AuthBloc, AuthState>(
                      bloc: authBloc,
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          AppLoader.hide();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TodoScreen()),
                              (route) => false);
                        }
                        if (state is LoginError) {
                          AppLoader.hide();
                          toast(state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          AppLoader.show(context);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 120),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Log in to your account to add todos',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              validator: Validator.validateEmail,
                              controller: emailController,
                            ),
                            const SizedBox(height: 35),
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: '******',
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              textCapitalization: TextCapitalization.none,
                              controller: passwordController,
                              validator: (value) =>
                                  Validator.validateText(value, 'Password'),
                            ),
                            const SizedBox(height: 30),
                            const Spacer(),
                            CustomButton(
                              label: 'LOGIN',
                              color: Colors.black,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  authBloc.add(
                                    LoginEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              size: size,
                              textColor: Colors.white,
                              borderSide: BorderSide.none,
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                                child: RichText(
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontFamily: 'Karla',
                                      fontSize: 17,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: 'Sign up here',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontFamily: 'Karla',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        );
                      }),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:todo_app/blocs/auth-bloc/auth.bloc.dart';
import 'package:todo_app/components/buttons.dart';
import 'package:todo_app/components/input.fields.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/screens/auth/login.dart';
import 'package:todo_app/screens/auth/update.account.name.dart';
import 'package:todo_app/utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                        if (state is SignUpSuccess) {
                          AppLoader.hide();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UpdateAccountNameScreen(),
                            ),
                          );
                        }
                        if (state is SignUpError) {
                          AppLoader.hide();
                          toast(state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is SignUpLoading) {
                          AppLoader.show(context);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 120),
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Open an account to use the Todo app',
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
                              label: 'CREATE YOUR ACCOUNT',
                              color: Colors.black,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  authBloc.add(
                                    SignUpEvent(
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
                                              const LoginScreen()));
                                },
                                child: RichText(
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontFamily: 'Karla',
                                      fontSize: 17,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: 'Sign in here',
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

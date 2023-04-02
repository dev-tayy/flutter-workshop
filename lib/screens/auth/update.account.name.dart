import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:todo_app/blocs/auth-bloc/auth.bloc.dart';
import 'package:todo_app/components/buttons.dart';
import 'package:todo_app/components/input.fields.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/screens/todo/todo.page.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/utils/validators.dart';

class UpdateAccountNameScreen extends StatefulWidget {
  const UpdateAccountNameScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAccountNameScreen> createState() =>
      _UpdateAccountNameScreenState();
}

class _UpdateAccountNameScreenState extends State<UpdateAccountNameScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController fnameController;
  late TextEditingController lnameController;

  @override
  void initState() {
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
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
                        if (state is UpdateAccountNameSuccess) {
                          AppLoader.hide();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TodoScreen()),
                              (route) => false);
                        }
                        if (state is UpdateAccountNameError) {
                          AppLoader.hide();
                          toast(state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is UpdateAccountNameLoading) {
                          AppLoader.show(context);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 120),
                            const Text(
                              'Update account name',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Enter your personal details',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              'First name',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Enter first name',
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (val) =>
                                  Validator.validateText(val, 'First name'),
                              controller: fnameController,
                            ),
                            const SizedBox(height: 35),
                            Text(
                              'Last name',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Enter last name',
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.sentences,
                              controller: lnameController,
                              validator: (value) =>
                                  Validator.validateText(value, 'Last name'),
                            ),
                            const SizedBox(height: 30),
                            const Spacer(),
                            CustomButton(
                              label: 'UPDATE ACCOUNT NAME',
                              color: Colors.black,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  final fullName =
                                      '${fnameController.text}, ${lnameController.text}';
                                  authBloc.add(
                                    UpdateAccountNameEvent(
                                        fullName: fullName.toTitleCase()),
                                  );
                                }
                              },
                              size: size,
                              textColor: Colors.white,
                              borderSide: BorderSide.none,
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

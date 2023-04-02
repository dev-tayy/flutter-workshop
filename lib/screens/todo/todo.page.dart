import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:todo_app/blocs/auth-bloc/auth.bloc.dart';
import 'package:todo_app/blocs/todo-bloc/todo.bloc.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/components/todo.tile.dart';
import 'package:todo_app/models/todo.model.dart';
import 'package:todo_app/screens/auth/login.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Set active = {};

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(GetAllTodosEvent());
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  handleTap(int index) {
    if (active.isNotEmpty) active.clear();
    active.add(index);
  }

  List<TodoModel> todos = [];

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF161622),
      body: BlocConsumer<TodoBloc, TodoState>(
          bloc: todoBloc,
          listener: (context, state) {
            if (state is GetAllTodosSuccess) {
              AppLoader.hide();
              todos = state.todos;
            }
            if (state is GetAllTodosError) {
              AppLoader.hide();
              toast(state.error);
            }
            if (state is AddTodoSuccess) {
              todoBloc.add(GetAllTodosEvent());
              toast(state.message);
            }
            if (state is AddTodoError) {
              AppLoader.hide();
              toast(state.error);
            }
            if (state is DeleteTodoSuccess) {
              todoBloc.add(GetAllTodosEvent());
              toast(state.message);
            }
            if (state is DeleteTodoError) {
              AppLoader.hide();
              toast(state.error);
            }
            if (state is UpdateTodoStatusSuccess) {
              todoBloc.add(GetAllTodosEvent());
              toast(state.message);
            }
            if (state is UpdateTodoStatusError) {
              AppLoader.hide();
              toast(state.error);
            }
          },
          builder: (context, state) {
            if (state is GetAllTodosLoading ||
                state is DeleteTodoLoading ||
                state is AddTodoLoading ||
                state is UpdateTodoStatusLoading) {
              AppLoader.show(context);
            }
            return BlocListener<AuthBloc, AuthState>(
              bloc: authBloc,
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }
                if (state is LogoutError) {
                  toast(state.error);
                }
              },
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bg-mobile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 70, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'T O D O',
                              style: GoogleFonts.josefinSans(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.54,
                                color: Colors.white,
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: const Icon(
                                Icons.logout,
                                color: Colors.red,
                                size: 30,
                              ),
                              onPressed: () {
                                authBloc.add(LogoutEvent());
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 34),
                        TextField(
                          controller: controller,
                          style: GoogleFonts.josefinSans(color: Colors.white),
                          cursorColor: Colors.white,
                          cursorHeight: 16,
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Create a new todo...',
                            hintStyle: GoogleFonts.josefinSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6C6E83),
                            ),
                            fillColor: const Color(0xFF25273C),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: CupertinoButton(
                              onPressed: () async {
                                if (controller.text.trim().isNotEmpty) {
                                  todoBloc.add(AddTodoEvent(
                                      content: controller.text.trim()));
                                  controller.clear();
                                }
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView.builder(
                            itemCount: todos.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TodoListTile(
                                title: todos[index].content,
                                isChecked: todos[index].isDone,
                                onChecked: (value) {
                                  handleTap(index);
                                  if (active.contains(index)) {
                                    todoBloc.add(
                                      UpdateTodoStatusEvent(
                                          id: todos[index].id,
                                          isChecked: !todos[index].isDone),
                                    );
                                  }
                                },
                                onDelete: () async {
                                  handleTap(index);
                                  if (active.contains(index)) {
                                    todoBloc.add(
                                      DeleteTodoEvent(id: todos[index].id),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 25,
                      ),
                      child: Text(
                        todos.length > 1
                            ? '${todos.length} items'
                            : '${todos.length} item',
                        style: GoogleFonts.josefinSans(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

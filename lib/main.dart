import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/api_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  Set active = {};

  final TextEditingController controller = TextEditingController();

  handleTap(int index) {
    if (active.isNotEmpty) active.clear();
    active.add(index);
  }

  final ApiClient client = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161622),
      body: FutureBuilder(
        future: client.getAllTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text('An error occured');
          }
          return Stack(
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
                padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    const SizedBox(height: 34),
                    TextField(
                      controller: controller,
                      style: GoogleFonts.josefinSans(color: Colors.white),
                      cursorColor: Colors.white,
                      cursorHeight: 16,
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
                            if (controller.text.isNotEmpty) {
                              await client.createTodo(controller.text);
                              controller.clear();
                              setState(() {});
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
                    ...List.generate(
                      snapshot.data!.length,
                      (index) {
                        return TodoListTile(
                          onChecked: (value) {
                            handleTap(index);
                            if (active.contains(index)) {
                              if (snapshot.data![index]['is_done']) {
                                snapshot.data![index]['is_done'] = false;
                              } else {
                                snapshot.data![index]['is_done'] = true;
                              }
                            }
                            setState(() {});
                          },
                          isChecked: snapshot.data![index]['is_done'],
                          title: snapshot.data![index]['content'],
                          onDelete: () async {
                            handleTap(index);
                            if (active.contains(index)) {
                              await client
                                  .deleteTodo(snapshot.data![index]['_id']);
                              setState(() {});
                            }
                          },
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25273C),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${snapshot.data!.length} items',
                        style: GoogleFonts.josefinSans(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    Key? key,
    required this.onChecked,
    required this.title,
    required this.onDelete,
    required this.isChecked,
  }) : super(key: key);

  final Function(bool?)? onChecked;
  final Function() onDelete;
  final String title;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Container(
        color: const Color(0xFF25273C),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          minLeadingWidth: 12,
          leading: SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: isChecked,
              onChanged: onChecked,
              activeColor: isChecked ? Colors.green : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.josefinSans(
              fontSize: 16,
              color: isChecked ? const Color(0xFF6C6E83) : Colors.white,
              textStyle: TextStyle(
                decoration: isChecked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onDelete,
            child: const Icon(
              Icons.close_outlined,
              color: Colors.red,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class TodoModel {
  String content;
  String id;
  bool isDone;
  TodoModel(this.content, this.isDone, this.id);
}

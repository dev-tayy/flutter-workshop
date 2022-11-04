import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  final todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161622),
      body: Stack(
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
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          todos.add(TodoModel(controller.text, false));
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
                ...List.generate(todos.length, (index) {
                  return TodoListTile(
                    onChecked: (value) {
                      handleTap(index);
                      if (active.contains(index)) {
                        if (todos[index].isChecked) {
                          todos[index].isChecked = false;
                        } else {
                          todos[index].isChecked = true;
                        }
                      }
                      setState(() {});
                    },
                    isChecked: todos[index].isChecked,
                    title: todos[index].title,
                    onDelete: () {
                      handleTap(index);
                      if (active.contains(index)) {
                        todos.removeAt(index);
                        setState(() {});
                      }
                    },
                  );
                }),
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
                    '${todos.length} items',
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
  String title;
  bool isChecked;
  TodoModel(this.title, this.isChecked);
}

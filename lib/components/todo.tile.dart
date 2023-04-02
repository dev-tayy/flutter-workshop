import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

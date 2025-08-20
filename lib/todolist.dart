import 'package:flutter/material.dart';
import 'package:studybuddy/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key, 
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20, 
        bottom: 0,
      ),
      child: Slidable(
        key: ValueKey(taskName),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // align checkbox top
            children: [
              Checkbox(
                value: taskCompleted, 
                onChanged: onChanged,
                checkColor: Colors.black,
                activeColor: Colors.white,
                side: const BorderSide(color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(  // ← make text take remaining space and wrap
                child: Text(
                  taskName,
                  style: textStyleDecorated( 
                    18,
                    color: Colors.white,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.blue.shade700,
                    decorationThickness: 2.0,
                  ),
                  softWrap: true,          // allow wrapping
                  overflow: TextOverflow.visible, // show all text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

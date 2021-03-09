import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:gotodo/presentation_v1.1/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation_v1.1/widgets/widget_button.dart';

typedef AddTaskCallback = void Function(TodoItem todoItem);

class AddTaskPage extends StatefulWidget {
  final AddTaskCallback addTaskCallback;

  const AddTaskPage({Key key, @required this.addTaskCallback})
      : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TodoItemModel todoItem;

  String taskTitle = '';

  TextEditingController taskTitleController;

  @override
  void initState() {
    super.initState();
    taskTitleController = TextEditingController();
    todoItem = TodoItemModel(
      title: taskTitleController.text,
      due: DateTime.now(),
      done: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppTheme.bezelPaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(Feather.x),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text('Add task'),
                  Icon(
                    Icons.cancel,
                    color: Colors.transparent,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: taskTitleController,
                    autofocus: true,
                  ),
                ),
              ),
              Spacer(),
              MainButton(
                color: AppTheme.color_accent_1,
                function: () {
                  todoItem.title = taskTitleController.text;
                  widget.addTaskCallback(todoItem);
                  Navigator.pop(context);
                },
                label: 'Add task',
                labelStyle: AppTheme.textStyle_h3_white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

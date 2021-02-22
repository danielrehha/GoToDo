import 'package:flutter/material.dart';
import 'package:gotodo/core/utils/format_date.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/presentation/theme/custom_theme.dart';

class TodoItemWidget extends StatelessWidget {
  TodoItemModel todoItem;
  TodoItemWidget({Key key, @required this.todoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomTheme.todoItemSpacing,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: CustomTheme.divider_color),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                todoItem.title,
                style: CustomTheme.h2,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: CustomTheme.accent_body_main,
                    size: 18,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    FormatDate.date1(date: todoItem.due),
                    style: CustomTheme.bodyTextAccent,
                  ),
                  Spacer(),
                  InkWell(
                    child: Icon(
                      Icons.delete,
                      size: 20,
                    ),
                    onTap: () {
                      //Introduce bloc
/*                       setState(() {
                        todoItems.removeWhere((e) => e.title == todoItem.title);
                      }); */
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

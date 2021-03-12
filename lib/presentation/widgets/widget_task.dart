import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/core/utils/translate_date.dart';
import 'package:gotodo/core/utils/translate_date_color.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_item/todoitem_bloc.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';

typedef TodoCompletedCallback = Future<void> Function(
    TodoItem todoItem, bool success);

class TaskRowWidget extends StatefulWidget {
  final TodoCompletedCallback onTodoCompleted;
  final Animation animation;
  TodoItemModel todoItem;
  TaskRowWidget({
    Key key,
    @required this.todoItem,
    @required this.animation,
    @required this.onTodoCompleted,
  }) : super(key: key);

  @override
  _TaskRowWidgetState createState() => _TaskRowWidgetState();
}

class _TaskRowWidgetState extends State<TaskRowWidget> {
  bool successCompletingItem = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.todoItemSpacing,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.color_dark_black,
          borderRadius: AppTheme.borderRadius,
        ),
        child: Padding(
          padding: AppTheme.rowItemPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<TodoItemBloc, TodoItemState>(
                builder: (context, state) {
                  if (state is TodoItemCompleting &&
                      state.todoItem.id == widget.todoItem.id) {
                    return SpinKitCircle(
                      color: Colors.white,
                      size: AppTheme.iconSize,
                    );
                  }

                  if (state is TodoItemCompletionError &&
                      state.todoItem.id == widget.todoItem.id) {
                    return Icon(
                      Feather.info,
                      size: AppTheme.iconSize,
                      color: Colors.red,
                    );
                  }

                  if (state is TodoItemCompleted &&
                      state.todoItem.id == widget.todoItem.id) {
                    widget.todoItem = state.todoItem;
                    successCompletingItem = true;
                    widget.onTodoCompleted(
                        widget.todoItem, successCompletingItem);
                  }

                  return customCheckBox(context);
                },
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.todoItem.title,
                    style: widget.todoItem.done
                        ? AppTheme.textStyle_body_white_crossed
                        : AppTheme.textStyle_body_white,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Feather.calendar,
                        size: 14,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        TranslateDate.call(date: widget.todoItem.due),
                        style:
                            TranslateDateColor.call(date: widget.todoItem.due),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customCheckBox(BuildContext context) {
    const double _size = 25.0;
    const double _borderRadius = 32.0;
    const Color _checkColor = Colors.grey;
    const Color _borderColor = Colors.grey;
    const double _width = 2;

    return InkWell(
      child: AnimatedCrossFade(
        firstCurve: Curves.elasticIn,
        duration: Duration(milliseconds: 50),
        crossFadeState: widget.todoItem.done
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: _borderColor,
              width: _width,
            ),
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
        secondChild: Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            color: _checkColor,
            border: Border.all(
              color: _checkColor,
              width: _width,
            ),
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          child: FittedBox(
            child: Icon(
              Feather.check,
              color: AppTheme.color_dark_black,
            ),
          ),
        ),
      ),
      onTap: () {
        TodoItemModel todoItemModel = widget.todoItem;
        //todoItemModel.id = 100;
        BlocProvider.of<TodoItemBloc>(context).add(
          CompleteTodoItemEvent(todoItem: todoItemModel),
        );
      },
    );
  }
}

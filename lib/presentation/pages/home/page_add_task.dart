import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/core/providers/user_provider/user_provider.dart';
import 'package:gotodo/core/utils/empty_field_verification.dart';
import 'package:gotodo/core/utils/translate_date.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_item/todoitem_bloc.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_button.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

typedef AddTaskCallback = void Function(TodoItem todoItem);

class AddTaskPage extends StatefulWidget {
  final AddTaskCallback addTaskCallback;
  TodoItemModel todoItem;

  AddTaskPage({Key key, @required this.addTaskCallback, this.todoItem})
      : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage>
    with SingleTickerProviderStateMixin {
  TextEditingController taskTitleController;
  CalendarController _calendarController;

  AnimationController _calendarAnimationController;
  Animation<double> _datePickerAnimation;

  bool isDatePickerOpened = false;
  bool isErrorMessage = false;
  String errorMessage = 'Task title cannot be empty';

  bool isEdit = false;

  EmptyFieldVerification fieldVerification = EmptyFieldVerification();

  @override
  void initState() {
    super.initState();
    taskTitleController = TextEditingController();
    _calendarController = CalendarController();
    _calendarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _calendarAnimationController,
      curve: Curves.ease,
      reverseCurve: Curves.ease,
    );

    _datePickerAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _calendarAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isDatePickerOpened = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isDatePickerOpened = false;
        });
      }
    });

    if (widget.todoItem == null) {
      isEdit = false;
      widget.todoItem = TodoItemModel(
          due: DateTime.now(), title: "", done: false, userId: 'id', id: 0);
    } else {
      isEdit = true;
      taskTitleController.text = widget.todoItem.title;
    }
  }

  @override
  Widget build(BuildContext context) {
/*     widget.todoItem.userId =
        Provider.of<UserProvider>(context, listen: false).userModel.userId; */
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
                  Text(
                    isEdit ? 'Edit task ' : 'Create task',
                    style: AppTheme.textStyle_h3_black,
                  ),
                  BlocBuilder<TodoItemBloc, TodoItemState>(
                    builder: (context, state) {
                      if (state is TodoItemCreating) {
                        return SpinKitCircle(
                          color: Colors.blue,
                          size: AppTheme.iconSize,
                        );
                      }

                      if (state is TodoItemCreationError) {
                        return Icon(
                          Feather.info,
                          size: AppTheme.iconSize,
                          color: Colors.red,
                        );
                      }

                      if (state is TodoItemCreated) {
                        widget.addTaskCallback(state.todoItem);
                        popContextAfterTaskAdded(context);
                        return Icon(
                          Feather.check,
                          size: AppTheme.iconSize,
                          color: Colors.green,
                        );
                      }

                      return Icon(
                        Icons.cancel,
                        color: Colors.transparent,
                        size: AppTheme.iconSize,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: AppTheme.borderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'e.g. Buy groceries'),
                    controller: taskTitleController,
                    autofocus: true,
                    onChanged: (String value) {
                      hideError();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              isErrorMessage
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          errorMessage,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    )
                  : Container(),
              InkWell(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Feather.calendar,
                        size: AppTheme.iconSize,
                      ),
                      Text(
                        TranslateDate.call(
                          date: widget.todoItem.due,
                        ),
                        style: AppTheme.textStyle_body_black,
                      ),
                      Icon(
                        isDatePickerOpened
                            ? Ionicons.ios_arrow_down
                            : Ionicons.ios_arrow_forward,
                        size: AppTheme.iconSize,
                      )
                    ]),
                onTap: () {
                  isDatePickerOpened
                      ? _calendarAnimationController.reverse()
                      : _calendarAnimationController.forward();
                },
              ),
              datePicker(),
              SizedBox(
                height: 8,
              ),
              //Spacer(),
              MainButton(
                color: AppTheme.color_accent_1,
                function: () {
                  if (!isEdit) {
                    submitTodoItemToBloc(context, todoItem: widget.todoItem);
                  } else {
                    editTodoItem(context);
                  }
                },
                label: isEdit ? 'Done' : 'Add task',
                labelStyle: AppTheme.textStyle_h3_white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void popContextAfterTaskAdded(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 200));
      BlocProvider.of<TodoItemBloc>(context).add(ResetAddTaskPageEvent());
      Navigator.pop(context);
    });
  }

  void submitTodoItemToBloc(BuildContext context,
      {@required TodoItem todoItem}) {
    if (fieldVerification(value: taskTitleController.text)) {
      todoItem.title = taskTitleController.text;
      todoItem.userId =
          Provider.of<UserProvider>(context, listen: false).userModel.userId;
      BlocProvider.of<TodoItemBloc>(context)
          .add(CreateTodoItemEvent(todoItem: todoItem));
    } else {
      setState(() {
        isErrorMessage = true;
      });
    }
  }

  void editTodoItem(BuildContext context) {
    if (fieldVerification(value: taskTitleController.text)) {
      widget.todoItem.title = taskTitleController.text;
      widget.addTaskCallback(widget.todoItem);
      BlocProvider.of<TodoItemBloc>(context)
          .add(EditTodoItemEvent(widget.todoItem));
    } else {
      setState(() {
        isErrorMessage = true;
      });
    }
  }

  void hideError() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        this.isErrorMessage = false;
      });
    });
  }

  Widget datePicker() {
    return AnimatedBuilder(
      animation: _calendarAnimationController,
      builder: (BuildContext context, _) {
        return ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: _datePickerAnimation.value * 400),
          child: SingleChildScrollView(
            child: TableCalendar(
              calendarController: _calendarController,
              onDaySelected: (DateTime date, List events, List events2) {
                setState(() {
                  widget.todoItem.due = date;
                });
              },
            ),
          ),
        );
      },
    );
  }
}

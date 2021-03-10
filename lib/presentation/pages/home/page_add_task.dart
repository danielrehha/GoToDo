import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gotodo/core/utils/translate_date.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_button.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:table_calendar/table_calendar.dart';

typedef AddTaskCallback = void Function(TodoItem todoItem);

class AddTaskPage extends StatefulWidget {
  final AddTaskCallback addTaskCallback;

  const AddTaskPage({Key key, @required this.addTaskCallback})
      : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage>
    with SingleTickerProviderStateMixin {
  TodoItemModel todoItem;

  TextEditingController taskTitleController;
  CalendarController _calendarController;

  AnimationController _calendarAnimationController;
  Animation<double> _datePickerAnimation;

  bool isDatePickerOpened = false;

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
                  Text(
                    'Create task',
                    style: AppTheme.textStyle_h3_black,
                  ),
                  Icon(
                    Icons.cancel,
                    color: Colors.transparent,
                    size: AppTheme.iconSize,
                  ),
                ],
              ),
              SizedBox(
                height: 8,
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
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
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
                          date: todoItem.due,
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
                  todoItem.title = taskTitleController.text;
                  widget.addTaskCallback(todoItem);
                  Navigator.pop(context);
                },
                label: 'Add task',
                labelStyle: AppTheme.textStyle_h3_white,
              ),
            ],
          ),
        ),
      ),
    );
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
                  todoItem.due = date;
                });
              },
            ),
          ),
        );
      },
    );
  }
}

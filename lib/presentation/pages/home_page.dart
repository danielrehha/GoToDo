import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/core/utils/format_date.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/development_cache.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:gotodo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:gotodo/presentation/theme/custom_theme.dart';
import 'package:gotodo/presentation/widgets/todo_item_widget.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TextEditingController _addTodoItemController;
  ScrollController _scrollController = ScrollController();

  bool isLoading = true;
  bool isAdding = false;

  DateTime _newItemSelectedDate;

  @override
  void initState() {
    super.initState();
    _addTodoItemController = TextEditingController();
    //loadTodoItems();
  }

/*   void loadTodoItems() async {
    todoItems = await DevelopmentCache.todoItems();
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      print('Loaded: ${todoItems[0].title}');
      isLoading = false;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: CustomTheme.bg_color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black12)],
                  color: Colors.white),
              child: SafeArea(
                bottom: false,
                left: false,
                right: false,
                child: Padding(
                    padding: CustomTheme.bezelPaddingAll,
                    child: headerWidget()),
              ),
            ),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoInitial) {
                    BlocProvider.of<TodoBloc>(context)
                        .add(FetchTodoItems(userId: 'id'));
                  }

                  if (state is TodoLoading) {
                    return SpinKitCircle(
                      key: UniqueKey(),
                      color: CustomTheme.accent_body_main,
                      size: 32,
                    );
                  }

                  if (state is TodoLoaded) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: CustomTheme.bezelPaddingAll,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: buildItemsList(state.todoItems),
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is TodoError) {
                    return Center(
                      child: Text('Error loading To Do feed :/'),
                    );
                  }

                  return SpinKitCircle(
                    key: UniqueKey(),
                    color: CustomTheme.accent_body_main,
                    size: 32,
                  );
                },
              ),
            ),
            Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 2, color: Colors.black12)
                ], color: Colors.white),
                child: SafeArea(
                    top: false,
                    child: Padding(
                        padding: CustomTheme.bezelPaddingAll,
                        child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 50),
                            child: isAdding
                                ? addTodoItemField()
                                : bottomNavigationBar()))))
          ],
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Row(
      children: [
        Text(
          'Todo Manager',
          style: CustomTheme.h1,
        ),
        Spacer(),
        Icon(
          Icons.logout,
          color: CustomTheme.accent_body_main,
        )
      ],
    );
  }

  Widget buildItemsList(List<TodoItem> todoItems) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: todoItems.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return TodoItemWidget(todoItem: todoItems[index]);
      },
    );
  }

  Widget addTodoItemField() {
    return Column(
      children: [
        TextField(
          controller: _addTodoItemController,
          decoration: InputDecoration(
              hintText: 'e.g. Learn Portuguese every 2 days #Learning',
              border: InputBorder.none),
          style: CustomTheme.bodyText,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 6),
          child: InkWell(
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                ),
                Text(FormatDate.date1(
                  date: _newItemSelectedDate ?? DateTime.now(),
                ))
              ],
            ),
            onTap: () {
              DatePicker.showDatePicker(
                context,
                minTime: DateTime.now(),
                currentTime: _newItemSelectedDate ?? DateTime.now(),
                locale: LocaleType.en,
                onConfirm: (DateTime value) {
                  setState(() {
                    _newItemSelectedDate = value;
                  });
                },
              );
            },
          ),
        ),
        Row(
          children: [
            InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Add task',
                      style: CustomTheme.buttonTextAccent,
                    ),
                  ),
                ),
                onTap: () {
                  addNewTodoItem(
                      _addTodoItemController.text, _newItemSelectedDate);
                  isAdding = false;
                  _addTodoItemController.text = '';
                }),
            SizedBox(
              width: 8,
            ),
            InkWell(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Cancel',
                  style: CustomTheme.buttonText,
                ),
              ),
              onTap: () {
                setState(() {
                  isAdding = !isAdding;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget bottomNavigationBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: Icon(
            Icons.add,
            color: CustomTheme.accent_body_main,
          ),
          onTap: () {
            setState(() {
              isAdding = !isAdding;
            });
          },
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.person_outline_outlined,
          color: Colors.red,
        )
      ],
    );
  }

  void addNewTodoItem(String title, DateTime due) {
    TodoItemModel todoItem = TodoItemModel(
      id: 0,
      userId: 'id',
      title: title,
      due: due,
      done: false,
    );
/*     setState(() {
      todoItems.add(todoItem);
    }); */
    scrollToBottom();
  }

  void scrollToBottom() {
    var scrollPosition = _scrollController.position;
    _scrollController.animateTo(
      scrollPosition.maxScrollExtent,
      duration: Duration(milliseconds: 100),
      curve: Curves.ease,
    );
  }
}

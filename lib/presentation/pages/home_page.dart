import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/core/utils/format_date.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/development_cache.dart';
import 'package:gotodo/presentation/theme/custom_theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TextEditingController _addTodoItemController;
  AnimationController _animationController;

  List<TodoItemModel> todoItems;

  bool isLoading = true;
  bool isAdding = false;

  @override
  void initState() {
    super.initState();
    _addTodoItemController = TextEditingController();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    loadTodoItems();
  }

  void loadTodoItems() async {
    todoItems = await DevelopmentCache.todoItems();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      print('Loaded: ${todoItems[0].title}');
      isLoading = false;
    });
  }

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
              child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: isLoading
                      ? SpinKitCircle(
                          key: UniqueKey(),
                          color: CustomTheme.accent_body_main,
                          size: 32,
                        )
                      : Align(
                          alignment: Alignment.topCenter,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: CustomTheme.bezelPaddingAll,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                removeBottom: true,
                                child: buildItemsList(),
                              ),
                            ),
                          ),
                        )),
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

  Widget buildItemsList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: todoItems.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return todoWidget(todoItems[index]);
      },
    );
  }

  Widget todoWidget(TodoItemModel todoItem) {
    FormatDate formatDate = FormatDate(todoItem.due);
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
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: CustomTheme.accent_body_main,
                    size: 16,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    formatDate.date,
                    style: CustomTheme.bodyTextAccent,
                  )
                ],
              )
            ],
          ),
        ),
      ),
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
                  addNewTodoItem(_addTodoItemController.text, DateTime.now());
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
    TodoItemModel todoItem = TodoItemModel(title: title, due: due, done: false);
    setState(() {
      todoItems.add(todoItem);
    });
  }
}

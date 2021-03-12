import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:gotodo/fixtures/fixture.dart';
import 'package:gotodo/presentation/pages/home/page_add_task.dart';
import 'package:gotodo/presentation/pages/home/page_profile.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_task.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoItemModel> todoItems = [];
  List<TodoItemModel> unfinishedTodoItems = [];
  List<TodoItemModel> completedTodoItems = [];
  final GlobalKey<AnimatedListState> _unfinishedTodoListKey =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _completedTodoListKey =
      GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    loadItemsFromCache();
  }

  void addItem(TodoItem todoItem) {
    unfinishedTodoItems.add(todoItem);

    var insertIndex = unfinishedTodoItems.length - 1;
    _unfinishedTodoListKey.currentState.insertItem(insertIndex);
  }

  void loadItemsFromCache() async {
    final cache = jsonDecode(await fixture('todos.json'));
    int unfinishedIndex = 0;
    int completedIndex = 0;
    for (var item in cache) {
      final todoItem = TodoItemModel.fromJson(json: item);
      if (todoItem.done) {
        completedTodoItems.add(todoItem);
        _completedTodoListKey.currentState.insertItem(completedIndex);
        completedIndex += 1;
      } else {
        unfinishedTodoItems.add(todoItem);
        _unfinishedTodoListKey.currentState.insertItem(unfinishedIndex);
        unfinishedIndex += 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('todo_mockup.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: AppTheme.bezelPaddingAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Icon(
                            Feather.menu,
                            size: AppTheme.iconSize,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: ProfilePage(),
                              ),
                            );
                          },
                        ),
                        InkWell(
                          child: Icon(
                            Feather.plus,
                            size: AppTheme.iconSize,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: AddTaskPage(
                                  addTaskCallback: (TodoItem todoItem) {
                                    addItem(todoItem);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Text('Tasks'),
                            buildUnfinishedTodoList(),
                            Text('Completed'),
                            buildCompletedTodoList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUnfinishedTodoList() {
    return AnimatedList(
      key: _unfinishedTodoListKey,
      shrinkWrap: true,
      initialItemCount: unfinishedTodoItems.length,
      itemBuilder: (context, index, animation) {
        return buildItem(
          todoItem: unfinishedTodoItems[index],
          index: index,
          animation: animation,
        );
      },
    );
  }

  Widget buildCompletedTodoList() {
    return AnimatedList(
      key: _completedTodoListKey,
      shrinkWrap: true,
      initialItemCount: completedTodoItems.length,
      itemBuilder: (context, index, animation) {
        return buildItem(
          todoItem: completedTodoItems[index],
          index: index,
          animation: animation,
        );
      },
    );
  }

  Tween<Offset> _offset = Tween(begin: Offset(1, 0), end: Offset(0, 0));

  Widget buildItem(
      {@required TodoItem todoItem,
      @required int index,
      @required Animation<double> animation,
      Function onPressed}) {
    return SlideTransition(
      position: animation.drive(_offset),
      child: TaskRowWidget(
        todoItem: todoItem,
        animation: animation,
        onTodoCompleted: (TodoItem todoItem, bool success) {
          if (success) {
            toggleItem(todoItem: todoItem);
          }
        },
      ),
    );
  }

  int itemInsertDuration = 50;

  void toggleItem({@required TodoItem todoItem}) {
    if (todoItem.done) {
      print('its done');
      //remove item from completed list
      int index = completedTodoItems.indexOf(todoItem);
      completedTodoItems.removeWhere(
          (i) => (i.title == todoItem.title && i.due == todoItem.due));

      _completedTodoListKey.currentState.removeItem(
          index,
          (context, animation) =>
              buildItem(todoItem: todoItem, index: index, animation: animation),
          duration: Duration(milliseconds: itemInsertDuration));

      //add item to unfinished list
      unfinishedTodoItems.add(todoItem);

      var insertIndex = unfinishedTodoItems.length - 1;
      _unfinishedTodoListKey.currentState.insertItem(insertIndex);
    } else {
      print('its unfinished');
      int index = unfinishedTodoItems.indexOf(todoItem);
      unfinishedTodoItems.removeWhere(
          (i) => (i.title == todoItem.title && i.due == todoItem.due));

      _unfinishedTodoListKey.currentState.removeItem(
          index,
          (context, animation) =>
              buildItem(todoItem: todoItem, index: index, animation: animation),
          duration: Duration(milliseconds: itemInsertDuration));

      //add item to unfinished list
      completedTodoItems.add(todoItem);

      var insertIndex = completedTodoItems.length - 1;
      _completedTodoListKey.currentState.insertItem(insertIndex);
    }
  }
}

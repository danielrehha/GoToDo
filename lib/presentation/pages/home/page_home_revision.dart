import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:gotodo/fixtures/fixture.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_list/todo_bloc.dart';
import 'package:gotodo/presentation/pages/home/page_add_task.dart';
import 'package:gotodo/presentation/pages/home/page_profile.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_task.dart';
import 'package:page_transition/page_transition.dart';

class HomePageRevision extends StatefulWidget {
  const HomePageRevision({Key key}) : super(key: key);

  @override
  _HomePageRevisionState createState() => _HomePageRevisionState();
}

class _HomePageRevisionState extends State<HomePageRevision> {
  List<TodoItemModel> todoItems = List<TodoItemModel>();
  final GlobalKey<AnimatedListState> _todoListKey =
      GlobalKey<AnimatedListState>();

  Duration _itemInsertDuration = Duration(milliseconds: 100);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void insertItemsInState({@required List<TodoItemModel> todoItemsFromState}) {
    todoItemsFromState.forEach((item) {
      todoItems.add(item);
    });

    Future ft = Future(() {});

    ft.then((_) {
      Future.delayed(Duration(milliseconds: 100));
      todoItemsFromState.forEach((item) {
        //_todoListKey.currentState.insertItem()
      });
    });
  }

  void addSingleItem(TodoItem todoItem) {
    todoItems.add(todoItem);

    print('list length: ${todoItems.length}');

    Future ft = Future(() {});

    ft.then((_) {
      Future.delayed(Duration(milliseconds: 50));
      _todoListKey.currentState.insertItem(todoItems.length - 1);
    });
  }

  int newItemId() {
    int id = 0;
    for (var item in todoItems) {
      if (item.id > id) {
        id = item.id;
      }
    }
    return id + 1;
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
                                    todoItem.id = newItemId();
                                    addSingleItem(todoItem);
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
                      child: BlocBuilder<TodoBloc, TodoState>(
                        builder: (context, state) {
                          if (state is TodoInitial) {
                            BlocProvider.of<TodoBloc>(context)
                                .add(FetchTodoItems(userId: 'id'));
                          }

                          if (state is TodoLoading) {
                            return SpinKitCircle(
                              key: UniqueKey(),
                              color: AppTheme.color_accent_2,
                              size: 32,
                            );
                          }

                          if (state is TodoLoaded) {
                            insertItemsInState(
                                todoItemsFromState: state.todoItems);
                            return Align(
                              alignment: Alignment.topCenter,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                physics: BouncingScrollPhysics(),
                                child: Padding(
                                  padding: AppTheme.bezelPaddingAll,
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: buildTodoList(
                                      todoItemsFromState: state.todoItems,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          if (state is TodoError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 36,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('Uh oh, something went wrong!'),
                                ],
                              ),
                            );
                          }

                          return SpinKitCircle(
                            key: UniqueKey(),
                            color: AppTheme.color_accent_2,
                            size: 32,
                          );
                        },
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

  Widget buildTodoList({@required List<TodoItemModel> todoItemsFromState}) {
    return AnimatedList(
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
      key: _todoListKey,
      shrinkWrap: true,
      initialItemCount: todoItems.length,
      itemBuilder: (context, index, animation) {
        return buildItem(
          todoItem: todoItems[index],
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
      position: animation.drive(_offset.chain(CurveTween(curve: Curves.ease))),
      child: TaskRowWidget(
        todoItem: todoItem,
        animation: animation,
        onTodoCompleted: (TodoItem todoItem) {
          completeTask(todoItem: todoItem);
        },
      ),
    );
  }

  void completeTask({@required TodoItem todoItem}) {
    int index = todoItems.indexOf(todoItem);

    _todoListKey.currentState.removeItem(
      index,
      (BuildContext context, Animation animation) {
        return buildItem(
            todoItem: todoItem,
            animation: animation,
            index: index,
            onPressed: () {});
      },
    );

    todoItems.removeWhere((item) => item.id == todoItem.id);
    print('removing item at #$index');
  }
}

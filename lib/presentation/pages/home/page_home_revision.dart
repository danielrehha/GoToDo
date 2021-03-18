import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/core/providers/user_provider/user_provider.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:gotodo/presentation/bloc/bloc_firebase_user/firebase_user_bloc.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_list/todolist_bloc.dart';
import 'package:gotodo/presentation/pages/home/page_add_task.dart';
import 'package:gotodo/presentation/pages/home/page_profile.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_task.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePageRevision extends StatefulWidget {
  const HomePageRevision({Key key}) : super(key: key);

  @override
  _HomePageRevisionState createState() => _HomePageRevisionState();
}

class _HomePageRevisionState extends State<HomePageRevision>
    with SingleTickerProviderStateMixin {
  List<TodoItemModel> todoItems = <TodoItemModel>[];
  final GlobalKey<AnimatedListState> _todoListKey =
      GlobalKey<AnimatedListState>();

  Duration _itemInsertDuration = Duration(milliseconds: 100);
  final ScrollController _scrollController = ScrollController();

  Tween<Offset> _offset = Tween(begin: Offset(1, 0), end: Offset(0, 0));
  AnimationController _animationController;
  TweenSequence<Offset> _slideOutAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideOutAnimation = TweenSequence([
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
          begin: Offset(0, 0),
          end: Offset(0, 0),
        ),
        weight: 50,
      ),
    ]);
  }

  void insertItemsInState({@required List<TodoItemModel> todoItemsFromState}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      int index = 0;
      todoItemsFromState.forEach((item) {
        todoItems.add(item);
        _todoListKey.currentState.insertItem(index);
        index += 1;
      });
      await Future.delayed(Duration(milliseconds: 50));
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

  String getUserId(BuildContext context) {
    String userId = Provider.of<UserProvider>(context).firebaseUser.uid;
    print(userId);
    return userId;
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
                            print('initial');
                            BlocProvider.of<TodoBloc>(context).add(
                                FetchTodoItems(userId: getUserId(context)));
                          }

                          if (state is TodoLoading) {
                            print('loading');
                            return SpinKitCircle(
                              key: UniqueKey(),
                              color: AppTheme.color_accent_2,
                              size: 32,
                            );
                          }

                          if (state is TodoLoaded) {
                            if (todoItems.isEmpty) {
                              insertItemsInState(
                                  todoItemsFromState: state.todoItems);
                            }
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
                            print('error');
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

  Widget buildTodoList({
    @required List<TodoItemModel> todoItemsFromState,
  }) {
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
            context: context,
            onPressed: () async {
              await Future.delayed(Duration(milliseconds: 100));
              completeTask(
                todoItem: todoItems[index],
              );
            });
      },
    );
  }

  Widget buildItem({
    @required TodoItem todoItem,
    @required int index,
    @required Animation<double> animation,
    Function onPressed,
    @required BuildContext context,
  }) {
    return SlideTransition(
      position: animation.drive(_offset.chain(CurveTween(
        curve: Curves.bounceInOut,
      ))),
      child: TaskRowWidget(
        todoItem: todoItem,
        animation: animation,
        onTodoCompleted: (TodoItem todoItem, bool success) async {
          onPressed();
        },
      ),
    );
  }

  void completeTask({@required TodoItem todoItem}) {
    TodoItem to_be_deleted = todoItem;
    to_be_deleted.done = false;
    int index = todoItems.indexOf(to_be_deleted);

    //For extra safety measure
    if (index >= 0) {
      _todoListKey.currentState.removeItem(
        index,
        (BuildContext context, Animation animation) {
          return buildItem(
            todoItem: todoItem,
            animation: animation,
            index: index,
            onPressed: () {},
            context: context,
          );
        },
      );
    }

    todoItems.removeWhere((item) => item.id == todoItem.id);
    print('removing item at #$index');
    print('new list length: ${todoItems.length}');
  }
}

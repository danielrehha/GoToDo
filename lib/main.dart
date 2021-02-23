import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gotodo/data/datasources/remote_data_source.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:gotodo/entry_widget.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(EntryWidget(
    todoItemRepository: TodoItemRepository(
      remoteDataSource: ApiService(),
    ),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

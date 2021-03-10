part of 'todoitembloc_bloc.dart';

abstract class TodoitemblocState extends Equatable {
  const TodoitemblocState();
  
  @override
  List<Object> get props => [];
}

class TodoitemblocInitial extends TodoitemblocState {}

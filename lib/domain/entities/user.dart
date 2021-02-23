import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  String userId;
  String username;
  
  User({
    @required this.userId,
    @required this.username,
  });

  @override
  List<Object> get props => [userId, username];
}

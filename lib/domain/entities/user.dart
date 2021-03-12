import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  String userId;
  String username;
  
  UserEntity({
    @required this.userId,
    @required this.username,
  });

  @override
  List<Object> get props => [userId, username];
}

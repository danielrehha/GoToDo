import 'package:gotodo/domain/entities/user.dart';
import 'package:meta/meta.dart';

class UserModel extends User {
  UserModel({@required String userId, @required String username})
      : super(userId: userId, username: username);

  UserModel.fromJson(Map<String, dynamic> json) {
    this.userId = json['userId'];
    this.username = json['username'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'username': this.username,
    };
  }
}

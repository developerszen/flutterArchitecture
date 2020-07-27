import 'dart:async';
import 'package:arch_flutter/data/user.dart';

class Repository {

    Future<User> getUser() async {
        await Future.delayed(Duration(seconds: 2));
        return User(name: 'Jefer', surname: 'Smith');
    }
    
}

import 'dart:async';

import 'package:rxdart/rxdart.dart';


class CheckBoxStateBloc {
  StreamController checkController = BehaviorSubject();

  Stream get checkStatus => checkController.stream;

  void setCheck(bool check) {
    checkController.sink.add(check);
  }

  void dispose() {
    checkController.close();
  }
}

final checkTutorial = CheckBoxStateBloc();
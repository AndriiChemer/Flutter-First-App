import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'state_provider.dart';

class StateBloc {
  StreamController animationController = BehaviorSubject();
  final StateProvider provider = StateProvider();

  Stream get animationStatus => animationController.stream;

  void toggleAnimation() {
    provider.toggleAnimationValue();
    animationController.sink.add(provider.isAnimating);
  }

  void revertAnimation() {
    provider.isAnimating = true;
    animationController.sink.add(provider.isAnimating);
  }

  void dispose() {
    animationController.close();
  }
}

final stateBloc = StateBloc();
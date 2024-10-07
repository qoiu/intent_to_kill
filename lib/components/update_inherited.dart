import 'package:flutter/material.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class MainUpdateWidget extends InheritedWidget {
  final Function(VoidCallback fn) _setState;

  const MainUpdateWidget(
      {super.key,
      required super.child,
      required Function(VoidCallback fn) setState})
      : _setState = setState;

  update() {
    _setState(() {});
  }

  static MainUpdateWidget of(BuildContext context) {
    final MainUpdateWidget? result =
        context.dependOnInheritedWidgetOfExactType<MainUpdateWidget>();
    assert(result != null, 'No ChatInherit found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class UpdateController {
  VoidCallback _update = () {};

  subscribe(VoidCallback update) {
    _update = update;
  }

  dispose() {
    'dispose update controller'.dpRed().print();
  _update = dispose;
}

  update() => _update();
}

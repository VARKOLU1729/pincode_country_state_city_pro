import 'package:flutter/material.dart';

class AlwaysNotifyNotifier<T> extends ValueNotifier<T?> {
  AlwaysNotifyNotifier(super.value);

  @override
  set value(T? newValue) {
    super.value = newValue;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SuggestionsController<T> extends ChangeNotifier {
  List<T>? _suggestions;
  List<T>? get suggestions => _suggestions == null ? null : List.of(_suggestions!);
  set suggestions(List<T>? value) {
    if (value != null) {
      value = List.of(value);
    }
    _suggestions = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }
}

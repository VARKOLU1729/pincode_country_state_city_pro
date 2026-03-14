import 'dart:async';

import 'package:flutter/material.dart';

typedef SuggestionsCallback<T> = FutureOr<List<T>?> Function(String search);

typedef SuggestionsItemBuilder<T> = Widget Function(
  BuildContext context,
  T value,
);

typedef DecorationBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

typedef TextFieldBuilder = Widget Function(
  BuildContext context,
  TextEditingController controller,
  FocusNode focusNode,
);

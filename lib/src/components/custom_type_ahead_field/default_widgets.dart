import 'package:flutter/material.dart';

abstract final class CustomTypeAheadDefaults {
  static Widget loadingBuilder(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 20,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static Widget emptyBuilder(BuildContext context) {
    return decorationBuilder(
        context,
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text('No items found!', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        ));
  }

  /// The default decoration builder used by CustomTypeAheadField.
  static Widget decorationBuilder(
    BuildContext context,
    Widget child,
  ) {
    return Material(
      type: MaterialType.card,
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }

  static Widget textFieldBuilder(
    BuildContext context,
    TextEditingController controller,
    FocusNode node,
  ) {
    return TextField(
      controller: controller,
      focusNode: node,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/src/components/custom_type_ahead_field/suggestions_controller.dart';
import 'package:pincode_country_state_city_pro/src/components/custom_type_ahead_field/typeahead_types.dart';

class SuggestionsOverlay<T> extends StatefulWidget {
  final SuggestionsItemBuilder<T> suggestionsItemBuilder;
  final TextEditingController searchQueryController;
  final SuggestionsController<T> suggestionsController;
  final SuggestionsCallback<T> suggestionsCallback;
  const SuggestionsOverlay({
    super.key,
    required this.suggestionsItemBuilder,
    required this.searchQueryController,
    required this.suggestionsController,
    required this.suggestionsCallback,
  });

  @override
  State<SuggestionsOverlay<T>> createState() => _SuggestionsOverlayState<T>();
}

class _SuggestionsOverlayState<T> extends State<SuggestionsOverlay<T>> {
  final OverlayPortalController overlayPortalController = OverlayPortalController();
  late TextEditingController _searchQueryController;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _searchQueryController = widget.searchQueryController;
    _searchQueryController.addListener(() async {
      if (_searchQueryController.text.isNotEmpty) {
        overlayPortalController.show();
        await load(_searchQueryController.text);
      } else {
        overlayPortalController.hide();
      }
    });
  }

  Future<void> load(String query) async {
    widget.suggestionsController.isLoading = true;
    widget.suggestionsController.suggestions = await widget.suggestionsCallback(query);
    widget.suggestionsController.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.suggestionsController,
        builder: (context, _) {
          final suggestions = widget.suggestionsController.suggestions ?? [];
          return OverlayPortal(
            controller: overlayPortalController,
            overlayChildBuilder: (context) {
              return Align(
                alignment: Alignment.topLeft,
                child: CompositedTransformFollower(
                  offset: const Offset(0, 100),
                  link: _layerLink,
                  child: Container(
                    color: Colors.red,
                    child: Text("${suggestions.length}"),
                  ),
                  // child: widget.suggestionsController.isLoading
                  //     ? Container(
                  //         height: 40,
                  //         color: Colors.grey,
                  //         child: CircularProgressIndicator(
                  //           color: Colors.red,
                  //         ),
                  //       )
                  //     : ListView.builder(
                  //         itemCount: suggestions.length,
                  //         itemBuilder: (context, index) {
                  //           return widget.suggestionsItemBuilder(context, suggestions[index]);
                  //         }),
                ),
              );
            },
            child: CompositedTransformTarget(
              link: _layerLink,
              child: TextFormField(
                controller: _searchQueryController,
              ),
            ),
          );
        });
  }
}

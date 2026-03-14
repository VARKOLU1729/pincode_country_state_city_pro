import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/src/components/custom_type_ahead_field/debouncer.dart';
import 'package:pincode_country_state_city_pro/src/components/custom_type_ahead_field/default_widgets.dart';
import 'package:pincode_country_state_city_pro/src/components/custom_type_ahead_field/suggestions_controller.dart';
import 'package:pincode_country_state_city_pro/src/components/custom_type_ahead_field/typeahead_types.dart';

class CustomDropDownTypeAheadSearch<T> extends StatefulWidget {
  const CustomDropDownTypeAheadSearch({
    super.key,
    this.searchQueryController,
    this.suggestionsController,
    required this.suggestionsCallback,
    required this.suggestionsItemBuilder,
    Widget Function(BuildContext)? emptyBuilder,
    Widget Function(BuildContext)? loadingBuilder,
    DecorationBuilder? decorationBuilder,
    TextFieldBuilder? textFieldBuilder,
    required this.constraints,
    this.focusNode,
    this.suggestionsScrollController,
    this.debounceDuration = const Duration(milliseconds: 300),
    required this.onSelected,
    this.offset,
    this.shouldFollowTargetWidth = true,
    this.minQueryLength = 0,
  })  : emptyBuilder = emptyBuilder ?? CustomTypeAheadDefaults.emptyBuilder,
        loadingBuilder = loadingBuilder ?? CustomTypeAheadDefaults.loadingBuilder,
        decorationBuilder = decorationBuilder ?? CustomTypeAheadDefaults.decorationBuilder,
        textFieldBuilder = textFieldBuilder ?? CustomTypeAheadDefaults.textFieldBuilder;

  /// Controller for the search text field.
  final TextEditingController? searchQueryController;

  /// Controls loading state and items of the suggestions overlay.
  final SuggestionsController<T>? suggestionsController;

  /// Called on each text input change to fetch matching suggestions.
  final SuggestionsCallback<T> suggestionsCallback;

  /// Builds the widget to display each suggestion item.
  final SuggestionsItemBuilder<T> suggestionsItemBuilder;

  /// Widget shown when there are no suggestions to display.
  final Widget Function(BuildContext)? emptyBuilder;

  /// Widget shown while suggestions are being loaded.
  final Widget Function(BuildContext)? loadingBuilder;

  /// Decoration that wraps around the suggestions box.
  final DecorationBuilder? decorationBuilder;

  /// Builds the field that will be used to search for the suggestions.
  final TextFieldBuilder? textFieldBuilder;

  /// The focus node of the child.
  /// This is used to show and hide the suggestions box.
  final FocusNode? focusNode;

  /// The constraints to be applied to the suggestions box.
  final BoxConstraints constraints;

  ///scrollController of suggestionsListView
  final ScrollController? suggestionsScrollController;

  /// Time delay before triggering [suggestionsCallback] after user input.
  final Duration debounceDuration;

  /// Called when a suggestion item is tapped.
  final void Function(BuildContext context, T) onSelected;

  /// The offset of the suggestions box.
  /// Defaults to Offset(0,60).
  final Offset? offset;

  /// If true, the suggestions box will follow the width of the target text field.
  /// If true, the **width** in [constraints] will be ignored.
  /// Defaults to true.
  final bool shouldFollowTargetWidth;

  ///The minimum search query length after which [suggestionsCallback] is called and suggestions will be shown
  final int minQueryLength;

  @override
  State<CustomDropDownTypeAheadSearch<T>> createState() => _CustomDropDownTypeAheadSearchState<T>();
}

class _CustomDropDownTypeAheadSearchState<T> extends State<CustomDropDownTypeAheadSearch<T>> {
  final OverlayPortalController overlayPortalController = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();
  late SuggestionsController suggestionsController;
  late TextEditingController searchQueryController;
  late FocusNode focusNode;
  late ScrollController suggestionsScrollController;
  late Debouncer debouncer;
  late Offset offset;

  @override
  void initState() {
    super.initState();
    suggestionsController = widget.suggestionsController ?? SuggestionsController();
    focusNode = widget.focusNode ?? FocusNode();
    searchQueryController = widget.searchQueryController ?? TextEditingController();
    suggestionsScrollController = widget.suggestionsScrollController ?? ScrollController();
    debouncer = Debouncer(milliseconds: widget.debounceDuration.inMilliseconds);
    offset = widget.offset ?? const Offset(0, 60);

    searchQueryController.addListener(() async {
      debouncer.run(
        () async {
          if (searchQueryController.text.length >= widget.minQueryLength) {
            if (focusNode.hasFocus) {
              overlayPortalController.show();
            }
            await load(searchQueryController.text);
          } else {
            overlayPortalController.hide();
          }
        },
      );
    });

    // Show overlay only when the text field is focused and has input; hide it otherwise.
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        overlayPortalController.hide();
      } else {
        if (searchQueryController.text.isNotEmpty) overlayPortalController.show();
      }
    });
  }

  Future<void> load(String query) async {
    suggestionsController.isLoading = true;
    suggestionsController.suggestions = await widget.suggestionsCallback(query);
    suggestionsController.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: suggestionsController,
      builder: (context, Widget? child) {
        final suggestions = suggestionsController.suggestions ?? [];

        child = CompositedTransformTarget(
          link: _layerLink,
          child: widget.textFieldBuilder!(
            context,
            searchQueryController,
            focusNode,
          ),
        );

        return OverlayPortal(
          controller: overlayPortalController,
          child: child,
          overlayChildBuilder: (context) {
            Size? targetSize = _layerLink.leaderSize;

            final Widget suggestionListBuilder = Scrollbar(
              interactive: false,
              controller: suggestionsScrollController,
              child: ListView.builder(
                controller: suggestionsScrollController,
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      widget.onSelected(context, suggestions[index]);
                    },
                    child: widget.suggestionsItemBuilder(context, suggestions[index]),
                  );
                },
              ),
            );

            return Align(
              alignment: Alignment.topLeft,
              child: CompositedTransformFollower(
                offset: offset,
                link: _layerLink,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: widget.constraints.maxHeight,
                    minWidth: widget.shouldFollowTargetWidth ? (targetSize?.width ?? widget.constraints.minWidth) : widget.constraints.minWidth,
                    minHeight: widget.constraints.minHeight,
                    maxWidth: widget.shouldFollowTargetWidth ? (targetSize?.width ?? widget.constraints.maxWidth) : widget.constraints.maxWidth,
                  ),
                  child: TextFieldTapRegion(
                    child: widget.decorationBuilder!(
                      context,
                      suggestionsController.isLoading
                          ? widget.loadingBuilder!(context)
                          : suggestions.isEmpty
                              ? (widget.emptyBuilder!(context))
                              : suggestionListBuilder,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

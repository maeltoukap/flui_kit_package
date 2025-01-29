import 'package:flutter/material.dart';

/// Represents a tag with a unique identifier and label
class Tag {
  final String id;
  final String label;

  Tag({required this.id, required this.label});
}

/// Theme configuration for the tag selector
class TagSelectorTheme {
  /// Background color of the main container
  final Color backgroundColor;

  /// Background color of selected tags
  final Color selectedTagBackground;

  /// Background color of available tags
  final Color availableTagBackground;

  /// Border color
  final Color borderColor;

  /// Text style for tag labels
  final TextStyle labelTextStyle;

  /// Color of the remove icon
  final Color iconColor;

  /// Size of the remove icon
  final double iconSize;

  /// Border radius of containers
  final double borderRadius;

  /// Internal padding of containers
  final EdgeInsets padding;

  /// Duration of animations
  final Duration animationDuration;

  const TagSelectorTheme({
    this.backgroundColor = Colors.white,
    this.selectedTagBackground = Colors.white,
    this.availableTagBackground = const Color(0xFFF5F5F5),
    this.borderColor = const Color(0xFFE0E0E0),
    this.labelTextStyle = const TextStyle(),
    this.iconColor = const Color(0xFF9E9E9E),
    this.iconSize = 20.0,
    this.borderRadius = 50.0,
    this.padding = const EdgeInsets.all(24.0),
    this.animationDuration = const Duration(milliseconds: 300),
  });
}

/// An animated tag selector widget with customizable appearance
class TagSelector extends StatefulWidget {
  /// List of available tags to choose from
  final List<Tag> tags;

  /// Initially selected tags
  final List<Tag> initialSelectedTags;

  /// Optional title for the selector
  final String? title;

  /// Style for the title text
  final TextStyle? titleStyle;

  /// Theme configuration
  final TagSelectorTheme theme;

  /// Maximum width of the container
  final double? maxWidth;

  /// Height of the selected tags area
  final double selectedTagsHeight;

  /// Callback triggered when selection changes
  final void Function(List<Tag>)? onSelectionChanged;

  /// Maximum number of tags that can be selected
  final int? maxSelectedTags;

  /// Callback triggered when the maximum number of tags is reached
  final Function()? onMaxSelectedTagsReached;

  const TagSelector({
    super.key,
    required this.tags,
    this.initialSelectedTags = const [],
    this.title,
    this.titleStyle,
    this.theme = const TagSelectorTheme(),
    this.maxWidth,
    this.selectedTagsHeight = 56,
    this.onSelectionChanged,
    this.maxSelectedTags,
    this.onMaxSelectedTagsReached,
  });

  @override
  _TagSelectorState createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<Tag> selectedTags;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedTags = List.from(widget.initialSelectedTags);
  }

  /// Removes a tag from the selection
  void removeSelectedTag(String id) {
    final index = selectedTags.indexWhere((tag) => tag.id == id);
    if (index != -1) {
      final removedTag = selectedTags[index];
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: _buildSelectedTag(removedTag),
          ),
        ),
        duration: widget.theme.animationDuration,
      );
      setState(() {
        selectedTags.removeAt(index);
        widget.onSelectionChanged?.call(selectedTags);
      });
    }
  }

  /// Adds a new tag to the selection if the maximum limit hasn't been reached
  void addSelectedTag(Tag tag) {
    if (widget.maxSelectedTags != null &&
        selectedTags.length >= widget.maxSelectedTags!) {
      widget.onMaxSelectedTagsReached?.call();
      return;
    }

    setState(() {
      selectedTags.add(tag);
      _listKey.currentState?.insertItem(
        selectedTags.length - 1,
        duration: widget.theme.animationDuration,
      );
      widget.onSelectionChanged?.call(selectedTags);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: widget.theme.animationDuration,
        curve: Curves.easeOut,
      );
    });
  }

  /// Builds a selected tag widget
  Widget _buildSelectedTag(Tag tag) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.theme.borderRadius),
        border: Border.all(color: widget.theme.borderColor),
        color: widget.theme.selectedTagBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            tag.label,
            style: widget.theme.labelTextStyle,
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => removeSelectedTag(tag.id),
            child: Icon(
              Icons.close,
              size: widget.theme.iconSize,
              color: widget.theme.iconColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: widget.theme.padding,
        constraints: BoxConstraints(
          maxWidth: widget.maxWidth ?? MediaQuery.of(context).size.width,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null) ...[
              AnimatedContainer(
                duration: widget.theme.animationDuration,
                child: Text(
                  widget.title!,
                  style: widget.titleStyle ??
                      const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(height: 8),
            ],
            Container(
              height: widget.selectedTagsHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.theme.borderRadius),
                border: Border.all(color: widget.theme.borderColor),
                color: widget.theme.backgroundColor,
              ),
              child: AnimatedList(
                key: _listKey,
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(6),
                initialItemCount: selectedTags.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0),
                      ),
                    ),
                    child: FadeTransition(
                      opacity: animation,
                      child: _buildSelectedTag(selectedTags[index]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            if (widget.tags.length > selectedTags.length)
              AnimatedContainer(
                duration: widget.theme.animationDuration,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(widget.theme.borderRadius),
                  border: Border.all(color: widget.theme.borderColor),
                  color: widget.theme.backgroundColor,
                ),
                padding: const EdgeInsets.all(8),
                child: AnimatedSize(
                  duration: widget.theme.animationDuration,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.tags
                        .where((tag) => !selectedTags
                            .any((selected) => selected.id == tag.id))
                        .map((tag) {
                      return TweenAnimationBuilder(
                        duration: widget.theme.animationDuration,
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Opacity(
                              opacity: value,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => addSelectedTag(tag),
                                  borderRadius: BorderRadius.circular(
                                    widget.theme.borderRadius,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        widget.theme.borderRadius,
                                      ),
                                      color:
                                          widget.theme.availableTagBackground,
                                    ),
                                    child: Text(
                                      tag.label,
                                      style: widget.theme.labelTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

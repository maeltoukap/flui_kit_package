import 'package:flutter/material.dart';
import 'advanced_pagination/controllers/pagination_controller.dart';

/// Defines the type of pagination to be used in the widget
enum PaginationType {
  /// Automatically loads more content when the user scrolls to the bottom of the list
  infiniteScroll,

  /// Adds pagination navigation buttons for moving between pages
  buttons,

  /// Adds pagination button for loading more data
  loadMore
}

// /// Defines how data should be processed when new items are loaded
// enum LoadingBehavior {
//   /// Appends new items to the existing list
//   append,

//   /// Replaces the current list with the new data
//   replace
// }

/// Configuration object for button-based pagination
class PaginationButtonsConfig {
  final Widget? previousPageButton; // Widget for the 'Previous Page' button
  final Widget? nextPageButton; // Widget for the 'Next Page' button
  final Widget? loadMorePageButton; // Widget for the 'Load More' button
  final Widget Function(int current, int total)?
      pageIndicator; // Displays current and total pages
  final EdgeInsets? buttonsPadding; // Padding around the buttons row

  const PaginationButtonsConfig({
    this.previousPageButton,
    this.nextPageButton,
    this.loadMorePageButton,
    this.pageIndicator,
    this.buttonsPadding,
  });
}

/// A widget that implements advanced pagination functionalities (infinite scroll or buttons)
class AdvancedPagination extends StatefulWidget {
  /// Function for building list items
  final Widget Function(BuildContext, int) itemBuilder;

  /// Total number of items the current page contains
  final int itemCount;

  /// Callback function for fetching more data, either for the next or previous page
  final Future<List<dynamic>> Function(bool isNext, int page) onLoadMore;

  /// Determines the type of pagination (infinite scroll or buttons)
  final PaginationType paginationType;

  /// PaginationController for managing pagination states
  final PaginationController controller;

  /// Threshold value that triggers loading new data in infinite scroll
  final double loadTriggerThreshold;

  /// Widget displayed as a loading indicator when data is being fetched
  final Widget? loadingIndicator;

  /// Widget displayed when no data exists in the list
  final Widget? emptyWidget;

  /// Number of items to load per page
  final int itemsPerPage;

  /// Configuration for customizing button-based pagination
  final PaginationButtonsConfig? buttonsConfig;

  const AdvancedPagination({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.onLoadMore,
    required this.controller,
    required this.itemsPerPage,
    this.paginationType = PaginationType.infiniteScroll,
    this.loadTriggerThreshold = 0.8,
    this.loadingIndicator,
    this.emptyWidget,
    this.buttonsConfig,
  }) : super(key: key);

  @override
  _AdvancedPaginationState createState() => _AdvancedPaginationState();
}

/// Manages the state of the AdvancedPagination widget
class _AdvancedPaginationState extends State<AdvancedPagination> {
  final ScrollController _scrollController =
      ScrollController(); // Controls scrolling
  List<dynamic> _items = []; // List holding loaded data items

  @override
  void initState() {
    super.initState();
    if (widget.paginationType == PaginationType.infiniteScroll) {
      _scrollController
          .addListener(_onScroll); // For infinite scroll functionality
    }
    _loadInitialData(); // Load the initial page data
  }

  /// Loads the initial page data
  Future<void> _loadInitialData() async {
    final initialData = await widget.onLoadMore(true, 1); // Load the first page
    setState(() {
      _items = initialData;
    });
  }

  /// Triggered when scrolling occurs
  void _onScroll() {
    if (!widget.controller.isLoading && widget.controller.hasMoreData) {
      final threshold = _scrollController.position.maxScrollExtent *
          widget.loadTriggerThreshold;
      if (_scrollController.position.pixels >= threshold) {
        _handleLoadMore(true); // Load the next page of data
      }
    }
  }

  /// Handles the loading process for fetching more data
  Future<void> _handleLoadMore(bool isNext) async {
    if (widget.controller.isLoading) return;

    widget.controller.startLoading();

    try {
      final targetPage = isNext
          ? widget.controller.currentPage + 1
          : widget.controller.currentPage - 1;

      if (targetPage < 1 || targetPage > widget.controller.totalPages) {
        widget.controller.stopLoading();
        return;
      }

      final newData = await widget.onLoadMore(isNext, targetPage);

      setState(() {
        // if (widget.loadingBehavior == LoadingBehavior.append && isNext) {

        if (isNext) {
          _items = [
            ..._items,
            ...newData
          ]; // Append new data to the current list
        } else {
          _items = newData;
        }
      });
      if (isNext) {
        widget.controller.goToNextPage(); // Increment current page
      } else {
        widget.controller.goToPreviousPage(); // Decrement current page
      }
    } catch (e) {
      debugPrint('Error loading more items: $e');
    } finally {
      widget.controller.stopLoading(); // Mark loading as complete
    }
  }

  /// Widget displaying the loading indicator
  Widget _buildLoadingIndicator() {
    return widget.loadingIndicator ??
        const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        );
  }

  /// Builds button-based pagination UI
  Widget _buildButtonPagination() {
    final config = widget.buttonsConfig;

    return Padding(
      padding: config?.buttonsPadding ?? const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous page button
          InkWell(
            onTap: widget.controller.currentPage > 1
                ? () => _handleLoadMore(false)
                : null,
            child: config?.previousPageButton ??
                Icon(
                  Icons.arrow_back,
                  color: widget.controller.currentPage > 1 ? null : Colors.grey,
                ),
          ),
          // Page indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: config?.pageIndicator?.call(
                  widget.controller.currentPage,
                  widget.controller.totalPages,
                ) ??
                Text(
                    '${widget.controller.currentPage} / ${widget.controller.totalPages}'),
          ),
          // Next page button
          InkWell(
            onTap: widget.controller.hasMoreData
                ? () => _handleLoadMore(true)
                : null,
            child: config?.nextPageButton ??
                Icon(
                  Icons.arrow_forward,
                  color: widget.controller.hasMoreData ? null : Colors.grey,
                ),
          ),
        ],
      ),
    );
  }

  /// Builds load moore button pagination UI
  Widget _buildLoadMoreButtonPagination() {
    final config = widget.buttonsConfig;

    return Padding(
      padding: config?.buttonsPadding ?? const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _handleLoadMore(true),
        child: config?.loadMorePageButton ??
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: Center(child: Text('Load More')),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if the list is empty and an empty state widget is provided
    if (_items.isEmpty && widget.emptyWidget != null) {
      return widget.emptyWidget!;
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _items.length + (widget.controller.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _items.length) {
                return _buildLoadingIndicator(); // Add loading indicator at the bottom
              }
              return widget.itemBuilder(context, index); // List item
            },
          ),
        ),
        if (widget.paginationType == PaginationType.buttons)
          _buildButtonPagination(), // Render buttons for navigation
        if (widget.paginationType == PaginationType.loadMore)
          _buildLoadMoreButtonPagination(), // Render load more button for navigation
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Clean up the scroll controller
    super.dispose();
  }
}

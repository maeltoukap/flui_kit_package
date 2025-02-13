import 'package:flui_kit/flui_kit.dart';
import 'package:flutter/material.dart';

class AdvancedPaginationExample extends StatefulWidget {
  const AdvancedPaginationExample({super.key});

  @override
  _AdvancedPaginationExampleState createState() =>
      _AdvancedPaginationExampleState();
}

class _AdvancedPaginationExampleState extends State<AdvancedPaginationExample> {
  final PaginationController _controller = PaginationController();
  // Images source complète
  final List<String> _allImages = [
    'https://st.depositphotos.com/2001755/3622/i/450/depositphotos_36220949-stock-photo-beautiful-landscape.jpg',
    'https://media.istockphoto.com/id/1381637603/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=w64j3fW8C96CfYo3kbi386rs_sHH_6BGe8lAAAFS-y4=',
    'https://st2.depositphotos.com/1993283/11677/i/450/depositphotos_116778982-stock-photo-mountain-valley-during-sunset.jpg',
    'https://thumbs.dreamstime.com/b/generated-image-woman-backpack-trail-beautiful-alpine-mountain-peaks-colorful-sunset-summer-passo-giau-332601136.jpg',
    'https://thumbs.dreamstime.com/b/enchanting-dolomite-peaks-kelinshektau-mountains-misty-afterthunderstorm-scene-kazakhstans-karatau-massif-witness-349755853.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7krSP38DifWseRVBL1zyfUNsLYuc4WL0Whw&s',
    'https://images.pexels.com/photos/1557652/pexels-photo-1557652.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://media.istockphoto.com/id/520700958/photo/beautiful-flowers-background.jpg?s=612x612&w=0&k=20&c=A7WF8MScj3YNBTA-qFQEKm-Xphzmi_mfaOqjq27--j4=',
  ];
  static const int _itemsPerPage = 4;

  @override
  void initState() {
    super.initState();
    _initializePagination();
  }

  void _initializePagination() {
    final totalPages = (_allImages.length / _itemsPerPage).ceil();
    _controller.updatePaginationInfo(totalPages: totalPages);
  }

  /// Asynchronous function to load a paginated list of images.
  ///
  /// Simulates fetching images for the specified page, using `_allImages` as a data source.
  /// Clamps indices to avoid out-of-bounds errors.
  ///
  /// - [isNext]: Indicates whether the load is for the next page (not used here, but passed for context).
  /// - [page]: The page number to load (starting from 1).
  ///
  /// Returns a `Future<List<String>>` with the image paths or names for the requested page.
  Future<List<String>> _loadImages(bool isNext, int page) async {
    // Simulate a delay for loading (e.g., mimicking an API or database call)
    await Future.delayed(const Duration(milliseconds: 300));

    // Return a clamped sublist of images to avoid index errors
    return _controller.getPaginatedItems(_allImages, page, _itemsPerPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Galerie d'images")),
      body: Column(
        children: [
          Expanded(
            child: AdvancedPagination(
              controller: _controller,
              itemCount: _allImages.length, // Total count of items
              itemsPerPage: _itemsPerPage,
              onLoadMore: _loadImages,
              paginationType: PaginationType.loadMore,
              buttonsConfig: PaginationButtonsConfig(
                previousPageButton: const Text('Previous'),
                nextPageButton: const Text('Next'),
                pageIndicator: (current, total) => Text('$current of $total'),
                buttonsPadding: const EdgeInsets.all(16.0),
              ),
              loadingIndicator: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              itemBuilder: (context, int index) =>
                  Image.network(_allImages[index]),
            ),
          ),
        ],
      ),
    );
  }
}

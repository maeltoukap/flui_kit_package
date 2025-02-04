import 'package:flutter/material.dart';

class PaginationController extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 1;
  int _totalPages = 1;

  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void updatePaginationInfo({required int totalPages}) {
    _totalPages = totalPages;
    _hasMoreData = _currentPage < totalPages;
    notifyListeners();
  }

  void goToNextPage() {
    if (_currentPage < _totalPages) {
      _currentPage++;
      _hasMoreData = _currentPage < _totalPages;
      notifyListeners();
    }
  }

  void goToPreviousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      _hasMoreData = true; // Il y a toujours plus de données quand on recule
      notifyListeners();
    }
  }

  void reset() {
    _currentPage = 1;
    _isLoading = false;
    _hasMoreData = true;
    notifyListeners();
  }

  List<T> getPaginatedItems<T>(List<T> items, int page, int itemsPerPage) {
    final startIndex = (page - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    // Return a clamped sublist to prevent errors
    return items.sublist(
      startIndex.clamp(0, items.length),
      endIndex.clamp(0, items.length),
    );
  }
}

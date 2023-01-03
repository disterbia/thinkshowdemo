import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';

class InfiniteScroll extends StatefulWidget {
  uApiProvider _apiProvider = uApiProvider();

  @override
  _InfiniteScrollState createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  static const _pageSize = 5;

  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // final newItems = await widget._apiProvider.getCharacterList(pageKey, _pageSize);
      final newItems = await widget._apiProvider.getProductsWithCat(categoryId: 1, offset: pageKey, limit: _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        int nextPageKey = int.parse(pageKey.toString() + newItems.length.toString());
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      PagedListView<int, Product>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, product, index) => Text(product.title),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

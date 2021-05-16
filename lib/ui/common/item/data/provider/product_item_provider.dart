import 'package:flutter_shopping_app/ui/common/item/data/model/product_item.dart';
import 'package:flutter_shopping_app/util/mock_util.dart';
import 'package:injectable/injectable.dart';

abstract class ProductItemProvider {
  Future<List<ProductItem>> getTrendingProducts();

  Future<List<ProductItem>> getTopSellingProducts();

  Future<List<ProductItem>> getFeaturedProducts();

  Future<ProductItem> getProductInfo(int id);
}

@Named("mock")
@Singleton(as: ProductItemProvider)
class MockProductItemProvider implements ProductItemProvider {
  const MockProductItemProvider();

  @override
  Future<List<ProductItem>> getTrendingProducts() async {
    //add some delay to give the feel of api call
    await Future.delayed(Duration(seconds: 3));
    final Map _data = MockUtil.getTrendingItems();
    return Future.value(
        (_data['data'] as List)?.map((e) => ProductItem.fromJson(e))?.toList());
  }

  @override
  Future<List<ProductItem>> getFeaturedProducts() async {
    //add some delay to give the feel of api call
    await Future.delayed(Duration(seconds: 3));
    final Map _data = MockUtil.getFeaturedItems();
    return Future.value(
        (_data['data'] as List)?.map((e) => ProductItem.fromJson(e))?.toList());
  }

  @override
  Future<List<ProductItem>> getTopSellingProducts() async {
    //add some delay to give the feel of api call
    await Future.delayed(Duration(seconds: 3));
    final Map _data = MockUtil.getTopSellingItems();
    return Future.value(
        (_data['data'] as List)?.map((e) => ProductItem.fromJson(e))?.toList());
  }

  @override
  Future<ProductItem> getProductInfo(int id) async {
    //add some delay to give the feel of api call
    await Future.delayed(Duration(seconds: 3));
    final List _data = [
      ...MockUtil.getTopSellingItems()['data'],
      ...MockUtil.getFeaturedItems()['data'],
      ...MockUtil.getTrendingItems()['data']
    ];
    final Map _item = _data.firstWhere(
        (el) => el["id"] != null && int.tryParse("${el["id"]}") == id,
        orElse: () => null);
    if (_item == null) throw Exception("Item not found.");
    return ProductItem.fromJson(_item);
  }
}

@Singleton(as: ProductItemProvider)
class RealProductItemProvider implements ProductItemProvider {
  const RealProductItemProvider();

  @override
  Future<List<ProductItem>> getTrendingProducts() async {
    //add some delay to give the feel of api call
    await Future.delayed(Duration(seconds: 3));
    final Map _data = MockUtil.getTrendingItems();
    return Future.value(
        (_data['data'] as List)?.map((e) => ProductItem.fromJson(e))?.toList());
  }

  @override
  Future<List<ProductItem>> getFeaturedProducts() async {
    //add some delay to give the feel of api call
    await Future.delayed(Duration(seconds: 3));
    final Map _data = MockUtil.getFeaturedItems();
    return Future.value(
        (_data['data'] as List)?.map((e) => ProductItem.fromJson(e))?.toList());
  }

  @override
  Future<List<ProductItem>> getTopSellingProducts() async {
    //add some delay to give the feel of api call
    await Future.delayed(Duration(seconds: 3));
    final Map _data = MockUtil.getTopSellingItems();
    return Future.value(
        (_data['data'] as List)?.map((e) => ProductItem.fromJson(e))?.toList());
  }

  @override
  Future<ProductItem> getProductInfo(int id) {
    // TODO: implement getProductInfo
    throw UnimplementedError();
  }
}

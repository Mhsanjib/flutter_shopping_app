import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app/constant/enum.dart';
import 'package:flutter_shopping_app/ui/common/item/data/model/product_item.dart';
import 'package:flutter_shopping_app/ui/common/item/data/repository/product_item_repository.dart';
import 'package:injectable/injectable.dart';

part 'product_item_state.dart';

@injectable
class ProductItemCubit extends Cubit<ProductItemState> {
  final ProductItemRepository _productRepository;

  ProductItemCubit(ProductItemRepository repository,
      {@factoryParam ProductItem product})
      : _productRepository = repository,
        super(ProductItemState.initial());

  void loadProducts({ITEM_TYPE type, appendData: true, int page}) async {
    try {
      //appendData is for appending previous data->lazy loading cases
      //for paged display appendData is false -> paged display
      emit(state.update(
          loading: true,
          pagedItem: appendData
              ? state.pagedItem
              : state.pagedItem.update(data: [], page: page)));
      final int _page = page ?? state.pagedItem.page + 1;
      ProductItemPaged productsPaged =
          await _productRepository.getProductList(_page, type: type);

      final ProductItemPaged _updatedPagedData = productsPaged
          .update(data: [...state.pagedItem.data, ...productsPaged.data]);

      emit(state.update(
          loading: false, pagedItem: _updatedPagedData, init: true));
    } catch (e) {
      final errorMsg = e.toString();
      emit(state.update(loading: false, error: errorMsg));
    }
  }
}

import 'package:beasy/blocs/service_provider/sp_event.dart';
import 'package:beasy/blocs/service_provider/sp_state.dart';
import 'package:beasy/exceptions/app_exceptions.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/repositories/repos/immutable_product_repo.dart';
import 'package:beasy/repositories/repos/mutuble_product_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SPBloc extends Bloc<SPEvent, SPState> {
  SPBloc() : super(SPStateUninitialize()) {
    //  Create Product Event ====================================

    on<SPEventCreateProduct>(
      (event, emit) async {
        try {
          final List<String> imagesUrl = event.model.images;

          // If images are need to updates
          for (String url in imagesUrl) {
            if (!url.contains("https")) {
              final int atIndex = imagesUrl.indexOf(url);

              emit(SPStateUploadingImage(
                  loadingText:
                      "Uploading ${((atIndex / imagesUrl.length) * 100).toInt()}%"));
              final uploadedUrl =
                  await MutableProductRepo().uploadImages(path: url);
              imagesUrl[atIndex] = uploadedUrl;
              emit(SPStateUploadedImage());
            }
          }
          final ProductModel model = event.model.copyWith(images: imagesUrl);
          emit(SPStateCreatingProduct(loadingText: "Creating"));
          await MutableProductRepo().create(productModel: model);
          emit(SPStateCreatedProduct());
        } on AppException catch (e) {
          emit(SPStateCreateProductFailure(exception: e));
        }
      },
    );
    // ===========================Update Product Event================================

    on<SPEventUpdateProduct>((event, emit) async {
      try {
        final List<String> imagesUrl = event.product.images;
        // If images are need to updates
        for (String url in imagesUrl) {
          if (!url.contains("https")) {
            final int atIndex = imagesUrl.indexOf(url);

            emit(SPStateUploadingImage(
                loadingText:
                    "Updating ${((atIndex / imagesUrl.length) * 100).toInt()}%"));
            final uploadedUrl =
                await MutableProductRepo().uploadImages(path: url);
            imagesUrl[atIndex] = uploadedUrl;
            emit(SPStateUploadedImage());
          }
        }

        final ProductModel model = event.product.copyWith(images: imagesUrl);
        emit(SPStateUpdatingProduct(loadingText: "Updating..."));
        await MutableProductRepo().update(productModel: model);
        emit(SPStateUpdatedProduct());
      } on AppException catch (e) {
        debugPrint(e.message);
        emit(SPStateUpdateProductFailure(exception: e));
      }
    });
    // ===========================Fetch Products Event================================
    on<SPEventFetchProducts>(
      (event, emit) async {
        try {
          emit(SPStateFetchingProducts());
          await ImmutableProductRepo().fetchProducts();
          final List<ProductModel> products = ImmutableProductRepo().products;
          emit(SPStateProductsFetched(products: products));
        } on AppException catch (e) {
          debugPrint(e.message);
          emit(SPStateFetchProductsFailure(exception: e));
        }
      },
    );
  }
}

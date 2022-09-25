import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/constants/end_point.dart';
import 'package:shop/data/api/api_serveces.dart';
import 'package:shop/data/model/favorite_model.dart';
import 'package:shop/data/model/home_model.dart';
import 'package:shop/data/model/login_model.dart';
import 'package:shop/view/screens/bottom_nav_screens/categories_screen.dart';
import 'package:shop/view/screens/bottom_nav_screens/favorites_screen.dart';
import 'package:shop/view/screens/bottom_nav_screens/products_screen.dart';
import 'package:shop/view/screens/bottom_nav_screens/settings_screen.dart';

import '../../constants/const.dart';
import '../../data/model/categories.dart';
import '../../data/model/favorite.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  Map<int, bool> favorites = {};

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen()
  ];
  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeData());
    ApiServes.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll({element.id: element.inFavorites});
      }

      emit(ShopSuccessHomeData());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorHomeData());
    });
  }

  void changedScreenInBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNav());
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    ApiServes.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesData());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorCategoriesData());
    });
  }

  FavoriteModelPost? favoriteModelPost;

  void changeFavoriteData(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavorite());
    print(token);
    ApiServes.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      favoriteModelPost = FavoriteModelPost.fromJson(value.data);
      if (favoriteModelPost!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoriteData();
      }

      emit(ShopSuccessFavorite(favoriteModelPost!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorFavorite());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavoriteData() {
    emit(ShopLoadingFavoriteData());
    ApiServes.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessFavoriteData());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorFavoriteData());
    });
  }

  LoginModel? profileUser;

  void getProfileUser() {
    emit(ShopLoadingProfile());
    ApiServes.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileUser = LoginModel.fromJson(value.data);

      emit(ShopSuccessProfile());
    }).catchError((error) {
      emit(ShopErrorProfile());
    });
  }

  void updateProfileUser(
      {required String email, required String name, required String phone}) {
    emit(ShopUpDateLoadingProfile());
    ApiServes.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {'name': name, 'email': email, 'phone': phone},
    ).then((value) {
      profileUser = LoginModel.fromJson(value.data);

      emit(ShopUpDateSuccessProfile());
    }).catchError((error) {
      emit(ShopUpDateErrorProfile());
    });
  }
}

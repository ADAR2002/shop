part of 'shop_cubit.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeBottomNav extends ShopState {}

class ShopLoadingHomeData extends ShopState {}

class ShopSuccessHomeData extends ShopState {}

class ShopErrorHomeData extends ShopState {}

class ShopSuccessCategoriesData extends ShopState {}

class ShopErrorCategoriesData extends ShopState {}

class ShopChangeFavorite extends ShopState {}

class ShopSuccessFavorite extends ShopState {
  final FavoriteModelPost favoriteModel;

  ShopSuccessFavorite(this.favoriteModel);
}

class ShopErrorFavorite extends ShopState {}

class ShopLoadingFavoriteData extends ShopState {}

class ShopSuccessFavoriteData extends ShopState {}

class ShopErrorFavoriteData extends ShopState {}

class ShopLoadingProfile extends ShopState {}

class ShopSuccessProfile extends ShopState {}

class ShopErrorProfile extends ShopState {}

class ShopUpDateLoadingProfile extends ShopState {}

class ShopUpDateSuccessProfile extends ShopState {}

class ShopUpDateErrorProfile extends ShopState {}
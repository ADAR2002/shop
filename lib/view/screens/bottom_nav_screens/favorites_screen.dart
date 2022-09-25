import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/model/favorite.dart';
import 'package:shop/view/widgets/conaitionalbuilder.dart';
import 'package:shop/view/widgets/mylist.dart';

import '../../../business_logic/shop_cubit/shop_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        conditional: ShopCubit.get(context).favoriteModel != null ,
        fallback: (context) => Center(
          child: Text(
            "No Internet",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        builder:(context)=> ConditionalBuilder(
          conditional: state is! ShopLoadingFavoriteData,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(
              thickness: 1,
            ),
            itemCount: ShopCubit.get(context).favoriteModel!.data.data.length,
            itemBuilder: (BuildContext context, int index) => MyList(
              product:
                  ShopCubit.get(context).favoriteModel!.data.data[index].product,
              isSearch: false,
            ),
          ),
        ),
      ),
    );
  }
}

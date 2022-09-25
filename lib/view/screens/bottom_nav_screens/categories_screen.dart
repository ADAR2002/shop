import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/shop_cubit/shop_cubit.dart';
import 'package:shop/data/model/categories.dart';
import 'package:shop/view/widgets/conaitionalbuilder.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        conditional: ShopCubit.get(context).categoriesModel != null ,
        fallback: (context) => Center(
          child: Text(
            "No Internet",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        builder: (context) => ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 3,
          ),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
          itemBuilder: (BuildContext context, int index) => buildCatItem(
              ShopCubit.get(context).categoriesModel!.data.data[index]),
        ),
      ),
    );
  }

  Padding buildCatItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 100,
            height: 100,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_back_ios),
        ],
      ),
    );
  }
}

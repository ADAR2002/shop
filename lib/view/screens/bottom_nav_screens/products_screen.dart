import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/shop_cubit/shop_cubit.dart';
import 'package:shop/data/model/categories.dart';
import 'package:shop/data/model/home_model.dart';
import 'package:shop/view/widgets/conaitionalbuilder.dart';
import 'package:shop/view/widgets/toast.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccessFavorite) {
          if (!state.favoriteModel.status) {
            MyToast.showToast(
                msg: state.favoriteModel.message, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          conditional: cubit.homeModel != null &&
              cubit.categoriesModel != null &&
              cubit.favoriteModel != null,
          builder: (context) => productsBuilder(
              cubit.homeModel!, cubit.categoriesModel!, context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
      HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          carouselSliderBuilder(model,context),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 70,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 20,
                    ),
                    itemCount: categoriesModel.data.data.length,
                    itemBuilder: (BuildContext context, int index) =>
                        categoriesItem(categoriesModel.data.data[index]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              mainAxisSpacing: 3,
              crossAxisSpacing: 1.5,
              childAspectRatio: 1 / 1.61,
              children: List.generate(model.data.products.length,
                  (index) => buildProduct(model.data.products[index], context)),
            ),
          )
        ],
      ),
    );
  }

  Widget categoriesItem(DataModel categoriesModelItem ) {
    return Card(
      elevation: 5,
      color: Colors.grey,
      child: SizedBox(
        height: 70,
        width: 70,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
              image: NetworkImage(categoriesModelItem.image),
              errorBuilder: (context,error,_) => Image.asset(
                'assets/image/no.png',
                height: MediaQuery.of(context).size.width * 0.45,
                width: MediaQuery.of(context).size.width * 0.40,
              ),
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              child: Text(
                categoriesModelItem.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
              color: Colors.black87.withOpacity(0.8),
            )
          ],
        ),
      ),
    );
  }

  CarouselSlider carouselSliderBuilder(HomeModel model,context) {
    return CarouselSlider(
        items: model.data.banners
            .map((e) => Card(
                  elevation: 10,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          onError: (error,_ )=>Image.asset(
                            'assets/image/no.png',
                            height: MediaQuery.of(context).size.width * 0.45,
                            width: MediaQuery.of(context).size.width * 0.40,
                          ),

                            image: NetworkImage(e.image), fit: BoxFit.fill)),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
            viewportFraction: 1.05,
            height: 200,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            scrollDirection: Axis.horizontal,
            autoPlayCurve: Curves.fastOutSlowIn));
  }

  buildProduct(ProductsModel product, context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              FadeInImage.assetNetwork(
                imageErrorBuilder: (context, error, _) => Image.asset(
                  'assets/image/no.png',
                  height: MediaQuery.of(context).size.width * 0.45,
                  width: MediaQuery.of(context).size.width * 0.40,
                ),
                fit: BoxFit.fill,
                placeholder: 'assets/image/shop.gif',
                image: product.image,
                height: MediaQuery.of(context).size.width * 0.45,
                width: MediaQuery.of(context).size.width * 0.40,
              ),
              if (product.oldPrice != product.price)
                Container(
                  width: 90,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Discount",
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ],
          ),
          Text(
            product.name,
            maxLines: 2,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${product.price.round()}',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (product.oldPrice != product.price)
                      Text(
                        '${product.oldPrice.round()}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12),
                      ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changeFavoriteData(product.id);
                  },
                  icon: CircleAvatar(
                    backgroundColor:
                        ShopCubit.get(context).favorites[product.id]!
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                    child: const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.white,
                    ),
                  ),
                  iconSize: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

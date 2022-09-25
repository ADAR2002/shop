import 'package:flutter/material.dart';

import '../../business_logic/shop_cubit/shop_cubit.dart';

class MyList extends StatelessWidget {
  const MyList({Key? key, required this.product, required this.isSearch})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final product;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/image/shop.gif',
                image: product.image,
                height: 125,
                width: 125,
              ),
              if (!isSearch)
                if (product.oldPrice.round() != product.price.round())
                  Container(
                    width: 90,
                    height: 35,
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
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${product.price.round()}',
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          if (!isSearch)
                            if (product.oldPrice.round() !=
                                product.price.round())
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
                          //  print(product.id);
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

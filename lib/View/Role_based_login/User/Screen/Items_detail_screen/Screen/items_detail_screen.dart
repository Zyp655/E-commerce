import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Core/Common/cart_oder_count.dart';
import 'package:e_commerce/Core/Provider/cart_provider.dart';
import 'package:e_commerce/Core/Provider/favorite_provider.dart';
import 'package:e_commerce/Widgets/show_scackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../Core/Common/Utils/colors.dart';
import '../../../../../../Core/Models/model.dart';
import '../Widgets/size_and_color.dart';

class ItemsDetailScreen extends ConsumerStatefulWidget {
  final DocumentSnapshot<Object?> productItems;

  const ItemsDetailScreen({super.key, required this.productItems});

  @override
  ConsumerState<ItemsDetailScreen> createState() => _ItemsDetailScreen();
}

class _ItemsDetailScreen extends ConsumerState<ItemsDetailScreen> {
  int currentIndex = 0;
  int selectedColorIndex = 1;
  int selectedSizeIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CartProvider cp = ref.watch(cartService);
    FavoriteProvider provider = ref.watch(favoriteProvider);
    final finalPrice = num.parse(
      (widget.productItems['price'] *
              (1 - widget.productItems['discountPercentage'] / 100))
          .toStringAsFixed(2),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: fbackgroundColor2,
        title: const Text('Detail Product'),
        actions: [
          CartOderCount(),
          SizedBox(width: 20),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: fbackgroundColor2,
            height: size.height * 0.46,
            width: size.width,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Hero(
                      tag: '${widget.productItems.id}_$index',
                      child: Image.asset(
                        widget.productItems['image'],
                        width: size.width * 0.85,
                        height: size.height * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(microseconds: 300),
                          margin: const EdgeInsets.only(right: 4),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == currentIndex
                                ? Colors.blue
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'H&M',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black26,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Icon(Icons.star, color: Colors.amber, size: 17),
                    Flexible(
                      child: Text(
                        ' ${Random().nextInt(2) + 3}.${Random().nextInt(5) + 4}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '(${Random().nextInt(300) + 25})',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        provider.toggleFavorite(widget.productItems);
                      },
                      child: Icon(
                        provider.isExit(widget.productItems)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: provider.isExit(widget.productItems)
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.productItems['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$$finalPrice',
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (widget.productItems['isDiscounted'] == true)
                      Text(
                        '\$${widget.productItems['price']}.00',
                        style: const TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.black26,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  '$myDescription1 ${widget.productItems['name']}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -.5,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 20),
                SizeAndColor(
                  colors: widget.productItems['fcolor'],
                  sizes: widget.productItems['size'],
                  onColorSelected: (index) {
                    setState(() {
                      selectedColorIndex = index;
                    });
                  },
                  onSizeSelected: (index) {
                    setState(() {
                      setState(() {
                        selectedSizeIndex = index;
                      });
                    });
                  },
                  selectedColorIndex: selectedColorIndex,
                  selectedSizeIndex: selectedSizeIndex,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 0,
        label: SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
                 Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        final productId = widget.productItems.id;
                        final productData =
                        widget.productItems.data() as Map<String, dynamic>;
                        final selectedColor =
                        widget.productItems['fcolor'][selectedColorIndex];
                        final selectedSize =
                        widget.productItems['size'][selectedSizeIndex];

                        cp.addCart(
                          productId,
                          productData,
                          selectedColor,
                          selectedSize,
                        );
                        showSnakeBar(context, '${productData['name']} added to cart');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.shopping_bag, color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            'Add To Cart',
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white, letterSpacing: -1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

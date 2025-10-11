import 'package:e_commerce/Core/Common/color_conversion.dart';
import 'package:e_commerce/Core/Provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../Core/Models/cart_model.dart';

class CartItems extends ConsumerWidget {
  final CartModel cart;

  const CartItems({super.key, required this.cart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartProvider cp = ref.watch(cartService);
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 120,
      width: size.width / 1.1,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Image.asset(
                cart.productData['image'],
                height: 120,
                width: 70,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      cart.productData['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Color: '),
                        const SizedBox(width: 5),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: getColorFromName(cart.selectedColor),
                        ),
                        const SizedBox(width: 5),
                        const Text('Size :'),
                        Text(
                          cart.selectedSize,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        const SizedBox(width: 45),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (cart.quantity > 1) {
                                  cp.decreaseQuantity(cart.productId);
                                }
                              },
                              child: Container(
                                width: 20,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(7),
                                  ),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              cart.quantity.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                cp.addQuantity(cart.productId);
                              },
                              child: Container(
                                width: 20,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(7),
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

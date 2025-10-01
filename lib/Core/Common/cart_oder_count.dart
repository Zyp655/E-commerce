import 'package:e_commerce/Core/Provider/cart_provider.dart';
import 'package:e_commerce/View/Role_based_login/User/Screen/User%20Activity/Screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class CartOderCount extends ConsumerWidget {
  const CartOderCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartProvider cp = ref.watch(cartService);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
            Iconsax.shopping_bag,
            size: 28
        ),
        cp.carts.isNotEmpty ?

        Positioned(
          right: -1,
          top: -5,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => const CartScreen()
                  ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  cp.carts.length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ) : const SizedBox()
      ],
    );
  }
}

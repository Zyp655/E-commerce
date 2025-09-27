import 'package:e_commerce/View/User/category_items.dart';
import 'package:e_commerce/View/Widgets/banner.dart';
import 'package:e_commerce/View/Widgets/curated_items.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../Core/Common/Utils/colors.dart';
import '../../Core/Models/category_model.dart';
import '../../Core/Models/model.dart';
import '../Screen/Items_detail_screen/Screen/items_detail_screen.dart';

class UserAppHomeScreen extends StatefulWidget {
  const UserAppHomeScreen({super.key});

  @override
  State<UserAppHomeScreen> createState() => _UserAppHomeScreenState();
}

class _UserAppHomeScreenState extends State<UserAppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/Auth/login.png',
                    height: 40,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Iconsax.shopping_bag,
                        size: 28,
                      ),
                      Positioned(
                        right: -3,
                        top: -5,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const MyBanner(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shop by category',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  category.length,
                      (index) => InkWell(
                    onTap: () {
                      final filterItems = fashionEcommerceApp
                          .where((item) =>
                      item.category.toLowerCase() ==
                          category[index].name.toLowerCase())
                          .toList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryItems(
                            category: category[index].name,
                            categoryItems: filterItems,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: fbackgroundColor1,
                            backgroundImage: AssetImage(
                              category[index].image,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(category[index].name),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Items',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(fashionEcommerceApp.length, (index) {
                  final eCommerceItems = fashionEcommerceApp[index];
                  final uniqueHeroTag = eCommerceItems.id;

                  return Padding(
                    padding: index == 0
                        ? const EdgeInsets.symmetric(horizontal: 20)
                        : const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ItemsDetailScreen(
                              eCommerceApp: eCommerceItems,
                            ),
                          ),
                        );
                      },
                      child: CuratedItems(
                        eCommerceItems: eCommerceItems,
                        size: size,
                        heroTag: uniqueHeroTag,
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}


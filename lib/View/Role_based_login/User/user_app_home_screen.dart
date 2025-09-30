import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/View/Widgets/banner.dart';
import 'package:e_commerce/View/Widgets/curated_items.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../Core/Common/Utils/colors.dart';
import '../../../Core/Models/category_model.dart';
import 'Screen/Items_detail_screen/Screen/items_detail_screen.dart';
import 'category_items.dart';

class UserAppHomeScreen extends StatefulWidget {
  const UserAppHomeScreen({super.key});

  @override
  State<UserAppHomeScreen> createState() => _UserAppHomeScreenState();
}

class _UserAppHomeScreenState extends State<UserAppHomeScreen> {
  final CollectionReference categoriesItems=
      FirebaseFirestore.instance.collection('Category');
  final CollectionReference items=
      FirebaseFirestore.instance.collection('items');

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
        StreamBuilder(
          stream: categoriesItems.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    streamSnapshot.data!.docs.length,
                        (index) =>
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CategoryItems(
                                      category: streamSnapshot
                                          .data!
                                          .docs[index]['name'],
                                      selectedCategory: streamSnapshot
                                          .data!
                                          .docs[index]['name'],
                                    ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
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
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          }
        ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Curated Items',
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
            StreamBuilder(
              stream: items.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData){
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(snapshot.data!.docs.length, (index) {
                        final eCommerceItems = snapshot.data!.docs[index];
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
                                          productItems: eCommerceItems,
                                      )
                                  )
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
                  );
                }
                return const Center(child:  CircularProgressIndicator(),);
              },
            )
          ],
        ),
      ),
    );
  }
}


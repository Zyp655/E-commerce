import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Core/Provider/cart_provider.dart';
import 'package:e_commerce/Core/Provider/favorite_provider.dart';
import 'package:e_commerce/View/Role_based_login/Admin/Screen/order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Services/auth_service.dart';
import 'package:flutter/material.dart';
import '../../login_screen.dart';
import 'add_items.dart';

final AuthService _authService = AuthService();

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  String? selectedCategory;
  List<String> categories = ['Tất cả'];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Category')
        .get();
    setState(() {
      categories.addAll(
        snapshot.docs.map((doc) => doc['name'] as String).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    Query itemsQuery = FirebaseFirestore.instance
        .collection('items')
        .where("uploadedBy", isEqualTo: uid);

    if (selectedCategory != null && selectedCategory != 'All') {
      itemsQuery = itemsQuery.where('category', isEqualTo: selectedCategory);
    }

    return Scaffold(
      backgroundColor: Colors.blueAccent[70],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Your Uploaded Items',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.receipt_long),
                      ),
                      Positioned(
                        top: 6,
                        right: 8,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Orders')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Text('Error loading orders');
                                }
                                final orderCount = snapshot.data?.docs.length;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminOrderScreen(),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.red,
                                    child: Center(
                                      child: Text(
                                        orderCount.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _authService.signOut();
                      if (mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                        ref.invalidate(favoriteProvider);
                        ref.invalidate(cartService);
                      }
                    },
                    child: const Icon(Icons.exit_to_app),
                  ),
                  DropdownButton<String>(
                    hint: const Text("filter category"),
                    value: selectedCategory,
                    items: categories.map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    icon: const Icon(Icons.tune),
                    underline: const SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: itemsQuery.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading items'));
                    }
                    final documents = snapshot.data?.docs ?? [];
                    if (documents.isEmpty) {
                      return const Center(child: Text('No items uploaded'));
                    }
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final itemData =
                            documents[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 2,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    (itemData['image'] != null &&
                                        itemData['image'].isNotEmpty)
                                    ? CachedNetworkImage(
                                        imageUrl: itemData['image'],
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )
                                    : Container(
                                        height: 60,
                                        width: 60,
                                        color: Colors.grey[200],
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                              ),
                              title: Text(itemData['name'] ?? "N/A"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        itemData['price'] != null
                                            ? '\$${itemData['price']}.00'
                                            : 'N/A',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text('${itemData['category'] ?? 'N/A'}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddItems()));
        },
        child: const Icon(Icons.add, color: Colors.purpleAccent),
      ),
    );
  }
}

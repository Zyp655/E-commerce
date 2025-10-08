import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Core/Common/Utils/colors.dart';
import 'package:e_commerce/Core/Provider/favorite_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final provider = ref.watch(favoriteProvider);
    return Scaffold(
      backgroundColor: fbackgroundColor2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: fbackgroundColor2,
        centerTitle: true,
        title: const Text(
          'Favorite',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: userId == null
          ? Center(child: Text('please log in to view favorite'))
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('userFavorite')
                  .where('userId', isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final favoriteDocs = snapshot.data!.docs;
                if (favoriteDocs.isEmpty) {
                  return const Center(child: Text('No favorite yet'));
                }
                return FutureBuilder<List<DocumentSnapshot>>(
                  future: Future.wait(
                    favoriteDocs.map(
                      (doc) => FirebaseFirestore.instance
                          .collection('items')
                          .doc(doc.id)
                          .get(),
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final favoriteItems = snapshot.data!
                        .where((doc) => doc.exists)
                        .toList();
                    if (favoriteItems.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: favoriteItems.length,
                      itemBuilder: (context, index) {
                        final favoriteItem = favoriteItems[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              favoriteItem['image'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 20,
                                              ),
                                              child: Text(
                                                favoriteItem['name'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${favoriteItem['category']} Fashion',
                                            ),
                                            Text(
                                              '\$${favoriteItem['price']}.00',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 50,
                                right: 35,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.toggleFavorite(favoriteItem);
                                  },
                                  child: Icon(Icons.delete, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}

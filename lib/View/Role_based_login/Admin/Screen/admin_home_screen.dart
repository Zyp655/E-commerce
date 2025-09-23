import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/View/Role_based_login/Admin/Screen/add_items.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../Services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../login_screen.dart';
final AuthService _authService=AuthService();
class AdminHomeScreen extends StatefulWidget{
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final CollectionReference items=
    FirebaseFirestore.instance.collection('items');
    String? selectedCategory;
    List<String> categories=[];
  @override
  Widget build(BuildContext context) {
    String uid=FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.blueAccent[70],
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Your Upload Items',
                      style: TextStyle(
                        fontSize :18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _authService.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                            )
                        );
                      },
                      child: const Icon(Icons.exit_to_app),

                    )
                  ],
                ),

                Expanded(
                    child: StreamBuilder(
                        stream: items
                            .where("uploadedBy", isEqualTo: uid)
                            .where('category', isEqualTo: selectedCategory)
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(snapshot.hasError){
                            return const Center(child: Text('Error loading items'));
                          }
                          final documents = snapshot.data?.docs ?? [];
                          if(documents.isEmpty){
                            return const Center(child: Text('no items uploaded'));
                          }
                          return ListView.builder(
                            itemCount :documents.length,
                            itemBuilder:(context,index){
                              final items=
                                  documents[index].data() as Map<String,dynamic>;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 2,
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: items['image'],
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      items['name'] ?? "N/A",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              items['price'] !=null
                                                  ?'\$${items['price']}.00'
                                                  : 'N/A',
                                              style: const TextStyle(
                                                fontSize:15,
                                                letterSpacing: -1,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red,
                                                ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${items ['category'] ?? 'N/A'}',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5,)
                                      ],
                                    ) ,
                                  ),
                                ),
                              );
                            }
                          );
                        },
                    )
                )
              ],
            ),
          )
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,

        onPressed: ()async{
          await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>  AddItems(),
              ));
        },
        child: const Icon(Icons.add, color: Colors.purpleAccent,),
      ),

    );
  }
}


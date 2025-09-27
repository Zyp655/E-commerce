
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../Core/Common/Utils/colors.dart';
import '../../Core/Models/model.dart';
import '../../Core/Models/sub_category.dart';
import '../Screen/Items_detail_screen/Screen/items_detail_screen.dart';

class CategoryItems extends StatelessWidget {
  final String category;
  final List<AppModel> categoryItems;
  const CategoryItems({
    super.key,
    required this.category,
    required this.categoryItems
  });

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white ,
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_new),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                        child: SizedBox(
                          height: 45,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(5),
                              hintText: "$category's fashion",
                              hintStyle: const TextStyle(
                                  color:Colors.black38
                              ),
                              filled: true,
                              fillColor: fbackgroundColor2,
                              focusedBorder:
                                const OutlineInputBorder(borderSide: BorderSide.none),
                              prefixIcon: const Icon(
                                Iconsax.search_normal,
                                color: Colors.black38,
                              ),
                              border: const OutlineInputBorder(borderSide:BorderSide.none),
                            ),
                          ),
                        ),
                    ),
                  ],
                ) ,
              ),
              const SizedBox(height: 20,),
              Padding(
                  padding:EdgeInsets
                      .symmetric (
                      horizontal: 20,
                  ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        filterCategory.length,
                            (index)=> Padding(
                              padding:EdgeInsets.only(right:5 ),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Text(filterCategory[index]),
                                    const SizedBox(width: 5,),
                                    index == 0
                                      ? const Icon(
                                          Icons.filter_list,
                                          size: 15,
                                      )
                                      : const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 15,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    subcategory.length,
                        (index)=>InkWell(
                      onTap:(){

                      } ,
                      child:Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              height:50 ,
                              width: 50,
                              decoration: BoxDecoration(
                                color: fbackgroundColor1 ,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                      image: AssetImage(subcategory[index].image),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(subcategory[index].name),
                        ],
                      ) ,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                  child: categoryItems.isEmpty
                      ? Center(
                        child: Text(
                          'No items available in this category',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      )
                      : GridView.builder(
                        padding:const  EdgeInsets.symmetric(horizontal: 20),
                         itemCount: categoryItems.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) {
                            final item = categoryItems[index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ItemsDetailScreen(
                                            eCommerceApp: item,
                                        ),
                                    )
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: item.image,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: fbackgroundColor2,
                                        image: DecorationImage(
                                          image:AssetImage(item.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      height: size.height *0.25,
                                      width: size.width* 0.25,
                                      child: const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.black26,
                                          child: Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ),
                                  ),
                                const SizedBox(height: 7,),
                                Row(
                                  children: [
                                    const Text(
                                      'H&M',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black26,
                                      ),
                                    ),

                                    const SizedBox(height: 5,),

                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 17,
                                    ),

                                    Text(item.rating.toString()),

                                    Text(
                                      '(${item.review})',
                                      style: TextStyle(
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  item.name,
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
                                      '\$${item.price.toString()}.00',
                                      style: const TextStyle(
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 1.5,
                                      ),
                                    ),
                                    const  SizedBox(width: 5,),
                                    if(item.isCheck== true)
                                      Text(
                                        '\$${item.price + 200}.00',
                                        style: const TextStyle(
                                          color: Colors.black26,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.black26,
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          );
                          },
                      ),
              ),
            ],
          )
      ),
    );
  }
}

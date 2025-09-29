import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Core/Provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Core/Common/Utils/colors.dart';
class CuratedItems extends ConsumerWidget {
  final DocumentSnapshot<Object?> eCommerceItems;
  final Size size;
  final String heroTag;

  const CuratedItems({
    super.key,
    required this.eCommerceItems,
    required this.size, required this.heroTag,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider =ref.watch(favoriteProvider);
    return SizedBox(
      width: size.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: eCommerceItems.id,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: fbackgroundColor2,
                image: DecorationImage(
                  image: AssetImage(eCommerceItems['image']),
                  fit: BoxFit.cover,
                ),
              ),
              height: size.height * 0.25,

              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: provider.isExit(eCommerceItems)
                        ? Colors.white
                        : Colors.black26,
                    child: GestureDetector(
                      onTap: (){
                        ref.read(favoriteProvider)
                            .toggleFavorite(eCommerceItems);
                      },
                      child: Icon(
                        provider.isExit(eCommerceItems)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: provider.isExit(eCommerceItems)
                          ? Colors.red
                          : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const Text(
                'H&M',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black26,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 17,
              ),

              Flexible(
                child: Text(
                  ' ${Random().nextInt(2)+3}.${Random().nextInt(5)+4}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Text(
                  '(${Random().nextInt(300)+25})',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black26,
                  ),
                ),
              ),
            ],
          ),
          Text(
            eCommerceItems['name']?? 'N/A',
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
              '\$${(eCommerceItems['price']*(1-eCommerceItems['discountPercentage']/100))
                .toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
              const SizedBox(width: 5),
              if (eCommerceItems['isDiscounted'] == true)
                Flexible(
                  child: Text(
                    '\$${eCommerceItems['price']}.00',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black26,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.black26,
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}


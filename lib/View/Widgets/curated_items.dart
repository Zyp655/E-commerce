import 'package:flutter/material.dart';
import '../../Core/Common/Utils/colors.dart';
import '../../Core/Models/model.dart';

class CuratedItems extends StatelessWidget {
  final AppModel eCommerceItems;
  final Size size;
  final String heroTag;

  const CuratedItems({
    super.key,
    required this.eCommerceItems,
    required this.size,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: heroTag,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: fbackgroundColor2,
                image: DecorationImage(
                  image: AssetImage(eCommerceItems.image),
                  fit: BoxFit.cover,
                ),
              ),
              height: size.height * 0.25,

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
                  ' ${eCommerceItems.rating.toString()}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Text(
                  '(${eCommerceItems.review})',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black26,
                  ),
                ),
              ),
            ],
          ),
          Text(
            eCommerceItems.name,
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
                '\$${eCommerceItems.price.toString()}.00',
                style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
              const SizedBox(width: 5),
              if (eCommerceItems.isCheck == true)
                Flexible(
                  child: Text(
                    '\$${eCommerceItems.price + 200}.00',
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


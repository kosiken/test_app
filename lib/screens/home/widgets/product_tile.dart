
import 'package:flutter/material.dart';
import 'package:test_app/constants/colors.dart';
import 'package:test_app/models/models.dart';
import 'package:test_app/widgets/button.dart';
import 'package:test_app/widgets/opacity_feedback.dart';
import 'package:test_app/widgets/typography.dart';
import 'package:unicons/unicons.dart';


class ProductTile extends StatelessWidget {
  final Product product;
  final void Function()? onPress;
  const ProductTile({super.key, required this.product, this.onPress});

  @override
  Widget build(BuildContext context) {
    return 
    Stack(
      children: [
   OpacityFeedback(
    onClick: onPress,
        child:  Column(
          
          children: [
              
        Container(
              height: 150,
              decoration:  BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(product.url), fit: BoxFit.fitWidth),
        ),
              ),
           
            const SizedBox(
              height: 20,
            ),
           Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             AppTypography(
              product.type,
              color: Colors.grey,
            ),
            AppTypography(
              product.label,
              color: Colors.black,
              bold: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
       
            ),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              Icon(UniconsSolid.star, color: Colors.amber[600], size: 16,),
              const SizedBox(width: 4,),
              AppTypography("${product.rating} | ${product.ratingCount}", type: TextTypes.emphasis, color: Colors.grey, bold: true,),
              Expanded(child: AppTypography(product.formattedPrice, textAlign: TextAlign.right, type: TextTypes.header, color: teal,))
            ])
           ],),)
          ])),

          Positioned(
            top: 4,
            right: 4,
            child: AppIconButton(icon: UniconsLine.heart, onClick: () {},))
      ]);
  }
}

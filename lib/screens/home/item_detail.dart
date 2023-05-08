import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/constants/colors.dart';
import 'package:test_app/constants/data.dart';
import 'package:test_app/debug.dart';
import 'package:test_app/helpers/helpers.dart';
import 'package:test_app/models/models.dart';
import 'package:test_app/screens/home/widgets/product_tile.dart';
import 'package:test_app/widgets/button.dart';
import 'package:test_app/widgets/opacity_feedback.dart';
import 'package:test_app/widgets/progress.dart';
import 'package:test_app/widgets/typography.dart';
import 'package:unicons/unicons.dart';

const ItemDetailMenu = [
  {'title': "About Item", 'key': 'about'},
  {'title': 'Reviews', 'key': 'review'}
];

class ItemAbout {
  final String title;
  final String value;

  const ItemAbout(this.title, this.value);
}

const desctription = """
• Long-sleeve dress shirt in classic fit featuring button-down collar

• Patch Pocket on Left Chest

• Durable Combination Cotton Fabric

• Comfortable and quality dress shirt

• Go To Classic button down shirt for all special occasions


Chat us if there is anything you need to ask about the product:)
""";
const ItemAboutList = [
  ItemAbout(
    'Brand',
    'ChArmkoR',
  ),
  ItemAbout("Color", "Aprikot"),
  ItemAbout("Category", "Casual Shirt"),
  ItemAbout("Material", "Polyester"),
  ItemAbout("Condition", "New"),
  ItemAbout("Heavy", "200 g")
];

class RatingBar extends StatelessWidget {
  final double level;
  final int stars;
  final String text;
  const RatingBar(
      {super.key,
      required this.level,
      required this.stars,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(
            UniconsSolid.star,
            color: Colors.amber[600],
            size: 16,
          ),
          SizedBox(
            width: 10,
          ),
          AppTypography(
            "$stars",
            color: Color.fromARGB(255, 133, 132, 132),
          ),
          SizedBox(
            width: 10,
          ),
          AppProgress(progress: level),
          SizedBox(
            width: 12,
          ),
          AppTypography(
            text,
            bold: true,
          )
        ],
      ),
    );
  }
}

class ReviewTile extends StatelessWidget {
  final String name;
  final String url =
      'https://res.cloudinary.com/kosy/image/upload/v1661617611/6w5b21sxl73ptoha.jpg';
  final int review;

  const ReviewTile({super.key, required this.name, required this.review});

  Widget renderRecommend(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 197, 238, 198),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.green, width: 1)),
      child: AppTypography(text, type: TextTypes.small, color: teal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        //                   <--- left side
        color: Colors.grey,
        width: 0.6,
      ))),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(url),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: AppTypography(
                  name,
                  bold: true,
                ),
              ),
              Icon(
                UniconsSolid.star,
                color: Colors.amber[600],
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              AppTypography(
                review.toStringAsFixed(1),
                bold: true,
                customSize: 15,
              ),
              const SizedBox(
                width: 4,
              ),
              AppIconButton(onClick: () {}, icon: UniconsLine.ellipsis_h)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              renderRecommend("Product in good Condition"),
              renderRecommend("Very fast delivery"),
              renderRecommend("Fast seller response"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(right: 55),
            child: AppTypography(
                "According to my expectations. This is the best thank you"),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppIconButton(
                    onClick: () {},
                    icon: Icons.thumb_up,
                    color: teal,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  AppTypography(
                    'Helpful ?',
                    color: teal,
                    bold: true,
                  ),
                ],
              ),
              AppTypography(
                "Yesterdays",
                color: Colors.grey,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class ItemDetail extends StatefulWidget {
  final void Function() onBack;
  const ItemDetail({super.key, required this.onBack});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  String selectedMenu = 'about';
  bool showDescription = false;

  @override
  void initState() {
    super.initState();
  }

  void selectItem(String key) {
    setState(() {
      selectedMenu = key;
    });
  }

  Widget buildItemImage(Product product, {double radius = 20}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox.fromSize(
          size: Size.fromRadius(radius),
          child: CachedNetworkImage(
            imageUrl: product.url,
            progressIndicatorBuilder: (context, url, progress) {
              return Platform.isIOS
                  ? const CupertinoActivityIndicator(color: teal)
                  : const CircularProgressIndicator(color: teal);
            },
          ),
        ),
      ),
    );
  }

  Widget buildAboutItem(String key, String value) {
    return RichText(
      text: TextSpan(
        text: "$key:   ",
        style: GoogleFonts.lato(
            textStyle: TextStyle(
          fontSize: 14,
          decoration: TextDecoration.none,
          color: Colors.grey,
        )),
        children: [
          TextSpan(
              text: value,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: Colors.black))
        ],
      ),
      textDirection: TextDirection.ltr,
    );
  }

  Widget buildMenuItem(Map<String, String> item) {
    bool selected = item['key'] == selectedMenu;
    String title = item['title']!;

    return OpacityFeedback(
        onClick: () {
          selectItem(item['key']!);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: selected
              ? (const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                  //                   <--- left side
                  color: teal,
                  width: 2.0,
                ))))
              : null,
          child: AppTypography(
            title,
            color: selected ? teal : Colors.grey,
            bold: selected,
            customSize: 15,
          ),
        ));
  }

  Widget buildGridItem(ItemAbout itemAbout) {
    return Row(
      children: [
        AppTypography(
          '${itemAbout.title}:',
          color: Colors.grey,
        ),
        const SizedBox(
          width: 5,
        ),
        AppTypography(
          itemAbout.value,
          color: Colors.black,
          bold: true,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Product product = Products.first;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: Row(
            children: [
              AppIconButton(
                onClick: widget.onBack,
                icon: Icons.chevron_left,
                iconSize: 30,
              ),
              Expanded(child: Container()),
              AppIconButton(
                  onClick: () {}, icon: UniconsLine.heart, iconSize: 30),
              const SizedBox(
                width: 8,
              ),
              AppIconButton(
                  onClick: () {}, icon: UniconsLine.share_alt, iconSize: 30),
              const SizedBox(
                width: 8,
              ),
              AppIconButton(
                  onClick: () {}, icon: UniconsLine.shopping_bag, iconSize: 30)
            ],
          ),
        ),
        Expanded(
            child: Container(
                color: Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: size.width),
                              child: CachedNetworkImage(
                                imageUrl: Products.first.url,
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return Platform.isIOS
                                      ? const CupertinoActivityIndicator(
                                          color: teal)
                                      : const CircularProgressIndicator(
                                          color: teal);
                                },
                              ),
                            ),
                            Positioned(
                                top: 10,
                                left: 20,
                                child: Column(
                                  children:
                                      Products.map(buildItemImage).toList(),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(UniconsLine.home, color: Colors.grey),
                            const SizedBox(
                              width: 8,
                            ),
                            const AppTypography('tokobakju.id',
                                color: Colors.grey),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 100, top: 8, left: 10),
                        child: AppTypography(
                          Products.first.label,
                          type: TextTypes.header,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    UniconsSolid.star,
                                    color: Colors.amber[600],
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  AppTypography(
                                    "${product.rating} Ratings",
                                    color: Colors.grey,
                                    customSize: 16,
                                  ),
                                ],
                              ),
                              const AppTypography(
                                "•",
                                color: Colors.grey,
                                bold: true,
                              ),
                              const AppTypography(
                                "2.3k+ Reviews",
                                color: Colors.grey,
                                customSize: 16,
                              ),
                              const AppTypography(
                                "•",
                                color: Colors.grey,
                                bold: true,
                              ),
                              const AppTypography(
                                "2.9k+ Sold",
                                color: Colors.grey,
                                customSize: 16,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            //                   <--- left side
                            color: Colors.grey,
                            width: 0.6,
                          ))),
                          child: Row(
                            children:
                                ItemDetailMenu.map(buildMenuItem).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //  SizedBox(height: 200, width: size.width,

                      // SizedBox(
                      //   height: 100,
                      //   width: size.width,
                      //   child: GridView.count(
                      //       crossAxisCount: 2,
                      //       crossAxisSpacing: 5,
                      //       mainAxisSpacing: 0,
                      //       childAspectRatio: 4,
                      //       padding: const EdgeInsets.only(left: 20, right: 10),
                      //       clipBehavior: Clip.none,
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       children: ItemAboutList.map(buildGridItem)
                      //           .toList(growable: false)),
                      // ),

                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 0),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    buildAboutItem("Brand", "ChArmkpR"),
                                    buildAboutItem("Color", "Aprikot")
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    buildAboutItem("Category", "Casual Shirt"),
                                    buildAboutItem("Material", "Polyester")
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    buildAboutItem("Condition", "New"),
                                    buildAboutItem("Heavy", "200 g")
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 0),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10, top: 30),
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                            //                   <--- left side
                            color: Colors.grey,
                            width: 0.6,
                          ))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppTypography(
                                "Description",
                                bold: true,
                                customSize: 16,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AppTypography(
                                showDescription
                                    ? desctription
                                    : reduceString(desctription, length: 50),
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              OpacityFeedback(
                                  onClick: () {
                                    setState(() {
                                      showDescription = !showDescription;
                                    });
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AppTypography(
                                        showDescription
                                            ? 'See Less'
                                            : 'See More',
                                        color: teal,
                                        bold: true,
                                      ),
                                      Icon(showDescription
                                          ? Icons.arrow_drop_up_outlined
                                          : Icons.arrow_drop_down_outlined)
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 0, bottom: 20),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10, top: 30),
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                            //                   <--- left side
                            color: Colors.grey,
                            width: 0.6,
                          ))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppTypography(
                                "Shippings Information:",
                                bold: true,
                                customSize: 16,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  AppTypography(
                                    "Delivery:",
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  AppTypography(
                                    "Shipping from Jakarta, Indonesia",
                                    bold: true,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  AppTypography(
                                    "Shipping:",
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  AppTypography(
                                    "FREE International Shipping ",
                                    bold: true,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  AppTypography(
                                    "Arrive:",
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  AppTypography(
                                    "Estimated arrival on 25 - 27 Oct 2022",
                                    bold: true,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 0, bottom: 20),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10, top: 30),
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                            //                   <--- left side
                            color: Colors.grey,
                            width: 0.6,
                          ))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTypography(
                                "Sellers Information:",
                                bold: true,
                                customSize: 16,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 36,
                                        backgroundColor: Colors.grey[300],
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              8), // Border radius
                                          child: AppTypography(
                                            "Thrifiting Store",
                                            type: TextTypes.emphasis,
                                            bold: true,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 2,
                                          right: 5,
                                          child: CircleAvatar(
                                            radius: 9,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 6,
                                              backgroundColor: Colors.grey[300],
                                            ),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      AppTypography(
                                        "Thrifting Store",
                                        type: TextTypes.header,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppTypography(
                                        "Active 5 Min Ago | 97% Positive Feedback",
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Button(
                                            onClick: () {},
                                            child: "Visit Store",
                                            bordered: true,
                                            color: teal,
                                            icon: UniconsLine.store,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                          )
                                        ],
                                      )
                                    ],
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 0, bottom: 20),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10, top: 30),
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                            //                   <--- left side
                            color: Colors.grey,
                            width: 0.6,
                          ))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTypography(
                                "Ratings and Reviews",
                                bold: true,
                                customSize: 16,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: '4.9 ',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 40,
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800)),
                                          children: [
                                            TextSpan(
                                                text: "/ 5.0",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey))
                                          ],
                                        ),
                                        textDirection: TextDirection.ltr,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: List.filled(
                                            5,
                                            Icon(
                                              UniconsSolid.star,
                                              color: Colors.amber[600],
                                              size: 16,
                                            ),
                                            growable: false),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AppTypography(
                                        "2.3k+ Reviews",
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RatingBar(
                                          level: 0.7, stars: 5, text: "1.5k"),
                                      RatingBar(
                                          level: 0.4, stars: 4, text: "710"),
                                      RatingBar(
                                          level: 0.2, stars: 3, text: "140"),
                                      RatingBar(
                                          level: 0.2, stars: 2, text: "10"),
                                      RatingBar(level: 0.1, stars: 1, text: "4")
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              AppTypography(
                                "Reviews with images & videos",
                                bold: true,
                                customSize: 15,
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: Products.map((item) =>
                                          buildItemImage(item, radius: 35))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 0, bottom: 20),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10, top: 30),
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                            //                   <--- left side
                            color: Colors.grey,
                            width: 0.6,
                          ))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTypography(
                                        "Top Reviews",
                                        bold: true,
                                        customSize: 16,
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppTypography(
                                          "Showing 3 of 2.3k+ reviews")
                                    ],
                                  ),
                                  OpacityFeedback(
                                      child: Container(
                                    width: 120,
                                    padding: EdgeInsets.only(
                                        bottom: 10,
                                        top: 10,
                                        left: 15,
                                        right: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 253, 253),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        border: Border.all(
                                          color: Colors.grey,
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppTypography(
                                          "Popular",
                                          type: TextTypes.emphasis,
                                          bold: true,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ReviewTile(name: "Eren Y*AHir", review: 5),
                              ReviewTile(name: "LeviA'*'man", review: 5)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 0, bottom: 20),
                          child: Container(
                            padding: const EdgeInsets.only(right: 10, top: 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      OpacityFeedback(
                                          child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            Color.fromARGB(255, 241, 237, 237),
                                        child: Icon(
                                          Icons.chevron_left,
                                          color: Colors.black,
                                        ),
                                      )),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      AppTypography(
                                        "1",
                                        color: teal,
                                        customSize: 15,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      AppTypography(
                                        "2",
                                        color: Colors.grey,
                                        customSize: 15,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      AppTypography(
                                        "3",
                                        color: Colors.grey,
                                        customSize: 15,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      AppTypography(
                                        "....",
                                        color: Colors.grey,
                                        customSize: 15,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      OpacityFeedback(
                                          child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.06),
                                                    offset: Offset(0, 8),
                                                    spreadRadius: 2,
                                                    blurRadius: 10),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: Icon(
                                              Icons.chevron_right,
                                              color: Colors.black,
                                            )),
                                      ))
                                    ],
                                  ),
                                  OpacityFeedback(
                                      child: AppTypography(
                                    "See More",
                                    color: teal,
                                    bold: true,
                                  ))
                                ]),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 0, bottom: 20),
                          child: Container(
                            padding: const EdgeInsets.only(right: 10, top: 0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTypography(
                                      "Recommendation",
                                      bold: true,
                                      customSize: 18,
                                    ),
                                    OpacityFeedback(
                                        child: AppTypography(
                                      "See More",
                                      color: teal,
                                      bold: true,
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: ProductTile(
                                      product: Products.first,
                                    )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: ProductTile(
                                      product: Products.last,
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ))),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  AppTypography(
                    "Total Price",
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  AppTypography(
                    "\$18.00",
                    type: TextTypes.header,
                    color: teal,
                  )
                ],
              ),
              Row(
                children: [
                  Button(
                    onClick: () {},
                    child: "1",
                    icon: UniconsLine.shopping_bag,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                  Button(
                    child: "Buy Now",
                    onClick: () {},
                    color: darkBlue,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}

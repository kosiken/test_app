import 'package:flutter/widgets.dart';

class Product {
  final String url;
  final double rating;
  final String label;
  final int price;
  final int ratingCount;
  final String type;
  final bool liked;

  const Product(
      {required this.url,
      required this.label,
      required this.rating,
      required this.price,
      required this.ratingCount,
      required this.type,
      required this.liked});

  String get formattedPrice {
    String priceString = (price / 100).toStringAsFixed(2);
   return '\$$priceString';

  }

  static Product fromMap(Map<String, Object> map) {
    Product product = Product(
      url: map['url']! as String,
      label: map['label']! as String,
      rating: map['rating']! as double,
      price: map['price']! as int,
      ratingCount: map['rating_count']! as int,
      type: map['type']! as String,
      liked: (map['liked'] ?? false) as bool,
    );
    return product;
  }
}

class Feature {
  final String url;
  final String label;
  final String tag;
  final String announcement;
  final String? lines;

  const Feature(
      {required this.url,
      required this.label,
      required this.announcement,
      required this.tag,
      this.lines});

  String get description {
    return lines ?? " ";
  }

  static Feature fromMap(Map<String, Object> map) {
    Feature feature = Feature(
        url: map['url']! as String,
        label: map['label']! as String,
        tag: map['tag']! as String,
        announcement: map['announcement']! as String,
        lines: map['lines'] as String?);
    return feature;
  }
}


class MenuCategory {
  final IconData icon;
  final String title;

  const MenuCategory({
    required this.icon,
    required this.title
  });

  static MenuCategory fromMap(Map<String, Object> map) {
    MenuCategory menuCategory = MenuCategory(icon: map['icon']! as IconData, title: map['title']! as String);
    return menuCategory;
  }
}
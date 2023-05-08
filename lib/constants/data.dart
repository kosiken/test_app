
import 'package:test_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
const Data ={
  "products": [
  {
    'url': 'https://res.cloudinary.com/kosy/image/upload/v1683475136/shop/shirt4_f3oe2b.jpg',
    'label': 'Essentials Men\'s Short-Sleeve Crewneck T-Shirt',
    'rating': 4.9,
    'rating_count': 2356,
    'price': 1200,
     'type': 'shirt' 
  },

    {
    'url': 'https://res.cloudinary.com/kosy/image/upload/v1683475136/shop/shirt3_unspaj.jpg',
    'label': 'Essentials Men\'s Short-Sleeve Crewneck T-Shirt',
    'rating': 4.9,
    'rating_count': 2356,
    'price': 1200,
     'type': 'shirt' 
  }
  ,

    {
    'url': 'https://res.cloudinary.com/kosy/image/upload/v1683475136/shop/shirt2_x0yesl.jpg',
    'label': 'Essentials Men\'s Short-Sleeve Crewneck T-Shirt',
    'rating': 4.9,
    'rating_count': 2356,
    'price': 1200,
     'type': 'shirt' 
  },
  {
    'url': 'https://res.cloudinary.com/kosy/image/upload/v1683475136/shop/shirt1_aibx8l.jpg',
    'label': 'Essentials Men\'s Regular-Fit Long-Sleeve Oxford Longer text',
    'rating': 4.9,
    'rating_count': 2356,
    'price': 1200,
     'type': 'shirt' 
  }
],
"features": [
{
  'url': 'https://res.cloudinary.com/kosy/image/upload/v1683482785/shop/4k-g0090fc8fc_640_vtabz9.jpg',
  'announcement': '80% OFF',
  'tag': 'FASHION DAY',
  'label': 'Check this out',
  'lines': 'Discover the fashion that suits your style'
},
{
  'url': 'https://res.cloudinary.com/kosy/image/upload/v1683478841/shop/4k-ga6ffb35cc_640_nrltjn.jpg',
  'announcement': 'DISCOVER OUR BEAUTY SECTION',
  'tag': 'BEAUTYSALE',
  'label': 'Check this out',

},
{
  'url': 'https://res.cloudinary.com/kosy/image/upload/v1683482588/shop/shoes-g6538f1c4a_640_qcvdkn.jpg',
  'announcement': 'THIS IS A CUSTOM TEXT',
  'tag': 'CUSTOM',
  'label': 'Custom',
},
]

};

var Products = Data['products']!.map((e) => Product.fromMap(e));

var Features = Data['features']!.map((e) => Feature.fromMap(e));


const SEARCH_BAR_HEIGHT = kToolbarHeight + 35;

var MenuCategories = [
  {
    "title": 'Category',
    "icon": UniconsLine.web_grid
  },
    {
    "title": 'Flight',
    "icon": UniconsLine.plane
  },
    {
    "title": 'Bill',
    "icon": UniconsLine.clipboard
  },
    {
    "title": 'Data Plan',
    "icon": UniconsLine.globe
  },
  {
    "title": 'Top up',
    "icon": UniconsLine.usd_circle
  }
].map((e) => MenuCategory.fromMap(e));
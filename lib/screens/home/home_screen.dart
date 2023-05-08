import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/constants/data.dart';
import 'package:test_app/debug.dart';
import 'package:test_app/models/models.dart';
import 'package:test_app/screens/home/item_detail.dart';
import 'package:test_app/screens/home/widgets/product_tile.dart';
import 'package:test_app/screens/home/widgets/search_bar.dart';
import 'package:test_app/screens/home/widgets/top_list.dart';
import 'package:test_app/widgets/button.dart';
import 'package:test_app/widgets/opacity_feedback.dart';
import 'package:test_app/widgets/overlay.dart';
import 'package:test_app/widgets/stepper.dart';
import 'package:test_app/widgets/typography.dart';
import 'package:test_app/constants/colors.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; 
  final formKey = GlobalKey<AppOverlayState>();
 Widget buildMenuCategoryItem(MenuCategory menuCategory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppIconButton(
          onClick: () {},
          icon: menuCategory.icon,
          iconSize: 25,
          color: const Color.fromRGBO(77, 79, 90, 1),
          backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        ),
       const SizedBox(
          height: 10,
        ),
        AppTypography(
          menuCategory.title,
          color: Colors.grey,
          type: TextTypes.body,
        )
      ],
    );
  }

  Widget buildProductTile(Product product) {
    return ProductTile(product: product, onPress: openDetails,);
  }

void openDetails() {
   Debug.log((formKey.currentState)!.playAnimation());
}
  void _onItemTapped(int index) {
   
  setState(() {
    _selectedIndex = index;
  });
}

void close() {
  Debug.log("Close message");
  formKey.currentState!.reverseAnimation();
}
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Size size = MediaQuery.of(context).size;
       final double itemHeight = (size.height - 260) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(children: [
          Expanded(child:   Container(
          color: Color.fromARGB(255, 237, 237, 237),
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                toolbarHeight: SEARCH_BAR_HEIGHT,
                expandedHeight: 290.0,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Toplist(),
                ),
              ),
              // SliverList(delegate: delegate),
              SliverFillRemaining(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: MenuCategories.map(buildMenuCategoryItem)
                                .toList(),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: AppStepper(index: 0, number: 3),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          AppTypography(
                            'Best Sale Product',
                            type: TextTypes.header,
                          ),
                          AppTypography(
                            'See more ',
                            color: teal,
                            customSize: 18.0,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child:  GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 10,
                          childAspectRatio:  (itemWidth / itemHeight),
                          
                          
                       
                          clipBehavior: Clip.none,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          children: Products.map(buildProductTile).toList(growable: false)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        ),
         BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
       selectedItemColor: teal,
       unselectedItemColor: Colors.grey,

       selectedLabelStyle:GoogleFonts.lato(
        textStyle: TextStyle(color: Colors.black)
       ) ,
       unselectedLabelStyle: GoogleFonts.lato(
        textStyle: TextStyle(color: Colors.grey)
       ),
  elevation: 0,
       currentIndex: _selectedIndex, //New
  onTap: _onItemTapped,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(UniconsSolid.house_user),
        label: 'Home',
  
      ),
      BottomNavigationBarItem(
        icon: Icon(UniconsSolid.bookmark),
        label: 'Camera',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.wallet),
        label: 'Wallet',
      ),
        BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ],
  ),
   
        ]),
      const SearchBar(),
      AppOverlay(show: false, size: size, key: formKey, child: Center(child: ItemDetail(onBack: close)),)
        // Positioned(child: ,))
      ],

    ),
 );
  }

}

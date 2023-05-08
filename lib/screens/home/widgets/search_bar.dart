
import 'package:flutter/material.dart';
import 'package:test_app/widgets/button.dart';
import 'package:test_app/widgets/search_input.dart';
import 'package:unicons/unicons.dart';


class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Positioned(
        top: query.padding.top + 10,
        left: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: query.size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 55,
                    child: const SearchInput(
                      placeholder: "Search...",
                      icon: UniconsLine.search,
                    )),
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 14,
                    ),
                    AppIconButton(
                      onClick: () {},
                      icon: UniconsLine.shopping_bag,
                      iconSize: 30,
                      text: '1',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    AppIconButton(
                      onClick: () {},
                      icon: UniconsLine.comment,
                      iconSize: 30,
                      text: '9+',
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

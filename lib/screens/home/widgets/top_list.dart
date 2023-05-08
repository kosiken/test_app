
import 'package:flutter/material.dart';
import 'package:test_app/constants/colors.dart';
import 'package:test_app/constants/data.dart';
import 'package:test_app/models/models.dart';
import 'package:test_app/widgets/button.dart';
import 'package:test_app/widgets/stepper.dart';
import 'package:test_app/widgets/typography.dart';


class Toplist extends StatefulWidget {
  const Toplist({super.key});

  @override
  State<Toplist> createState() => _ToplistState();
}

class _ToplistState extends State<Toplist> {
  ScrollController _controller = ScrollController();
  int index = 0;
  double lastOffset = 0.0;
  int count = 0;
  bool isRight = true;

  void dragUpdate(DragUpdateDetails details) {
    _controller.jumpTo(_controller.offset - details.delta.dx);
    isRight = _controller.offset > lastOffset;
    lastOffset = _controller.offset;
  }

  void _scrollListener(DragEndDetails details) {
    var offset = 0.0;
    double width = MediaQuery.of(context).size.width;
    if (isRight) {
      offset = (index + 1) * width * 0.5;
      if (_controller.offset > offset &&
          _controller.offset < _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        _moveUp();
      } else {
        _controller.animateTo(index * width,
            curve: Curves.linear, duration: const Duration(milliseconds: 150));
      }
    } else if (!isRight) {
      offset = (index + 1) * width / 2;
      // offset = (index + 1) * width * 0.5;
      if (_controller.offset < offset &&
          _controller.offset > _controller.position.minScrollExtent) {
        _moveDown();
      } else {
        _controller.animateTo(index * width,
            curve: Curves.linear, duration: Duration(milliseconds: 150));
      }
    }
  }

  void _moveDown() {
    //Add logic here
    // index - 1;
    double width = MediaQuery.of(context).size.width;
    index -= 1;
    _controller.animateTo(index * width,
        curve: Curves.linear, duration: const Duration(milliseconds: 150));
  }

  void _moveUp() {
    //Add logic here
    double width = MediaQuery.of(context).size.width;

    if (index >= Features.length - 1) {
      return;
    }
    index += 1;
    _controller.animateTo(index * width,
        curve: Curves.linear, duration: Duration(milliseconds: 150));
  }

  Widget buildScreens(Feature screen) {
    var i = count++ % 3;
    double width = MediaQuery.of(context).size.width;
    return Container(
        key: Key("slist$i"),
        width: width,
        padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(screen.url), fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: SEARCH_BAR_HEIGHT + 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 250),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTypography(
                          "#${screen.tag}",
                          type: TextTypes.button,
                          bold: true,
                          color: ThemeColors["blue"]!,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        AppTypography(
                          screen.announcement,
                          type: TextTypes.banner,
                          bold: true,
                          color: ThemeColors["blue"]!,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 190),
                          child: AppTypography(
                            screen.description,
                            color: greyColor,
                            type: TextTypes.emphasis,
                          ),
                        ),
                        SizedBox(
                          height: screen.announcement.length > 20 ? 15 : 30,
                        ),
                        Row(
                          children: [
                            Button(
                              onClick: () {},
                              child: screen.label,
                              color: ThemeColors["blue"]!,
                            )
                          ],
                        )
                      ],
                    )),
                AppStepper(
                  number: 3,
                  index: i,
                )
              ],
            ),
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragEnd: _scrollListener,
        onHorizontalDragUpdate: dragUpdate,

        // fairly complex way of implementing multi screen onboarding without having to create them
        // we should not have too many screens it will pollute our project
        // the idea is that we have a horizontal list that snaps to screens as it is scrolled

        child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            // this is just to reduce the amount of repitition we need to make in the building of the screen
            // instead of having
            /* [
             IntroScreen(...),
             IntroScreen(...)
             ]

             we just map through all the views

            */
            children: List.from(Features.map<Widget>(buildScreens))));
  }
}


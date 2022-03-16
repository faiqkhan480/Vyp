import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/components/add_favorite_dialog.dart';
import 'package:vyv/controllers/favorite_controller.dart';
import 'package:vyv/widgets/appbar_widget.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

const List<String> images = [
  "assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg",
  "assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg",
  "assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg",
  "assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg"
];

class FavoritesScreen extends GetView<FavoriteController> {
  // const FavoritesScreen({Key? key}) : super(key: key);

  // FavoriteController controller = Get.put(FavoriteController());

  void handleClick() {
    print(controller);
    Get.dialog(AddFavorite(controller), barrierDismissible: true, useSafeArea: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        child: IconButton(onPressed: handleClick, icon: SvgPicture.asset("assets/images/svgs/plus.svg"))
      ),

      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          imagesGrid("All"),
          imagesGrid("Paddle\nLisboa"),
        ],
      )
    );
  }

  Widget imagesGrid(text) {
    return Column(
      children: [
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemBuilder: (context, index) => Image.asset(images.elementAt(index), fit: BoxFit.cover,),
            itemCount: images.length,
          ),
        ),
        VerticalSpace(5),
        TextWidget(text: text, size: 1.8,)
      ],
    );
  }
}

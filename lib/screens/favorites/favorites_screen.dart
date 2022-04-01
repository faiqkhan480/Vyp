import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/components/add_favorite_dialog.dart';
import 'package:vyv/controllers/favorite_controller.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';
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
    Get.dialog(AddFavorite(controller: controller,), barrierDismissible: true, useSafeArea: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        child: IconButton(onPressed: handleClick, icon: SvgPicture.asset("assets/images/svgs/plus.svg"))
      ),

      body: Obx(() => (controller.loading() && controller.folders.isEmpty) ?
      Center(child: CircularProgressIndicator(),) :
      GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: List.generate(
            controller.folders.length + 1,
                (index) => index == 0 ?
                imagesGrid(controller.folders.elementAt(0), isAll: true) :
                imagesGrid(controller.folders.elementAt(index-1))
        ),
        // children: [
        //   imagesGrid("All"),
        //   imagesGrid("Paddle\nLisboa"),
        // ],
      )
      ));
  }

  Widget imagesGrid(Folder folder, {bool? isAll}) {
    List<Favorite> _listFav = [];
    if(isAll == true) {
      controller.folders.forEach((element) {
        _listFav.addAll(element.favorites!);
      });
    }
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.FOLDER, arguments: isAll == true ? _listFav : folder, id: 1),
      child: Column(
        children: [
          // Icon(Icons.folder_open_rounded, size: 100, color: AppColors.grey,),
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
              // itemBuilder: (context, index) => Image.asset(images.elementAt(index), fit: BoxFit.cover,),
              itemBuilder: (context, index) => folder.favorites!.length > index ?
              Image.network(folder.favorites!.elementAt(index).imageStr!,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image_rounded, color: AppColors.grey, size: 60,),
              ) : Icon(Icons.wallpaper_rounded, color: AppColors.grey, size: 60,),
              // itemCount: folder.favorites!.length >= 4 ? 4 : folder.favorites!.length,
              itemCount: 4,
            ),
          ),
          VerticalSpace(5),
          TextWidget(text: isAll == true ? "All" : folder.folderName, size: 1.8,)
        ],
      ),
    );
  }
}

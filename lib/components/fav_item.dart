import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/favorite_controller.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/widgets/text_component.dart';

class FavoriteItem extends StatelessWidget {
  final num? index;
  final int folderId;
  final Favorite? item;
  const FavoriteItem(this.folderId, {Key? key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg"),
          // image: NetworkImage(item?.imageStr ?? ""),
          // onError: (exception, stackTrace) => AssetImage("assets/images/svgs/no_img.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
              BlendMode.colorBurn),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      // height: 100,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if(Get.find<FavoriteController>().loading() && Get.find<FavoriteController>().currIndex.value == index)
                SizedBox(height: 25, width: 25, child: CircularProgressIndicator())
              else
                InkWell(child: SvgPicture.asset("assets/images/svgs/info.svg"), onTap: handleClick),
            ],
          )
        ],
      )),
    );
  }

  handleClick() {
    Get.bottomSheet(
      Container(
          color: AppColors.secondaryColor,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Wrap(
            children: List.generate(
              2, (i) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: i == 1 ?
                  Icon(Icons.delete_forever_rounded, color: AppColors.grey,) :
                  SvgPicture.asset("assets/images/svgs/info.svg", color: AppColors.grey,),
                  title: TextWidget(
                    text: i == 0 ? "more_info" : "delete",
                    size: 1.8,
                  ),
                  dense: true,
                  onTap: () {
                    if(i == 0) {
                      Get.back(closeOverlays: true);
                      Get.toNamed(AppRoutes.INFO, arguments: new Spot(id: item!.idSpot), id: 1);
                    } else
                      Get.find<FavoriteController>().deleteFav(item!, folderId, index);
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Divider(thickness: 1, height: 1,),
                )
              ],
            ),
            ),
          ),
      ),
      isDismissible: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      enableDrag: false,
    );
  }
}

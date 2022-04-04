import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/constants.dart';

class FavoriteItem extends StatelessWidget {
  final num? index;
  final Favorite? item;
  const FavoriteItem({Key? key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Constants.imgUrl),
          // image: NetworkImage(item?.imageStr ?? ""),
          onError: (exception, stackTrace) => AssetImage(Constants.imgUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
              BlendMode.colorBurn),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      // height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(child: SvgPicture.asset("assets/images/svgs/info.svg"), onTap: () {
                Get.back(closeOverlays: true);
                Get.toNamed(AppRoutes.INFO, arguments: new Spot(id: item!.idSpot), id: 1);
              },),
              // InkWell(child: SvgPicture.asset("assets/images/svgs/vertical_circles.svg"), onTap:,),
            ],
          )
        ],
      ),
    );
  }
}

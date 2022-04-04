import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vyv/components/fav_item.dart';
import 'package:vyv/components/spot_card.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/appbar_widget.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class FolderScreen extends StatelessWidget {
  final Folder? folder;
  final List<Favorite>? favorites;
  const FolderScreen({Key? key, this.folder, this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(text: folder?.folderName ?? "All", size: 4.8, weight: FontWeight.w700,),
          ),
          // VerticalSpace(5),
          Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemBuilder: (context, index) => FavoriteItem(
                  index: index,
                  item: favorites != null ? favorites!.elementAt(index) : folder!.favorites!.elementAt(index),
                ),
                // itemBuilder: (context, index) => Image.network(
                //   favorites != null ? favorites!.elementAt(index).imageStr! : folder!.favorites!.elementAt(index).imageStr!,
                //   errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg", fit: BoxFit.cover,),
                //   errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image_rounded, color: AppColors.grey, size: 60,),
                // ),
                itemCount: favorites != null ? favorites?.length ?? 0 : folder?.favorites?.length ?? 0,
              ),
          )
        ],
      ),
    );
  }
}

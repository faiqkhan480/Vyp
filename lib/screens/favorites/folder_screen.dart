import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/components/fav_item.dart';
import 'package:vyv/controllers/favorite_controller.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/appbar_widget.dart';
import 'package:vyv/widgets/text_component.dart';

class FolderScreen extends StatefulWidget {
  final Folder? folder;
  final List<Favorite>? favorites;
  const FolderScreen({Key? key, this.folder, this.favorites}) : super(key: key);

  @override
  _FolderScreenState createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  FavoriteController _controller = Get.find<FavoriteController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller.fetchAllFavorites(widget.folder!.folderId);
  }

  @override
  void dispose() {
    _controller.clearFavorites();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),

      body:
      Obx(() =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(text: widget.folder?.folderName ?? "all", size: 4.8, weight: FontWeight.w700,),
          ),
          // VerticalSpace(5),

          if(_controller.loading() && _controller.favorites.isEmpty)
            Center(child: CircularProgressIndicator())
          else if(_controller.favorites.isNotEmpty)
            Flexible(
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: _controller.favorites.length,
                itemBuilder: (context, index) {
                  // Folder _folder = _controller.folders.firstWhere((_folder) => _folder.folderName! == _controller.favorites.elementAt(index).favoriteName!);
                  return FavoriteItem(
                    widget.folder?.folderId ?? 0,
                    index: index,
                    item: _controller.favorites.elementAt(index),
                    // item: widget.favorites != null ? widget.favorites!.elementAt(index) : widget.folder!.favorites!.elementAt(index),
                  );
                }
              ),
          )
          else
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, color: AppColors.grey, size: 100,),
                TextWidget(text: "no_fav_items", size: 2.8, color: AppColors.grey,),
              ],
            ))
        ],
      ),
      )
    );
  }
}

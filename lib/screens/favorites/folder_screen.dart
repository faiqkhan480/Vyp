import 'package:flutter/material.dart';
import 'package:vyv/components/fav_item.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/widgets/appbar_widget.dart';
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
                  folder!.folderId!,
                  index: index,
                  item: favorites != null ? favorites!.elementAt(index) : folder!.favorites!.elementAt(index),
                ),
                itemCount: favorites != null ? favorites?.length ?? 0 : folder?.favorites?.length ?? 0,
              ),
          )
        ],
      ),
    );
  }
}

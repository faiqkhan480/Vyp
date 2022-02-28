import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/text_component.dart';

// class SearchBottomSheet extends GetView<SearchController> {
class SearchBottomSheet extends StatelessWidget {
  // const SearchBottomSheet({Key? key}) : super(key: key);

  SearchController controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    print(controller.districts);
    return Container(
      color: AppColors.secondaryColor,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
          itemBuilder: (context, index) => TextWidget(text: "controller.districts.elementAt(index).districtName"),
        itemCount: 0,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vyp/utils/constants.dart';
import 'package:vyp/widgets/text_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        title: TextWidget(
          text: Constants.appName,
          color: AppColors.primaryColor,
          size: 5,
          align: TextAlign.center,
          family: 'GemunuLibre',
        ),
        actions: [IconButton(onPressed: () => null, icon: Icon(Icons.menu, color: Colors.black,))],
        flexibleSpace: Container(child: TextWidget(
          text: "lisbon",
          color: AppColors.primaryColor,
          size: 5,
          align: TextAlign.center,
        ),),
      ),
    );
  }
}

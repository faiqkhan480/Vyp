import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyp/utils/constants.dart';
import 'package:vyp/utils/size_config.dart';
import 'package:vyp/widgets/input_field.dart';
import 'package:vyp/widgets/space.dart';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/svgs/pin.svg", height: SizeConfig.heightMultiplier * 1.8,),
              HorizontalSpace(8),
              TextWidget(
                text: "lisbon",
                // color: AppColors.primaryColor,
                size: 1.8,
                // align: TextAlign.center,
              ),
            ],
          ),),
          preferredSize: Size(double.infinity, 30),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              placeHolder: "what_r_u_looking_for",
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/images/svgs/rocket.svg"),
              ),
            ),
            VerticalSpace(15),
            InputField(
              placeHolder: "where",
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/images/svgs/location.svg"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

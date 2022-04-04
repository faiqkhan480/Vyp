import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class GuidesListing extends StatelessWidget {
  final String? title;
  const GuidesListing({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: Constants.appName,
              color: AppColors.primaryColor,
              size: 5,
              align: TextAlign.center,
              family: 'GemunuLibre',
            ),
            TextWidget(
              text: title,
              // color: AppColors.primaryColor,
              size: 3,
              align: TextAlign.center,
              // family: 'GemunuLibre',
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => card(),
          itemCount: 10,
      ),
    );
  }

  Widget card() {
    return InkWell(
      onTap: () => Get.to(() => GuideDetail(title: title,), id: title == 'Events' ? 4 : 3),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.asset("assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg", height: 140, fit: BoxFit.cover,),
            ),
            TextWidget(text: "Buskin North", size: 2.2, weight: FontWeight.w700,),
            Row(
              children: [
                ...List.generate(5, (index) => Icon(Icons.star_rate_rounded, color: Colors.amber,)),
                Spacer(),
                TextWidget(text: "(2001 reviews)", color: AppColors.grey,),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GuideDetail extends StatelessWidget {
  final String? title;
  const GuideDetail({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: TextWidget(
          text: "Buskin North",
          size: 3,
          align: TextAlign.center,
          // family: 'GemunuLibre',
        ),
        leading: IconButton(onPressed: () => Get.back(canPop: true, id: title == 'Events' ? 4 : 3), icon: SvgPicture.asset("assets/images/svgs/arrow_backward.svg")),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg", height: 300, fit: BoxFit.cover,),
            VerticalSpace(20),
            TextWidget(text: "Buskin North", size: 5.2, weight: FontWeight.w700,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...List.generate(5, (index) => Icon(Icons.star_rate_rounded, color: Colors.amber,)),
                TextWidget(text: "(2001 reviews)", weight: FontWeight.w700,),
              ],
            ),
            VerticalSpace(20),
            TextWidget(text: "About", size: 2.2, weight: FontWeight.w700,),
            VerticalSpace(20),
            TextWidget(text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.",),
            VerticalSpace(20),
            TextWidget(text: "Gallery", size: 2.2, weight: FontWeight.w700,),
            VerticalSpace(20),
            Wrap(
              children: List.generate(5, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg", height: 100, width: 100, fit: BoxFit.cover,),
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

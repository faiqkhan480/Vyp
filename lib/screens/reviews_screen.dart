import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/text_component.dart';

import '../widgets/appbar_widget.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: _body(),
      floatingActionButton: TextButton(
        onPressed: () => null,
        child: Text("See more"),
        style: TextButton.styleFrom(
            primary: AppColors.black,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.grey)
            ),
            textStyle: TextStyle(
              fontSize: SizeConfig.textMultiplier * 1.92,
            )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ITEM TITLE AND IMAGE
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg"),
            ),
            title: TextWidget(
              text: "Tennis de Aigra Nova",
              size: 2.15,
            ),
            subtitle: TextWidget(
              text: "Cascais, Lisboa",
              weight: FontWeight.w300,
              size: 1.92,
            ),
          ),

          // RATINGS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: 3.7,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemSize: 30,
                itemBuilder: (context, _) => SvgPicture.asset("assets/images/svgs/star.svg"),
                onRatingUpdate: (rating) {
                  debugPrint(rating.toString());
                },
              ),
              TextWidget(
                text: "\t\t4.7",
                weight: FontWeight.w700,
                size: 1.92,
              ),
              TextWidget(
                text: "\t\t\t\t\t\t\t\t(10,439)",
                weight: FontWeight.w300,
                size: 1.92,
              ),
            ],
          ),

          Container(
            decoration: BoxDecoration(border: Border(left: BorderSide(color: AppColors.greyScale))),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Share a comment about this place (200)",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: SizeConfig.textMultiplier * 1.92,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(3, (index) => Padding(
              padding: EdgeInsets.only(right: (index == 2) ? 10 : 5, left: 5, top: 10),
              child: TextButton(
                onPressed: () => null,
                child: Text(index == 0 ? 'Save' : index == 1 ? "Edit" : "Delete"),
                style: TextButton.styleFrom(
                    primary: AppColors.black,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.grey)
                    ),
                    textStyle: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.92,
                    )
                ),
              ),
            )),
          ),

          // COMMENTS
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextWidget(
                  text: "10,439 comments",
                  weight: FontWeight.w300,
                  size: 1.92,
                ),
                Divider(thickness: 1, height: 1.8),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: "Pedro Costa",
                        weight: FontWeight.w700,
                        size: 1.92,
                      ),
                      Spacer(),
                      ...List.generate(5, (index) => SvgPicture.asset("assets/images/svgs/star.svg", color: AppColors.yellow, height: 16),),

                      TextWidget(
                        text: "\t\t\t\t06/2022",
                        weight: FontWeight.w300,
                        size: 1.92,
                      ),
                    ],
                  ),
                ),

                TextWidget(
                  text: "Campos de padel com tapetes novos.Bar de apoio muito bom com pessoas muito simpáticas a servir.Só tem um senão,os balneários precisam de ser remodelados",
                  weight: FontWeight.w300,
                  size: 1.92,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

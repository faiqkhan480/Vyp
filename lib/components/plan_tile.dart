import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/text_component.dart';

class PlanTile extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool bottomBorder;
  const PlanTile({Key? key, this.onPressed, this.bottomBorder = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      text: "3:30 PM",
                      size: 2 ,
                      weight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      align: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextWidget(
                      text: "\tPlaying with friends",
                      size: 2 ,
                      weight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      text: "1h 00m",
                      size: 1.4 ,
                      align: TextAlign.center,
                      // weight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: TextWidget(
                        text: "\tTenis de Aigra Nova",
                        size: 1.8 ,
                        // weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if(bottomBorder)
              Divider(thickness: 1,),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}

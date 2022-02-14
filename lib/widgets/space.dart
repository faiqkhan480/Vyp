import 'package:flutter/cupertino.dart';

class HorizontalSpace extends StatelessWidget {
  double? value = 0;
  HorizontalSpace(this.value);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value!,);
  }
}

class VerticalSpace extends StatelessWidget {
  double? value = 0;
  VerticalSpace(this.value);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value!,);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyv/widgets/appbar_widget.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

const List<String> images = [
  "https://s3-alpha-sig.figma.com/img/b179/2075/4c6170b80ed1c99dfa50b1e5425dfd11?Expires=1646611200&Signature=AEwcw2iZsYSni0L7VN1obBhHltTB8PFO4yMlIP7zinRZgmMpNroN0uw~zHJBcLEiwJI5VED5GRTuyl4zVMlmeu6wVYoC9zgsNkQoaPO2Uzj-qsANd8pZHb3tx5sKasUqRFtMop7VMT9YryWtsdDB-2jXKnNelpd6WKwAe6ciuLgqthOYWd0mUtWOa1-hwEBzP8iW92vdaNBeCkRlLFn-FLsuw2RLU6wL7Ep07reH1i-k9WRkAHs5iamPdNqpgx7LraZoJfKKeRjAa35GBYUEqYI7hgIModkJaFJy-UUEX1ORTFnU5H-NPnBH1b5NcnMYWPvSkwFgxcYf90wEzUlB~Q__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
  "https://s3-alpha-sig.figma.com/img/f162/89b1/1d377392c2b18f9241259927aad478ed?Expires=1646611200&Signature=UHJ6i2r9guPDjxqvZBsmvczp7uneMSadYOYv1hCAj6crDvI4f63TMFV6DwvcU6-x0~v9xeCdYpkGaEchcM4qocC~Fz8ZlS~OOsdyNnUmPfgtKQTEND7GpvsBxuCkq9LhhQvotl3qA0aKHZ-IOcq4Hl93rkhGSbpeNS2WmnfUMWABYvZ9BxVL8OyHZIHtchs2RvmWwXUhQDY4-SBfboG64jxsRJogfwRHHFZ17~st3VSCSVKiU~CLdBZp3XCwDZpONh4dXnzJtpy~2UecRpVI4hKsUv~ugs0Xlqel3oG4c4496wFFsSrrzuXZGOvgexUJG5-OGmrQjCg2p-wF1S5F0g__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
  "https://s3-alpha-sig.figma.com/img/df31/88ea/f45d2ab35e9205339e8550646dda00f6?Expires=1646611200&Signature=Ja-li-LvfrhC2eLFKuWEJgnDt0sM2l19RAWiA30U1VaLlHgYC4fL9hNabjA1LOoxuDfoLH40mrsrCe8po4bTXZDqDPwa~gAa5gF2M70G3CSmK8LFyQmV1~17dIbEdCXVIoBV~1xL47og2NC8k3q6S448xMPABP6XKf1PSf4yAJwRYnioT7sSoVjKEJjvFiCsk~2FJtc~sbABbj0fbrOCmUuFpo8AW0eV6W6Hntx9DD8xT9vkKCdYtoSPlVfmtujoYl6s8XYX9xPatDOlZ6q1ZfUX~diQk1s-bdnPLMGVU1fpUTXbIQ7A06rgq9OEIOABTtc1RsLwuW8vZuE9rBEIHQ__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
  "https://s3-alpha-sig.figma.com/img/14da/de7a/53bbc93c0f0cc06000d0f846d34c04c0?Expires=1646611200&Signature=Vw0caStosSxsjwDTti140cPIlfSd-WcPU-GIbnHwTM2Z0Qcq0KzPmc5wxe9mEbMGqsEAExHN2GEyxeXiM4QM4HjZ~BHpb5eXuNj8u9ap7ze3MLVGJo84Xp~xkmwHq8WBhL1R6vDv3OqtHVHY96~f2m7ypP-kN-A3WI0ActoIx4GcDjkzwaYpfs-9z3SP3WNXSG--aa5pKyFp82G1QiA-uHsRoWbSEwiE1BXCbBt3StLRcb2L54PqkmafcKgysKv24HgHxbaQIJb0DYX42YljrWAzoFUrpzag8JnzZL4-ASjrRVYPgMoKC4PDtAsihuy5RoaqTupX3MdvS8qfzOYGtQ__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA"
];

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        child: IconButton(onPressed: () => null, icon: SvgPicture.asset("assets/images/svgs/plus.svg"))
      ),

      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          imagesGrid("All"),
          imagesGrid("Paddle\nLisboa"),
        ],
      )
    );
  }

  Widget imagesGrid(text) {
    return Column(
      children: [
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemBuilder: (context, index) => Image.network(images.elementAt(index), fit: BoxFit.cover,),
            itemCount: images.length,
          ),
        ),
        VerticalSpace(5),
        TextWidget(text: text, size: 1.8,)
      ],
    );
  }
}

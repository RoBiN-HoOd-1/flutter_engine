import '../../../Utils/exports.dart';

class GlassBanner extends StatelessWidget {
  const GlassBanner(
      {Key? key,
      this.child,
      required this.imageUrl,
      required this.padding,
      required this.headerText,
      required this.footerText,
      required this.icon,
      required this.colorData})
      : super(key: key);
  final child;
  final String imageUrl;
  final String headerText;
  final String footerText;
  final bool icon;
  final double padding;
  final String colorData;

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    return Container(
      height: s.height * 0.2,
      width: s.width,
      decoration: BoxDecoration(
          color: colorData.isNotEmpty && imageUrl.isEmpty
              ? Color(int.parse(colorData))
              : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.all(10 ?? 0),
      child: Stack(children: [
        FrostedGlassBox(
          margin: const EdgeInsets.all(5),
          theHeight: s.height,
          theWidth: s.width,
          imageUrl: imageUrl,
          colorData: colorData,
        ),
        Positioned(
            top: s.height * 0.05,
            left: s.width * 0.14,
            child: Text(headerText)),
        Positioned(
            top: s.height * 0.12,
            left: s.width * 0.14,
            child: Text(footerText)),
      ]),
    );
  }
}

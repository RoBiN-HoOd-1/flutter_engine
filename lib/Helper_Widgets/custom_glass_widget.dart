import 'dart:ui';
import 'package:engine/Utils/exports.dart';




class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox(
      {Key? key,
      this.theWidth,
      this.theHeight,
      this.theChild,
      this.margin,
      this.borderOpacity,
      this.elevate,
      required this.imageUrl,
      required this.colorData})
      : super(key: key);

  final theWidth;
  final theHeight;
  final theChild;
  final margin;
  final elevate;
  final borderOpacity;
  final String imageUrl;
  final String colorData;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<BusinessLogic>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: theWidth,
        height: theHeight,
        padding: margin,
        // color: Color(int.parse(colorData.replaceAll('#', '0x'))),
        //we use Stack(); because we want the effects be on top of each other,
        //  just like layer in photoshop.
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  // Image is fully loaded.
                  return child;
                } else {
                  // Image is still loading, show a loading indicator.
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                }
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                // An error occurred while loading the image. Display an error message.
                return Center(
                  child: imageUrl.isNotEmpty ? Placeholder() : Container(),
                );
              },
            ),
            //blur effect ==> the third layer of stack
            BackdropFilter(
              filter: ImageFilter.blur(
                //sigmaX is the Horizontal blur
                sigmaX: 4.0,
                //sigmaY is the Vertical blur
                sigmaY: 4.0,
              ),
              //we use this container to scale up the blur effect to fit its
              //  parent, without this container the blur effect doesn't appear.
              child: Card(
                color: Colors.transparent,
                elevation: elevate ?? 1,
                // shadowColor: Colors.blueGrey,
              ),
            ),
            //gradient effect ==> the second layer of stack
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: themeProvider.darkTheme
                        ? Colors.black.withOpacity(borderOpacity ?? 1)
                        : Colors.white.withOpacity(borderOpacity ?? 1)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      //begin color
                      Colors.white.withOpacity(0.15),
                      //end color
                      Colors.white.withOpacity(0.05),
                    ]),
              ),
            ),
            //child ==> the first/top layer of stack
            Center(child: theChild),
          ],
        ),
      ),
    );
  }
}

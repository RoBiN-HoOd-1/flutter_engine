import '../../../Utils/exports.dart';

Widget boxGridTile(width, height, String link, String title, BuildContext ctx) {
  return FrostedGlassBox(
    theHeight: height * 0.1,
    theWidth: width * 0.25,
    imageUrl: '',
    margin: EdgeInsets.all(5).add(EdgeInsets.only(left: 5)),
    colorData: '',
    theChild: SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: height * 0.08,
            width: width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(ctx).colorScheme.onBackground,
                width: 2.0, // Border width
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                link,
                fit: BoxFit.fill,
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
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // An error occurred while loading the image. Display an error message.
                  return Center(
                    child: Placeholder(),
                  );
                },
              ),
            ),
          ),
          Container(
            width: width * 0.23,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: width / 37,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    ),
  );
}

Widget circleGridTile(
    width, height, String link, String title, BuildContext ctx) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Ensures that the container is a circle
          border: Border.all(
            color: Theme.of(ctx).colorScheme.onBackground,
            width: 2.0, // Border width
          ),
        ),
        child: CircleAvatar(
          backgroundImage: NetworkImage(link),
          radius: width * 0.1,
          onBackgroundImageError: (exception, stackTrace) {
            // Handle the error here
            // return Placeholder();
            print('Error loading foreground image: $exception');
          },
        ),
      ),
      Container(
        width: width * 0.23,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: width / 37,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      )
    ],
  );
}

class CustomCircleAvatar extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final Color backgroundColor;
  final Widget errorWidget;

  CustomCircleAvatar({
    required this.radius,
    required this.imageUrl,
    this.backgroundColor = Colors.transparent,
    required this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: NetworkImage(imageUrl),
      child: _buildImageOrErrorWidget(),
    );
  }

  Widget _buildImageOrErrorWidget() {
    return Builder(
      builder: (context) {
        try {
          return Container(); // No error, display the image
        } catch (e) {
          return Placeholder(); // Image loading error, display the error widget
        }
      },
    );
  }
}

// ignore_for_file: unnecessary_null_comparison
import 'package:engine/Screens/Homepage/Homepage_Helpers/carousel_widget.dart';
import 'Homepage_Helpers/horizontal_list_widget.dart';
import '../../Utils/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> animation;
  bool cirAnimate = false;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    animationController.forward();
    super.initState();
  }

  final player = AudioPlayer();

  Future<void> playAudio() async {
    await player.play(
      Elements.switchOff,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<BusinessLogic>(context);
    var size = MediaQuery.of(context).size;
    return cirAnimate
        ? CircularRevealAnimation(
            centerOffset: Offset(size.width, size.height / 15),
            animation: animation,
            child: MyHomeBody(dataProvider, 'UI Rendering Engine', size),
          )
        : MyHomeBody(dataProvider, 'UI Rendering Engine', size);
  }

  // List<String> title = [
  //   "Vegan",
  //   "Meat Based",
  //   "Breakfast",
  //   "Vegetable",
  //   "Fruits",
  // ];
  //
  // List<String> type = ["circular_item", "box_item"];
  //
  // List<String> links = [
  //   "https://picsum.photos/id/61/100/110",
  //   "https://picsum.photos/id/72/100/110",
  //   "https://picsum.photos/id/83/100/110",
  //   "https://picsum.photos/id/94/100/110",
  //   "https://picsum.photoss/id/10/100/110",
  // ];

  Widget MyHomeBody(BusinessLogic dataProvider, title, Size s) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                playAudio();
                setState(() {
                  cirAnimate = true;
                  dataProvider.darkTheme = !dataProvider.darkTheme;
                });
                if (animationController.status == AnimationStatus.forward ||
                    animationController.status == AnimationStatus.completed) {
                  animationController.reset();
                  animationController.forward();
                } else {
                  animationController.forward();
                }
                // print("https://picsum.photos/${s.width }/${s.height* 0.2}");
              },
              icon: dataProvider.darkTheme
                  ? Icon(Icons.nightlight_outlined)
                  : Icon(Icons.light_mode_outlined),
              label: dataProvider.darkTheme
                  ? Text('Dark Theme')
                  : Text('Light Theme'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: s.height * 1.7,
            width: s.width,
            child: Column(
              children: [
                heading(s.height, s.width, "Cuisine"),
                circleCategoryGridView(
                    s.height, s.width, context, dataProvider.cuisineData),
                CustomCarouselSlider(),
                heading(s.height, s.width, "Collection"),
                boxCategoryGridView(
                    s.height, s.width, context, dataProvider.collectionData),
                heading(s.height, s.width, "Banners"),
                Expanded(
                    // height: s.height * 1,
                    child: bannerArea(dataProvider.bannerData, s.height)),
              ],
            ),
          ),
        ));
  }

  //categoryGridView0- homePage Widget
  Widget circleCategoryGridView(_height, _width, context, Widgets data) {
    return Container(
      padding: EdgeInsets.only(top: _height * 0.008, left: 4),
      height: _height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.items!.length,
        itemBuilder: (context, index) {
          return circleGridTile(_width, _height, data.items![index].image,
              data.items![index].text, context);
        },
      ),
    );
  }

  //categoryGridView0- homePage Collections Widget
  Widget boxCategoryGridView(_height, _width, context, Widgets data) {
    return Container(
      padding: EdgeInsets.only(top: _height * 0.008),
      height: _height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.items!.length,
        itemBuilder: (context, index) {
          return boxGridTile(_width, _height, data.items![index].image,
              data.items![index].text, context);
        },
      ),
    );
  }

  Widget bannerArea(List<Widgets> data, h) {
    return ListView.builder(
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GlassBanner(
            imageUrl: data[index].image!,
            padding: data[index].padding!,
            headerText: data[index].headerText!,
            footerText: data[index].footerText!,
            icon: data[index].footerIcon!,
            colorData: data[index].hexaDecimalColorCode!,
          );
        });
  }
}

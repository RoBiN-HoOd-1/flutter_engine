import 'dart:async';
import '../../../Utils/exports.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int currentIndex = 0;
  final PageController controller = PageController();

  List<Widgets> slide = [
    Widgets(
        type: "Banner",
        headerText: "Meal Planner",
        footerText: "Plan your meals",
        image: "https://picsum.photos/id/44/450/200",
        hexaDecimalColorCode: "0x00000000",
        footerIcon: true),
    Widgets(
        type: "Banner",
        headerText: "New Recipe",
        footerText: "Cook chicken Curry",
        image: "https://picsum.photos/id/27/450/200",
        hexaDecimalColorCode: '',
        footerIcon: true),
    Widgets(
        type: "Banner",
        headerText: "New Recipe",
        footerText: "Cook chicken Curry",
        image: "https://picsum.photssos/id/27/450/200",
        hexaDecimalColorCode: '',
        footerIcon: true),
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (currentIndex < slide.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      controller.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return SizedBox(
      height: s.height * 0.34,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: s.height * 0.22,
            width: double.infinity,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index % slide.length;
                });
              },
              itemBuilder: (context, index) {
                return GlassBanner(
                  child: Image.network(slide[index % slide.length].image!,
                      fit: BoxFit.cover),
                  imageUrl: slide[index % slide.length].image!,
                  padding: 10,
                  headerText: slide[index % slide.length].headerText!,
                  footerText: slide[index % slide.length].footerText!,
                  icon: slide[index % slide.length].footerIcon!,
                  colorData: slide[index % slide.length].hexaDecimalColorCode!,
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < slide.length; i++)
                buildIndicator(currentIndex == i)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    controller.jumpToPage(currentIndex - 1);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    controller.jumpToPage(currentIndex + 1);
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 13 : 10,
        width: isSelected ? 13 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}

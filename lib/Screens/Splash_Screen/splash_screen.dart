import '../../Utils/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double startPos = -1.0;
  double endPos = 0.0;
  Curve curve = Curves.elasticOut;

  late final AnimationController _controller;
  final player = AudioPlayer();

  Future<void> playAudio() async {
    await player.play(
      Elements.splash,
    );
  }

  @override
  void initState() {
    playAudio();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    loadAsset(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(startPos, 1), end: Offset(endPos, 0)),
      duration: const Duration(seconds: 3),
      curve: curve,
      builder: (context, offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: child,
            ),
          ),
        );
      },
      child: Image.asset(
        Elements.logo,
        fit: BoxFit.scaleDown,
      ),
      onEnd: () {
        curve =
            curve == Curves.elasticOut ? Curves.elasticIn : Curves.elasticOut;
        if (startPos == -1) {
          setState(() {
            startPos = 0.0;
            endPos = 1.0;
          });
        }
        Future.delayed(
          const Duration(seconds: 3),
          () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(),
              ),
            );

            // Get.off(() => const MyHomePage(),
            //     transition: Transition.circularReveal);
          },
        );
      },
    );
  }
}

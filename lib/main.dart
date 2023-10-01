import 'Utils/exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late Animation _colorAnimate;
  BusinessLogic themeChangeProvider = new BusinessLogic();
  bool switchValue = false;

  void getCurrentTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.preference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _colorAnimate = ColorTween(begin: Colors.black38, end: Colors.deepPurple)
        .animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => themeChangeProvider,
          )
        ],
        child: Consumer<BusinessLogic>(
          builder:
              (BuildContext context, BusinessLogic value, Widget? child) =>
                  MaterialApp(
            title: 'Flutter Demo',
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              useMaterial3: true,
            ),
            themeMode: themeChangeProvider.darkTheme
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: AnimatedBuilder(
                builder: (ctx, _) => Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: _colorAnimate.value,
                  child: const SplashScreen(),
                ),
                animation: _colorAnimate,
              ),
            ),
          ),
        ));
  }
}

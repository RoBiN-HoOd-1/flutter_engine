import '../Utils/exports.dart';

class BusinessLogic with ChangeNotifier {
  bool _darkTheme = false;

  ThemePreference preference = ThemePreference();

  late ConsumeHomePageJsonModel _data;
  late Widgets _collectionData;
  late Widgets _cuisineData;
  late List<Widgets> _bannerData;

  bool get darkTheme => _darkTheme;

  ConsumeHomePageJsonModel get data => _data;

  Widgets get collectionData => _collectionData;

  Widgets get cuisineData => _cuisineData;

  List<Widgets> get bannerData => _bannerData;

  void fetchData(ConsumeHomePageJsonModel freshData) {
    _data = freshData;
    unComplicate(); //using these method to divide the whole master data into parts for easy implementation
    notifyListeners();
  }

  void unComplicate() {
    _collectionData = _data.widgets
        .firstWhere((element) => element.title!.contains("Collections"));
    _cuisineData = _data.widgets
        .firstWhere((element) => element.title!.contains("Cuisines"));
    _bannerData = _data.widgets
        .where((element) => element.type.contains("banner"))
        .toList();
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    preference.setTheme(value);
    notifyListeners();
  }
}

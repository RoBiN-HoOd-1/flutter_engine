import '../../Utils/exports.dart';

Future<ConsumeHomePageJsonModel> loadAsset(ctx) async {
  // Load the JSON asset file
  final jsonString = await rootBundle.loadString('assets/Files/dummyData.json');

  // Parse the JSON data
  final ConsumeHomePageJsonModel jsonData =
      consumeHomePageJsonModelFromJson(jsonString);

  Provider.of<BusinessLogic>(ctx,listen: false).fetchData(jsonData);
  // Return the parsed JSON data as a Map
  return jsonData;
}

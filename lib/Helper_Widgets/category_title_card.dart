//heading- homePage Widget
import '../Utils/exports.dart';

Widget heading(h, w, String title) {
  return Container(
    height: h * 0.06,
    padding: EdgeInsets.only(
        top: h * 0.01,  left: w * 0.05),
    width: w,
    alignment: Alignment.topLeft,
    child: Text(
      title,
      style: TextStyle(
        fontFamily: "Poppins-Regular",
        fontWeight: FontWeight.bold,
        fontSize: 19,
      ),
    ),
  );
}

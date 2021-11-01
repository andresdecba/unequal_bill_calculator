import 'package:flutter/material.dart';

class TopScreenBG extends StatelessWidget {
  const TopScreenBG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ////// get screen size //////
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return CustomPaint(
      size: Size(
        // width size
        queryData.size.width,
        // height size
        queryData.size.height / 2,
      ),
      painter: MyPainter(queryData),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this.queryData);
  MediaQueryData queryData;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      // offset from width center (-25 to compensing the padding displasment)
      (queryData.size.width / 2) - 25,

      // offset from height center
      -(queryData.size.height / 2),
    );

    final radius = queryData.size.height;
    final paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
    //throw UnimplementedError();
  }
}

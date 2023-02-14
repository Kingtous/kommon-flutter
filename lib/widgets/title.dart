part of widgets;

class KTitle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String title;
  final double fontSize;

  const KTitle(
      {Key? key,
      this.width = 5,
      this.height = 25,
      this.color = Colors.lightBlue,
        this.fontSize = 18.0,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: const BoxDecoration(color: Colors.lightBlue),
        ),
        Expanded(
            child: Text(title,
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)))
      ],
    );
  }
}


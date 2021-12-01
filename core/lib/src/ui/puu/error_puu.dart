part of 'puu.dart';

const double _sizeInPx = 250;

class ErrorPuu extends StatelessWidget {
  final String title;
  final String body;

  const ErrorPuu({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            Image(image: Puus.pissed, width: _sizeInPx, height: _sizeInPx),
            Text(
              title,
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(body),
          ],
        ),
      ),
    );
  }
}

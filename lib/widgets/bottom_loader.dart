import 'package:avto_baraka/screen/imports/imports_announcement.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(
            strokeWidth: 1.5, color: iconSelectedColor),
      ),
    );
  }
}

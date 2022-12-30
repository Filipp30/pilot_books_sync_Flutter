import 'package:flutter/material.dart';

class BookButton extends StatelessWidget {
  final String title;
  final Function callBack;
  const BookButton({required this.title, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => callBack(),
        splashColor: Colors.black26,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(image: const AssetImage('assets/book.jpg'), height: 100, width: 100, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(title, style: const TextStyle(fontSize: 30, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

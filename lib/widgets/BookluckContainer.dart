import 'package:flutter/material.dart';

class BookluckContainer extends StatelessWidget {
  final double heightFactor;

  const BookluckContainer({
    Key? key,
    required this.heightFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * heightFactor, // 8.18% of screen height
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Center(
        child: Container(
          width: 328,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Container(
                height: 34,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Image.asset(
                  'assets/images/bookluck.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 144),
              Container(
                width: 43,
                height: 34,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/mail.png',
                      fit: BoxFit.contain,
                      width: 24,
                    ),
                    const SizedBox(width: 7),
                    const Text(
                      '1',
                      style: TextStyle(
                        color: Color(0xFF303030),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

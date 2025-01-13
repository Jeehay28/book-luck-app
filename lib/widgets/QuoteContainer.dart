import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class QuoteContainer extends StatelessWidget {
  final double bodyHeight;
  final double bodyWidth;

  const QuoteContainer({
    Key? key,
    required this.bodyHeight,
    required this.bodyWidth,
  }) : super(key: key);

  // This method will be called when the login button is pressed
  Future<void> _fetchDataAndNavigate(BuildContext context) async {
    // Extract email and password from the TextEditingController
    // final email = _emailController.text;
    // final password = _passwordController.text;

    // // Create the request body
    // final requestBody = jsonEncode({
    //   'email': email,
    //   'password': password,
    // });

    try {
      final response = await http.get(
        Uri.parse('http://43.202.197.14:8080/phrases'),
        // Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
        headers: {'Content-Type': 'application/json'},
        // body: requestBody,
      );

      if (response.statusCode == 200) {
        // Successfully received a response
        final data = json.decode(response.body);
        print(data); // Just printing to console for now

        // Navigate to RecipeRecommendationPage after successful fetch
      } else {
        // Handle the error if the response status is not 200
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Handle any errors that occurred during the request
      print('Error: $error');
      // Optionally, show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.1721 * bodyHeight,
        width: 0.8889 * bodyWidth, // 17.21% of screen height, 122,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent, // Border color
            width: 1, // Border width
          ),
          color: Colors.transparent, // Transparent background
          borderRadius:
              BorderRadius.all(Radius.circular(0)), // Optional: rounded corners
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,

            fixedSize: Size(0.7778 * bodyWidth, 0.1326 * bodyHeight),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                side: BorderSide(
                    color: Color.fromRGBO(48, 48, 48, 0.12), width: 1)),
            elevation:
                0, // Remove shadow to mimic semi-transparent background better
          ),
          onPressed: () {
            // Call _fetchDataAndNavigate when the button is pressed
            _fetchDataAndNavigate(context);
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimize space between items
              children: [
                SvgPicture.asset(
                  'assets/images/warning.svg', // Replace with your image path
                  width: 0.0667 * bodyWidth, // Set the width of the image
                  height: 0.0339 * bodyHeight, // Set the height of the image
                  fit: BoxFit.contain, // Adjust image fit if needed
                ),
                Text(
                  '업데이트된 명언이 없습니다. \n업데이트 전까지 조금만 기다려주세요!',
                  style: TextStyle(
                    color: Color.fromRGBO(48, 48, 48, 0.6),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 60, 0, 0),
              child: Text(
                'See it.\nWant it.\nfurnitAR',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 60.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
              child: Text(
                'Always find the right \nsize furniture',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  height: 1.1,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/get_started_chair.png',
                    height: 420.0,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty<Color>.fromMap(
                      <WidgetStatesConstraint, Color>{
                        WidgetState.any: Colors.black
                      }
                    ),
                    minimumSize: WidgetStateProperty<Size>.fromMap(
                      <WidgetStatesConstraint, Size>{
                        WidgetState.any: Size(350, 60),
                      }
                    )
                  ),
                  child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 17.0,
                        letterSpacing: 0.4
                      ),
                    ),
                ),
            ),
          ],
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'MapApp.dart'; // Import your map screen file
import 'OnboardingVideoScreen.dart';
import 'UserProfilePage.dart'; // Add this import for the UserProfilePage
import 'login_screen.dart';
import 'signup_screen.dart';
import 'package:arwasadiq/OnboardingVideoScreen.dart';
import 'package:arwasadiq/ForgotPasswordScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SecondImageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Splash Screen'),
      // ),
      body: Center(
        child: Container(
         // width: 1,
         //  height: 10,
          child: Image.asset(
            'assets/logo2.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class SecondImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Second Image'),
      // ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LanguageSelectionScreen()),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/logo1.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Select Language'),
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/lang.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(40.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Language',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20,width: 50),
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    items: <String>['English', 'Arabic', 'Spanish', 'French']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Selected Language: $_selectedLanguage');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BoardingScreen()),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Select Language',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  double _linePosition = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _linePosition = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildPage(
                'Quick Booking',
                'Effortlessly book your ideal stay in just a few clicks, saving you time and hassle.',
                'assets/bord1.png',
              ),
              _buildPage(
                'Explore Hotels',
                'Discover a world of accommodations tailored to your preferences, from cozy retreats to luxury getaways.',
                'assets/bord2.png',
              ),
              _buildPage(
                'Secure Reservations',
                'Rest assured with our secure booking platform, ensuring the safety and confidentiality of your transactions.',
                'assets/bord3.png',
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: RibbonPainter(position: _linePosition),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage < 2) {
                  _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingVideoScreen()),
                  );
                }
              },
              child: Text(_currentPage < 2 ? 'Skip' : 'Lets Go!'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title, String description, String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Image.asset(
            imagePath,
            width: 700,
            height: 700,
          ),
        ),
      ],
    );
  }
}

class RibbonPainter extends CustomPainter {
  final double position;

  RibbonPainter({required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    double lineHeight = size.width / 3;

    canvas.drawLine(Offset(position * lineHeight, 0), Offset(position * lineHeight + lineHeight, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



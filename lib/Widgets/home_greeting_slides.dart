import 'dart:async';

import 'package:flutter/material.dart';

class HomeGreetingSlides extends StatefulWidget {
  @override
  State<HomeGreetingSlides> createState() => _HomeGreetingSlidesState();
}

class _HomeGreetingSlidesState extends State<HomeGreetingSlides> {
  int selectedIndex = 0;
  final PageController controller = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (!controller.hasClients) return;
      if (selectedIndex == _buildCards().length - 1) {
        selectedIndex = 0;
      } else {
        selectedIndex++;
      }
      controller.animateToPage(
        selectedIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  List<Widget> _buildCards() {
    return [
      HomeGreetingCard(
        imagePath: 'assets/images/standing.png',
        title: 'The Home Uni App',
        description: 'Get certified and employed \n'
            'at HOME in 3-6 months!',
        buttonText: 'See Courses',
        onButtonPressed: () {
          // TODO: Implement navigation to courses page
        },
      ),
      // Add more cards here using the HomeGreetingCard widget with different content
      HomeGreetingCard(
        imagePath: 'assets/images/sitting.png',
        title: 'New Uni Alternative',
        description: 'Earn industry certifications \n'
            'and boost your career.',
        buttonText: 'Explore More',
        onButtonPressed: () {
          // TODO: Implement action for this button
        },
      ),

      HomeGreetingCard(
        imagePath: 'assets/images/aiclopedia.png',
        title: 'Join Off Campus Groups',
        description: 'Connect with fellow learners,\n'
            ' mentors, and experts.',
        buttonText: 'Explore More',
        onButtonPressed: () {
          // TODO: Implement action for this button
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = _buildCards();

    return Column(
      children: [
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              height: 220,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: PageView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  return cards[index % cards.length];
                },
                itemCount: cards.length * 1000, // Infinitely scrollable
                allowImplicitScrolling: true,
                onPageChanged: (value) {
                  setState(() => selectedIndex = value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HomeGreetingCard extends StatelessWidget {
  const HomeGreetingCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 2),
          height: 200,
          width: 500,
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement navigation to courses page
                  },
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -23,
          right: -25,
          bottom: -25,
          child: Container(
            child: Image.asset(
              imagePath,
            ),
          ),
        ),
      ],
    );
  }
}

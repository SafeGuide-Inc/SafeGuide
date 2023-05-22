import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:safeguide/components/buttons.dart';
import 'package:sizer/sizer.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    await Future.delayed(Duration(seconds: 1));
    _animationController
      ..duration = Duration(milliseconds: 1500)
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.75),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: 5.h,
            child: Image.asset("assets/images/logo.png"),
          )),
      body: FutureBuilder(
        future: _playAnimation(),
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_jbrw3hcz.json',
                width: 500,
                height: 200,
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController
                    ..duration = composition.duration
                    ..forward();
                },
              ),
              const Text(
                'Your report was successfully created, thanks for helping the community!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Button(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    Navigator.of(context).pop();
                  },
                  title: 'Back to home',
                ),
              ),
              SizedBox(height: 20.h),
            ],
          );
        },
      ),
    );
  }
}

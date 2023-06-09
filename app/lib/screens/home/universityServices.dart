import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

class UniversityServices extends StatefulWidget {
  const UniversityServices({Key? key}) : super(key: key);

  @override
  _UniversityServicesState createState() => _UniversityServicesState();
}

class _UniversityServicesState extends State<UniversityServices> {
  final List<Service> services = [
    Service('Suicide and Crisis Hotline', '9-8-8'),
    Service('Emergency', '9-1-1'),
    Service('Poison Control', '(800) 222-1222'),
    Service('UOPD', '(541) 346-2919'),
    Service('Duck Rides', '(541) 346-7433'),
    Service('SAFE Hotline', '(541) 346-7233'),
    Service('UO Counseling (after hours)', '(541) 346-3227'),
    Service('UO Health Services', '(541) 346-2770'),
    Service('Safety and Risk Services', '(541) 346-7008'),
  ];

  Future<void> callService(service) async {
    HapticFeedback.vibrate();
    await FlutterPhoneDirectCaller.callNumber(service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: CustomAppBarContent(),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(children: [
                      ListTile(
                        onTap: () {
                          HapticFeedback.vibrate();
                          callService(services[index].contact);
                        },
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(services[index].name),
                        subtitle: Text(services[index].contact),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      const Divider(color: Colors.grey),
                    ]);
                  },
                  childCount: services.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/uoregon.jpg", // Replace with the path to your local asset image
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                'University of Oregon',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Help services',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Service {
  final String name;
  final String contact;

  Service(this.name, this.contact);
}

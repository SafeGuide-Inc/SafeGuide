import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Service('Safety and Risk Services', '(541) 346-7008, saftey@uoregon.edu'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('University of Oregon Services',
              style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          backgroundColor: Colors.white70,
        ),
        body: ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              return Column(children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
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
            }));
  }
}

class Service {
  final String name;
  final String contact;

  Service(this.name, this.contact);
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:q4k/cs/cs_screen.dart';
import 'package:q4k/is/is_screen.dart';
import 'package:q4k/it/it_screen.dart';
import 'compnents.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'mm/mm_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> sectionName = [
      'IT',
      'CS',
      'IS',
      'MM',
    ];
    List<IconData> iconName = [
      Icons.lan,
      Icons.laptop_sharp,
      Icons.data_array_rounded,
      Icons.display_settings,
    ];
    List<Widget> screens = [
      const IT(),
      const CS(),
      const IS(),
      const MM(),
    ];
    return Scaffold(
      backgroundColor: primaryColor,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50.0), // here the desired height
      //   child: AppBar(
      //     backgroundColor: primaryColor,
      //     title:
      //     centerTitle: true,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Q4K',
            style: TextStyle(
              color: goldenColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'All you want is here',
            style: TextStyle(
              color: goldenColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 400,
            height: 1000,
            child: ListView.builder(
              itemCount: sectionName.length,
              itemBuilder: (context, index) => DepartmentCard(
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => screens[index]));
                  },
                  index: index,
                  icon_name: iconName,
                  section_name: sectionName),
            ),
          ),
        ]),
      ),
    );
  }
}

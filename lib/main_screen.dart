import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:q4k/cs/cs_screen.dart';
import 'package:q4k/is/is_screen.dart';
import 'package:q4k/it/it_screen.dart';
import 'compnents.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'dialog.dart';
import 'mm/mm_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => const MyDialog(),
      );
    });

  }
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
          Text(
            'Q4K',
            style: GoogleFonts.cookie(
              fontSize: 40,
              color: babyBlueColor
            )
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'All you want is here',
            style: GoogleFonts.nunito(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: babyBlueColor
            )
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'shared/constants.dart';

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
    return Scaffold(
      //backgroundColor: primaryColor,
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
              fontSize: 48,
              color: lightColor
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text('All you want is here',
              style: GoogleFonts.cookie(fontSize: 48, color: lightColor)),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 400,
            height: 1000,
            child: ListView.builder(
              itemCount: sectionName.length,
              itemBuilder: (context, index) => Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: goldenColor,
                        width: 2,
                        style: BorderStyle.solid,
                      )),
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: goldenColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Icon(
                            iconName[index],
                            size: 60,
                            color: lightColor,
                          ),
                        ),
                      ),
                      Text(
                        sectionName[index],
                        style: const TextStyle(
                          color: lightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: lightColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
                    style: BorderStyle.solid,
                  )),
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.computer_sharp,
                        color: goldenColor,
                        size: 60,
                      ),
                    ),
                  ),
                  const Text(
                    'CS',
                    style: TextStyle(
                      color: goldenColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: goldenColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.data_array_rounded,
                        size: 60,
                      ),
                    ),
                  ),
                  const Text(
                    'IS',
                    style: TextStyle(
                      color: goldenColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: lightColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.display_settings,
                        size: 60,
                      ),
                    ),
                  ),
                  const Text(
                    'MM',
                    style: TextStyle(
                      color: goldenColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: lightColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

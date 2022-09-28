import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:q4k/cs/cs_screen.dart';
import 'package:q4k/is/is_screen.dart';
import 'package:q4k/it/it_screen.dart';
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

class DepartmentCard extends StatelessWidget {
  const DepartmentCard({
    super.key,
    required this.icon_name,
    required this.section_name,
    required this.index,
    required this.onPress,
  });

  final List<IconData> icon_name;
  final List<String> section_name;
  final int index;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor,
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
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    icon_name[index],
                    size: 60,
                    color: goldenColor,
                  ),
                ),
              ),
              Text(
                section_name[index],
                style: const TextStyle(
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
    );
  }
}

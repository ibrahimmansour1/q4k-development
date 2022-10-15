import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:q4k/cs/cs_screen.dart';
import 'package:q4k/is/is_screen.dart';
import 'package:q4k/it/it_screen.dart';
import 'package:q4k/screens/info_screen.dart';
import 'package:q4k/screens/settings_screen.dart';
import 'package:q4k/screens/sign_in/sign_in.dart';
import 'package:q4k/shared/local/cache_helper.dart';
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
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

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
      //backgroundColor: primaryColor,
      body: SliderDrawer(
        appBar: SliderAppBar(
          appBarColor: Colors.white,
          title: const Text("",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          trailing: InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => InfoScreen())),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                  imageUrl:
                      'https://cdn1.iconfinder.com/data/icons/bootstrap-vol-3/16/info-circle-512.png'),
            ),
          ),
        ),
        key: _key,
        sliderOpenSize: 190,
        slider: _SliderView(
          onItemClick: (title) {
            _key.currentState!.closeSlider();
            setState(() {
              // this.title = title;
            });
          },
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Text('Q4K',
                style: GoogleFonts.nunito(
                  fontSize: 60,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 1,
            ),
            Text('All you want is here',
                style: GoogleFonts.cookie(
                    fontSize: 40,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    color: primaryColor.withOpacity(0.5))),
            // const SizedBox(
            //   height: 10,
            // ),
            SizedBox(
              width: 400,
              height: 500,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
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
      ),
    );
  }
}

class _SliderView extends StatefulWidget {
  final Function(String)? onItemClick;

  _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  State<_SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<_SliderView> {
  String firstLetter = '';
  Future<void> getUserName() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final String userName =
        (await FirebaseFirestore.instance.collection('users').doc(userId).get())
            .data()?['name'];
    if (userName.length > 1) {
      firstLetter = userName.substring(0, 1).toUpperCase();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    log(firstLetter);

    // print(firstLetter);
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 48,
            child: Text(
              firstLetter,
              style: const TextStyle(fontSize: 50),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Welcome',
            style: TextStyle(
              color: lightColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MainScreen())),
            child: _SliderMenuItem(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen())),
              title: 'Home',
              iconData: Icons.home,
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SettingsScreen())),
            child: _SliderMenuItem(
              title: 'Setting',
              iconData: Icons.settings,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen())),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => InfoScreen())),
            child: _SliderMenuItem(
              title: 'About',
              iconData: Icons.info,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InfoScreen())),
            ),
          ),
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await CacheHelper.clearCacheStorage();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
            child: _SliderMenuItem(
              title: 'Sign Out',
              iconData: Icons.arrow_back_ios,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen())),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function onTap;

  const _SliderMenuItem({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
            color: lightColor,
            // fontFamily: 'BalsamiqSans_Regular',
          )),
      leading: Icon(iconData, color: lightColor),
    );
  }
}

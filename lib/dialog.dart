import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<String> hadith = [
    "start",
    "إنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إلَى اللَّهِ وَرَسُولِهِ فَهِجْرَتُهُ إلَى اللَّهِ وَرَسُولِهِ، وَمَنْ كَانَتْ هِجْرَتُهُ لِدُنْيَا يُصِيبُهَا أَوْ امْرَأَةٍ يَنْكِحُهَا فَهِجْرَتُهُ إلَى مَا هَاجَرَ إلَيْه",
    " بُنِيَ الْإِسْلَامُ عَلَى خَمْسٍ: شَهَادَةِ أَنْ لَا إلَهَ إلَّا اللَّهُ وَأَنَّ مُحَمَّدًا رَسُولُ اللَّهِ، وَإِقَامِ الصَّلَاةِ، وَإِيتَاءِ الزَّكَاةِ، وَحَجِّ الْبَيْتِ، وَصَوْمِ رَمَضَانَ",
    "مَنْ أَحْدَثَ فِي أَمْرِنَا هَذَا مَا لَيْسَ مِنْهُ فَهُوَ رَدٌّ",
    "إنَّ الْحَلَالَ بَيِّنٌ، وَإِنَّ الْحَرَامَ بَيِّنٌ، وَبَيْنَهُمَا أُمُورٌ مُشْتَبِهَاتٌ لَا يَعْلَمُهُنَّ كَثِيرٌ مِنْ النَّاسِ، فَمَنْ اتَّقَى الشُّبُهَاتِ فَقْد اسْتَبْرَأَ لِدِينِهِ وَعِرْضِهِ، وَمَنْ وَقَعَ فِي الشُّبُهَاتِ وَقَعَ فِي الْحَرَامِ، كَالرَّاعِي يَرْعَى حَوْلَ الْحِمَى يُوشِكُ أَنْ يَرْتَعَ فِيهِ، أَلَا وَإِنَّ لِكُلِّ مَلِكٍ حِمًى، أَلَّا وَإِنَّ حِمَى اللَّهِ مَحَارِمُهُ، أَلَّا وَإِنَّ فِي الْجَسَدِ مُضْغَةً إذَا صَلَحَتْ صَلَحَ الْجَسَدُ كُلُّهُ، وَإذَا فَسَدَتْ فَسَدَ الْجَسَدُ كُلُّهُ، أَلَا وَهِيَ الْقَلْبُ",
    "end"
  ];
  int _counter=-1;

  Future<void> _getCounter() async {
    const key = "counter";
    final SharedPreferences prefs = await  SharedPreferences.getInstance();
    int counter = prefs.getInt(key) ?? 0;
    if(counter >= hadith.length) counter = 0;
    prefs.setInt(key, counter+1);

    setState(() {
      _counter = counter;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCounter();
  }

  @override
  Widget build(BuildContext context) {


    switch (_counter) {
      case -1:
        return const CircularProgressIndicator();
      default:
          int index = _counter;
          return AlertDialog(
            insetPadding: const EdgeInsets.all(20),
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
              height: 300,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Center(
                child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        child: Text(
                          hadith[index],
                          // "${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n\n",
                          style: const TextStyle(),
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    )),
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.watch_later_outlined),
                  )
                ],
              ),
            ],
          );
        }
    }

}

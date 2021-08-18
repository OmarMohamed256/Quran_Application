import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:quran_application/ReadQuran.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'AppConfigProvider.dart';
import 'ReadQuran.dart';

class QuranScreen extends StatefulWidget {

  static const routeName = "quran";


  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {

  late AppConfigProvider provider;
  var surahsNames=[];
  var surahsVerses=[];
  var colorTheme = Color.fromRGBO(183, 147, 95, 1);
  var colorDarkTheme = Color.fromRGBO(252,196,64,1);

  @override
  void  initState(){
    getSurahContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    var arHeaderBorders = BoxDecoration(border: Border(left: BorderSide(color: provider.isDarkTheme()? colorDarkTheme:colorTheme,width: 3,),bottom: BorderSide(color: provider.isDarkTheme()? colorDarkTheme:colorTheme,width: 3,),top: BorderSide(color: provider.isDarkTheme()? colorDarkTheme:colorTheme,width: 3,)));
    var enHeaderBorders = BoxDecoration(border: Border(right: BorderSide(color: provider.isDarkTheme()? colorDarkTheme:colorTheme,width: 3,),bottom: BorderSide(color: provider.isDarkTheme()? colorDarkTheme:colorTheme,width: 3,),top: BorderSide(color: provider.isDarkTheme()? colorDarkTheme:colorTheme,width: 3,)));
    var headerBorders = (provider.currentLocale == 'en')? enHeaderBorders: arHeaderBorders;

    return Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: provider.isDarkTheme()? AssetImage("assets/images/bg.png"): AssetImage("assets/images/bg3.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/moshaf.png"),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          header(AppLocalizations.of(context)!.surahName, headerBorders),
                          header(AppLocalizations.of(context)!.numOfVerses, BoxDecoration(border: Border(bottom: BorderSide(color: provider.isDarkTheme()? colorDarkTheme:colorTheme,width: 3,),top: BorderSide(color: provider.isDarkTheme()? colorDarkTheme:colorTheme,width: 3,)))),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 0.0),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildListOfSurahs(surahsNames.elementAt(index), surahsVerses.elementAt(index), index+1),
                          itemCount: surahsNames.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        )
    );
  }

  Future<String> loadDataFromFile(String path) async {
    return await rootBundle.loadString(path);
  }

  getSurahContent()
  async {
    String data = await loadDataFromFile('assets/content/sura_names.txt');
    surahsNames=data.split("\n");
    data = await loadDataFromFile('assets/content/suras_nums.txt');
    surahsVerses=data.split("\n");
    setState(() {});
  }

  Widget buildListOfSurahs(String surahName, String surahVerses, int index)
  {
    var arContentBorders = BoxDecoration(border: Border(left: BorderSide(color: provider.isDarkTheme()? colorDarkTheme: colorTheme,width: 3,)));
    var enContentBorders = BoxDecoration(border: Border(right: BorderSide(color: provider.isDarkTheme()? colorDarkTheme: colorTheme,width: 3,)));
    var borders = (provider.currentLocale == 'en')? enContentBorders: arContentBorders;
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: borders,
            child: TextButton(
              onPressed: (){
                //Navigator.pushNamed(context,ReadQuran.routeName,arguments: ReadQuran(surahName,index,true));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadQuran(surahName,index,true)));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Text(
                surahName,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child:  Text(
              surahVerses,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ],
    );
  }

  Widget header(String title, var containerBorders)
  {
    return Expanded(
      child: Container(
        decoration: containerBorders,
        child: Center(
          child: Text(title,
            style: Theme.of(context).textTheme.headline1
          ),
        ),
      ),
    );

  }
}

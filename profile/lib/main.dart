import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyAppThemeConfig {
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secindryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;
  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secindryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;
  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secindryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: primaryColor,
      brightness: brightness,
      dividerColor: surfaceColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor))),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: surfaceColor,
      ),
      dividerTheme: DividerThemeData(
          color: Color.fromARGB(100, 255, 255, 255), indent: 32, endIndent: 32),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(elevation: 0,backgroundColor: appBarColor,foregroundColor: primaryTextColor),
      textTheme: GoogleFonts.latoTextTheme(
        TextTheme(
            bodyText2: TextStyle(fontSize: 15, color: primaryTextColor),
            bodyText1: TextStyle(fontSize: 13, color: secindryTextColor),
            headline6:
                TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
            subtitle1: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryTextColor)),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;
  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Color(0x0dffffff);
    Color primaryColor = Colors.pink.shade400;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme()
          : MyAppThemeConfig.light().getTheme(),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (themeMode == ThemeMode.dark)
              themeMode = ThemeMode.light;
            else
              themeMode = ThemeMode.dark;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;

  const MyHomePage({Key? key, required this.toggleThemeMode}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum SkillState { photoshop, xd, illustrator, afterEffect, lightRoom }

class _MyHomePageState extends State<MyHomePage> {
  SkillState skill = SkillState.photoshop;
  void updateSelectedSkill(SkillState type) {
    setState(() {
      this.skill = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Profile'),
          actions: [
            Icon(CupertinoIcons.chat_bubble),
            SizedBox(
              width: 8,
            ),
            InkWell(
                onTap: widget.toggleThemeMode,
                child: Icon(CupertinoIcons.ellipsis_vertical)),
            SizedBox(
              width: 16,
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/profile_image.png',
                          width: 60,
                          height: 60,
                        )),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Taha Davari',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text('Flutter Developer'),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.location,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                size: 14,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Tehran, Isfahan',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Icon(
                      CupertinoIcons.heart,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Text(
                  'I am a backend developer and I am interested in teamwork and I am learning every day. Interested in the field of data science I am ready to work as a backend developer.',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.justify,
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 0, 12),
                child: Row(
                  children: [
                    Text('Skills',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 12,
                    )
                  ],
                ),
              ),
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Skill(
                      onTap: () {
                        updateSelectedSkill(SkillState.photoshop);
                      },
                      type: SkillState.photoshop,
                      title: 'Photoshop',
                      imgPath: 'assets/images/app_icon_01.png',
                      shadowColor: Colors.blue,
                      isActive: skill == SkillState.photoshop,
                    ),
                    Skill(
                      onTap: () {
                        updateSelectedSkill(SkillState.xd);
                      },
                      type: SkillState.xd,
                      title: 'Adobe XD',
                      imgPath: 'assets/images/app_icon_05.png',
                      shadowColor: Colors.pink,
                      isActive: skill == SkillState.xd,
                    ),
                    Skill(
                      onTap: () {
                        updateSelectedSkill(SkillState.illustrator);
                      },
                      type: SkillState.illustrator,
                      title: 'Illustrator',
                      imgPath: 'assets/images/app_icon_04.png',
                      shadowColor: Colors.orange,
                      isActive: skill == SkillState.illustrator,
                    ),
                    Skill(
                      onTap: () {
                        updateSelectedSkill(SkillState.afterEffect);
                      },
                      type: SkillState.afterEffect,
                      title: 'After Effect',
                      imgPath: 'assets/images/app_icon_03.png',
                      shadowColor: Colors.blue.shade800,
                      isActive: skill == SkillState.afterEffect,
                    ),
                    Skill(
                      onTap: () {
                        updateSelectedSkill(SkillState.lightRoom);
                      },
                      type: SkillState.lightRoom,
                      title: 'Lightroom',
                      imgPath: 'assets/images/app_icon_02.png',
                      shadowColor: Colors.blue,
                      isActive: skill == SkillState.lightRoom,
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Personal Information',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(CupertinoIcons.at))),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(CupertinoIcons.lock))),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Save'))),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class Skill extends StatelessWidget {
  final SkillState type;
  final String title;
  final String imgPath;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;

  const Skill({
    Key? key,
    required this.type,
    required this.title,
    required this.imgPath,
    required this.shadowColor,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(12))
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor.withOpacity(0.5), blurRadius: 20)
                      ],
                    )
                  : null,
              child: Image.asset(
                imgPath,
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}

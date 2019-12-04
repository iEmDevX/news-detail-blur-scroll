import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_detail/fade_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
          body2: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w200),
          title: TextStyle(color: Colors.white, fontSize: 24),
          display1: TextStyle(color: Colors.white, fontSize: 22),
          display2: TextStyle(color: Colors.white, fontSize: 20),
          display3: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
          display4: TextStyle(color: Colors.white, fontSize: 16),
          subtitle: TextStyle(
              color: Colors.grey.shade200,
              fontSize: 14,
              fontWeight: FontWeight.w300),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String imgPath =
      'https://images.pexels.com/photos/3217936/pexels-photo-3217936.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500';
  final String imgPathPerson =
      'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260';

  final String detail =
      '''(CNN)The Philippines' power grid is under the full control of the Chinese government and could be shut off in time of conflict, according to an internal report prepared for lawmakers seen by CNN.

China's State Grid Corporation has a 40% stake in the National Grid Corporation of the Philippines (NGCP), a private consortium that has operated the country's power lines since 2009. Concerns over potential Chinese interference in the Philippine energy system have dogged the arrangement since it was first agreed a decade ago.
Lawmakers called for an urgent review of the arrangement this month after the report claimed that only Chinese engineers had access to key elements of the system, and that power could in theory be deactivated remotely on Beijing's orders.
There is no history of such an attack on a power grid by China, nor has any evidence been presented to suggest that any was imminent, only that it was theoretically possible in future.
The report, prepared by a government body and provided to CNN by a source who requested confidentiality, warned that the system was currently "under the full control" of the Chinese government, which has the "full capability to disrupt national power systems."
"Our national security is completely compromised due to the control and proprietary access given by the local consortium partner to the Chinese government," the report warned.
In a statement, China's Ministry of Foreign Affairs said "China's State Grid Corporation participates in projects run by the National Grid Corporation of the Philippines as a partner of local companies."
"The Philippines is a neighbor and important partner of China's. We support Chinese companies conducting business in the Philippines in accordance with laws and regulations to expand mutual benefits and win-win cooperation," the statement added. "We hope certain individuals in the Philippines view such bilateral cooperation with an open mind as well as an objective and fair attitude. They shouldn't over-worry or even fabricate things out of thin air."
CNN has reached out to NGCP and TransCo -- which owns but does not operate the power grid -- for comment on this story.''';

  double sigmaBlur = 0.0;
  double withOpacityBg = 0.0;
  ScrollController scrollController = ScrollController();

  onScrollChange() {
    double blur = scrollController.offset /
        (MediaQuery.of(context).size.height * 0.1) *
        10;
    var sigmaBlurMax = (blur > 10.0 ? 10.0 : blur);
    var withOpacityBgMax = (blur > 10 ? 0.7 : blur / 10.0 * 0.7);
    setState(() {
      sigmaBlur = sigmaBlurMax < 0.0 ? 0.0 : sigmaBlurMax;
      withOpacityBg = withOpacityBgMax < 0.0 ? 0.0 : withOpacityBgMax;
    });
  }

  @override
  void initState() {
    scrollController.addListener(onScrollChange);
    WidgetsBinding.instance.addPostFrameCallback(
        (duration) => Future.delayed(Duration(milliseconds: 1000), () {
              scrollController.animateTo(
                MediaQuery.of(context).size.height * 0.2,
                duration: Duration(milliseconds: 1800),
                curve: Curves.fastOutSlowIn,
              );
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgPath),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaBlur, sigmaY: sigmaBlur),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.black.withOpacity(withOpacityBg)),
            child: SafeArea(
              child: ListView(
                controller: scrollController,
                children: <Widget>[
                  Container(height: MediaQuery.of(context).size.height * 0.7),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Text(
                      "China can shut off the Philippines' power grid at any time, leaked report warns",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  FadeIn(
                    400,
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            minRadius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(imgPathPerson),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'MR.TESTER BUGING',
                                  style: Theme.of(context).textTheme.display3,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.access_alarm,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Text(
                                        '12-Nov-2019 09:13',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                    child: Text(
                      detail,
                      style: Theme.of(context).textTheme.display3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

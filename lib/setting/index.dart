import 'package:flutter/material.dart';
import 'package:project_qcue/components/drawer.dart';
import 'package:project_qcue/components/input_field.dart';
import 'package:project_qcue/components/profile.dart';
import 'package:project_qcue/components/buttons.dart';
import 'package:project_qcue/components/date_time_picker.dart';
import 'package:project_qcue/components/setting_card.dart';
import 'dart:async';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  SettingScreenState createState() => new SettingScreenState();
}

class SettingScreenState extends State<SettingScreen>
    with TickerProviderStateMixin {
  final TextEditingController _name =
      new TextEditingController(text: 'Sungmin Lee');
  final TextEditingController _email =
      new TextEditingController(text: 'example@gmail.com');
  final TextEditingController _password =
      new TextEditingController(text: 'A1344');
  final TextEditingController _birthday =
      new TextEditingController(text: 'Septemver 12, 1992');
  final TextEditingController _address =
      new TextEditingController(text: '558 Handong-ro St, Pohang, 37554');
  TabController _tabController;
  closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  openCalender() async {
    selectDate(context).then((date) {
      setState(() {
        if (date != null) _birthday.text = date;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(closeKeyboard);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        drawer: new CustomDrawer(),
        appBar: new PreferredSize(
          preferredSize: new Size(screenSize.width, screenSize.height / 4),
          child: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/setting_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: new AppBar(
              flexibleSpace: new Container(
                padding: const EdgeInsets.only(left: 20.0, top: 15.0),
                child: new Center(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Settings',
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontFamily: 'NanumSquare'),
                      )
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                new Container(
                    margin: new EdgeInsets.only(right: 10.0),
                    padding: new EdgeInsets.only(bottom: 12.0),
                    child: new ProfilePic()),
              ],
              bottom: new PreferredSize(
                preferredSize: new Size(screenSize.width, 20.0),
                child: new Container(
                  padding: const EdgeInsets.only(
                      bottom: 0.0, left: 10.0, right: 120.0),
                  child: new TabBar(
                    indicatorColor: Colors.white,
                    controller: _tabController,
                    indicatorPadding: const EdgeInsets.only(top: 1.0),
                    tabs: [
                      new Tab(
                        child: new Container(
                          child: new Text(
                            'GENERAL',
                            style: new TextStyle(fontSize: 15.0),
                          ),
                          margin: const EdgeInsets.only(top: 10.0),
                        ),
                      ),
                      new Tab(
                        child: new Container(
                          child: new Text(
                            'ALERT',
                            style: new TextStyle(fontSize: 15.0),
                          ),
                          margin: const EdgeInsets.only(top: 10.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: new TabBarView(
          controller: _tabController,
          children: [
            new Container(
              child: new Container(
                padding: const EdgeInsets.only(),
                child: new ListView(
                  children: <Widget>[
                    new Container(
                      height: screenSize.height * (3 / 4) - 20.0,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new InputField(
                            controller: _name,
                            icon: Icons.person_outline,
                            hint: 'Name',
                            protected: false,
                            color: Colors.black,
                          ),
                          new InputField(
                            controller: _email,
                            type: TextInputType.emailAddress,
                            icon: Icons.mail_outline,
                            hint: 'Email',
                            protected: false,
                            color: Colors.black,
                          ),
                          new InputField(
                            controller: _password,
                            icon: Icons.lock_outline,
                            hint: 'Password',
                            protected: true,
                            color: Colors.black,
                          ),
                          new InkWell(
                            onTap: () {
                              closeKeyboard();
                              new Timer(Duration(milliseconds: 100), () {
                                openCalender();
                              });
                            },
                            child: new InputField(
                              controller: _birthday,
                              icon: Icons.card_giftcard,
                              enable: false,
                              hint: 'Birthday',
                              protected: false,
                              color: Colors.black,
                            ),
                          ),
                          new InputField(
                            controller: _address,
                            icon: Icons.location_on,
                            hint: 'Location',
                            protected: false,
                            color: Colors.black,
                          ),
                          new RoundButton(
                            color: new Color.fromRGBO(255, 51, 102, 1.0),
                            width: screenSize.width - 150,
                            height: 60.0,
                            text: 'Log Out',
                            onPressed: () =>
                                Navigator.pushNamed(context, "/login"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new ListView(
              padding: new EdgeInsets.only(left: 15.0, top: 5.0, right: 10.0),
              children: <Widget>[
                new SettingCard(
                  title: 'Notification',
                ),
                new SettingCard(
                  title: 'Sound',
                ),
                new SettingCard(
                  title: 'Show on Lock Screen',
                ),
                new SettingCard(
                  title: 'Badge App Icon',
                ),
                new SettingCard(
                  title: 'Auto Updates',
                  allowBorder: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

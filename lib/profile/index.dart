import 'package:flutter/material.dart';
import 'package:QCUE/components/drawer.dart';
import 'package:QCUE/components/buttons.dart';
import 'package:QCUE/components/circular_chart.dart';
import 'package:QCUE/model/data.dart';
import 'style.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  var list = new ItemListBuilder().cardList;
  var item = new DateListBuilder().dateList;
  static int i = 0;
  nextMonth() {
    setState(() {
      int d = i;
      if (d == 11) {
        i = 0;
      }
      if (d < 11) i++;
    });
  }

  previousMonth() {
    setState(() {
      int d = i;
      if (d != 0) i--;
      if (d == 0) {
        i = 11;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      drawer: new CustomDrawer(),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              height: screenSize.height / 2.2,
              width: screenSize.width,
              padding: const EdgeInsets.only(right: 15.0, top: 25.0),
              decoration: decoration,
              child: new Column(
                children: <Widget>[
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new DrawerButton(),
                        new  Container(
                            alignment: Alignment.topRight,
                            height: 35.0,
                            width: 35.0,
                            padding:
                            new EdgeInsets.only(left: 10.0, top: 5.0),
                            margin: new EdgeInsets.only(top:10.0),
                            decoration:
                            pic,
                            child: new Icon(
                              Icons.fiber_manual_record,
                              color: Colors.red,
                              size: 10.0,
                            )
                        ),
                      ]),
                  new Container(
                    padding: const EdgeInsets.only(left: 25.0, top: 15.0),
                    alignment: Alignment.topLeft,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          'Adam Lane',
                          style: appTitle,
                        ),
                        new Text(
                          'Photographer',
                          style: subTitle,
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    height: 135.0,
                    width: screenSize.width,
                    padding: const EdgeInsets.only(top: 15.0),
                    child: new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, int i) {
                          return new Container(
                            width: screenSize.width / 3,
                            height: 135.0,
                            child: new Column(children: <Widget>[
                              new CircularChart1(
                                taskDone: list[i].taskDone,
                                taskUnDone: list[i].taskUnDone,
                                completedColor: list[i].completedColor,
                                uncompletedColor:
                                    const Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                              new Text(
                                list[i].tilte,
                                style: new TextStyle(color: Colors.white),
                              )
                            ]),
                          );
                        }),
                  ),
                ],
              ),
            ),
            new Container(
              padding:
                  const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
              color: const Color.fromRGBO(200, 200, 200, 0.4),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    item[i].date,
                    style: title,
                  ),
                  new Row(
                    children: <Widget>[
                      new IconButton(
                          icon: new Icon(
                            Icons.navigate_before,
                            size: 30.0,
                          ),
                          color: const Color.fromRGBO(0, 0, 0, 0.5),
                          onPressed: () => previousMonth()),
                      new IconButton(
                          icon: new Icon(
                            Icons.navigate_next,
                            size: 30.0,
                          ),
                          color: const Color.fromRGBO(0, 0, 0, 0.5),
                          onPressed: () => nextMonth())
                    ],
                  )
                ],
              ),
            ),
            new Container(
                height: screenSize.height * (1.2 / 2.2) - 80,
                width: screenSize.width,
                margin: new EdgeInsets.only(left: 10.0, right: 10.0),
                child: new ListView.builder(
                    itemCount: item[i].list.length,
                    padding: const EdgeInsets.all(0.0),
                    itemBuilder: (context, int index) {
                      var items = item[i].list[index];
                      return new Container(
                          decoration:
                              (index < item[i].list.length - 1 ? border : null),
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.topLeft,
                                    padding: new EdgeInsets.only(
                                        right: 20.0,
                                        bottom:
                                            (items.text == true ? 25.0 : 50.0)),
                                    child: new Icon(
                                      Icons.fiber_manual_record,
                                      color: items.labelColor,
                                      size: 15.0,
                                    ),
                                  ),
                                  new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 5.0, top: 5.0),
                                        child: new Text(
                                          items.task,
                                          style: header,
                                        ),
                                      ),
                                      new Text(
                                        items.source,
                                        style: subHeader,
                                      ),
                                      items.text == false
                                          ? new Container(
                                              width: 180.0,
                                              height: 40.0,
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: new ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: items.pic.length,
                                                  itemBuilder:
                                                      (context, int index) {
                                                    return new Container(
                                                      width: 30.0,
                                                      height: 30.0,
                                                      margin:
                                                          const EdgeInsets.only(
                                                        right: 10.0,
                                                      ),
                                                      decoration: decoratepic(
                                                          items.pic[index]),
                                                    );
                                                  }))
                                          : new Text('')
                                    ],
                                  )
                                ],
                              ),
                              new Column(
                                children: <Widget>[
                                  new Text(
                                    items.hour,
                                    style: timeStyle,
                                  ),
                                  new Text(
                                    items.meridian,
                                    style: subHeader,
                                  )
                                ],
                              )
                            ],
                          ));
                    }))
          ],
        ),
      ),
    );
  }
}

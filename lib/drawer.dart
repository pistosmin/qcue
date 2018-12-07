import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomDrawer extends StatefulWidget {
  @override
  createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  String defaultImageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjhJ_fE8brBZTj3ZXyqbs00etqFS7shBubvpVai0p0NkY7fHaZ-g';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.currentUser().asStream(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          return Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the Drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                DrawerHeader(
                  child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 0.0, left: 10.0),
                      // margin: const EdgeInsets.only(top: 50.0, bottom: 20.0, left: 0.0),
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 60.0, height: 60.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image:  DecorationImage(
                                  image: snapshot.data.photoUrl == null 
                                  ? Image.network(defaultImageUrl) 
                                  : NetworkImage(snapshot.data.photoUrl),
                                  fit: BoxFit.cover),
                            ),
                            margin:
                                const EdgeInsets.only(right: 10.0, left: 0.0),
                            // padding:const EdgeInsets.only(left: 0.0) ,
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '안녕하세요! \n' + snapshot.data.displayName + '님',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'NanumSquare'),
                                ),
                                Text(
                                  snapshot.data.email,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                                      fontFamily: 'NanumSquare'),
                                )
                              ],
//
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/mypage");
                    },
                  ),
                ),
                ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: const Color.fromRGBO(0, 0, 0, 0.1),
                              width: 1.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  Icons.home,
                                  size: 25.0,
                                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                                  // color: Colors.orange[600],
                                  // color: Theme.of(context).primaryColor,
                                )),
                            Text(
                              '홈',
                              style: TextStyle(
                                fontSize: 20.0, fontFamily: 'NanumSquare',
                                //  color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromRGBO(0, 0, 0, 0.6)),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                ),
                ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    margin: const EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: const Color.fromRGBO(0, 0, 0, 0.1),
                              width: 1.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  // Icons.priority_high,
                                  Icons.add,
                                  size: 25.0,
                                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                                  // color: Theme.of(context).primaryColor,
                                  // color: Colors.orange[600],
                                )),
                            Text(
                              '퀘스트 만들기',
                              style: TextStyle(
                                fontSize: 20.0, fontFamily: 'NanumSquare',
                                //  color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 16.0,
                            // color:  Color.fromRGBO(0, 0, 0, 0.6)
                            // color: Theme.of(context).primaryColor,
                            color: Colors.orange[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    // Navigator.pushNamed(context, "/viewQuest");
                    Navigator.pushNamed(context, "/add");
                  },
                ),
                // ListTile(
                //   title: Container(
                //     padding: const EdgeInsets.only(bottom: 15.0),
                //     margin: const EdgeInsets.only(top: 15.0),
                //     decoration: BoxDecoration(
                //       border: Border(
                //           bottom: BorderSide(
                //               color: const Color.fromRGBO(0, 0, 0, 0.1),
                //               width: 1.2)),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         Row(
                //           children: <Widget>[
                //             Container(
                //                 margin: const EdgeInsets.only(right: 15.0),
                //                 child: Icon(
                //                   Icons.list,
                //                   size: 25.0,
                //                   color: const Color.fromRGBO(0, 0, 0, 0.3),
                //                   // color: Theme.of(context).primaryColor,
                //                   // color: Colors.orange[600],
                //                 )),
                //             Text(
                //               '퀘스트 목록',
                //               style: TextStyle(
                //                 fontSize: 20.0, fontFamily: 'NanumSquare',
                //                 //  color: Theme.of(context).primaryColor,
                //               ),
                //             ),
                //           ],
                //         ),
                //         Text(
                //           '5',
                //           style: TextStyle(
                //             fontSize: 16.0,
                //             // color:  Color.fromRGBO(0, 0, 0, 0.6)
                //             // color: Theme.of(context).primaryColor,
                //             color: Colors.orange[600],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pushNamed(context, "/viewQuestList");
                //   },
                // ),
                ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    margin: const EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: const Color.fromRGBO(0, 0, 0, 0.1),
                              width: 1.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  Icons.perm_identity,
                                  size: 25.0,
                                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                                  // color: Theme.of(context).primaryColor,
                                  // color: Colors.orange[600],
                                )),
                            Text(
                              '마이페이지',
                              style: TextStyle(
                                fontSize: 20.0, fontFamily: 'NanumSquare',
                                //  color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/mypage");
                  },
                ),
                ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    margin: const EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: const Color.fromRGBO(0, 0, 0, 0.1),
                              width: 1.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  Icons.settings,
                                  size: 25.0,
                                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                                  // color: Theme.of(context).primaryColor,
                                  // color: Colors.orange[600],
                                )),
                            Text(
                              '설정',
                              style: TextStyle(
                                fontSize: 20.0, fontFamily: 'NanumSquare',
                                //  color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/setting");
                  },
                ),
                SizedBox(height: 270.0),
                Divider(height: 0),
                ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    margin: const EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: const Color.fromRGBO(0, 0, 0, 0.1),
                              width: 1.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  Icons.exit_to_app,
                                  size: 25.0,
                                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                                )),
                            Text(
                              '로그아웃',
                              style: TextStyle(
                                  fontSize: 20.0, fontFamily: 'NanumSquare'),
                            ),
                          ],
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/login');
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          );
        });
  }
}

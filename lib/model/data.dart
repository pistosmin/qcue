import 'package:flutter/material.dart';

class ItemList {
  String tilte;
  double taskDone;
  double taskUnDone;
  dynamic completedColor;

  ItemList({this.tilte, this.taskDone, this.taskUnDone, this.completedColor});
}

class ItemListBuilder {
  List<ItemList> cardList = new List<ItemList>();
  ItemList card1 = new ItemList(
      tilte: 'SNOOZED',
      taskDone: 16.0,
      taskUnDone: 84.0,
      completedColor: Colors.yellow);
  ItemList card2 = new ItemList(
      tilte: 'COMPLETED',
      taskDone: 74.0,
      taskUnDone: 26.0,
      completedColor: Colors.greenAccent);
  ItemList card3 = new ItemList(
      tilte: 'OVERDUE',
      taskDone: 10.0,
      taskUnDone: 90.0,
      completedColor: Colors.pinkAccent);

  ItemListBuilder() {
    cardList.add(card1);
    cardList.add(card2);
    cardList.add(card3);
  }
}

class HomeCardData {
  int id;
  String hour;
  String meridian;
  String task;
  String source;
  bool text;
  var pic;
  dynamic labelColor;
  HomeCardData(
      {this.hour,
      this.meridian,
      this.task,
      this.source,
      this.pic,
      this.labelColor,
      this.text,
      this.id});
}

class DataListBuilder {
  List<HomeCardData> cardList = new List<HomeCardData>();
  List<HomeCardData> cardList1 = new List<HomeCardData>();
  List<HomeCardData> newList = new List<HomeCardData>();
  HomeCardData card1 = new HomeCardData(
      id: 1,
      hour: '8',
      meridian: 'AM',
      task: 'Finish Home Screen',
      source: 'Web App',
      text: true,
      pic: [],
      labelColor: Colors.green);
  HomeCardData card2 = new HomeCardData(
      id: 2,
      hour: '11',
      meridian: 'AM',
      task: 'Lunch Break',
      source: '',
      pic: [],
      text: true,
      labelColor: Colors.green);
  HomeCardData card3 = new HomeCardData(
      id: 3,
      hour: '2',
      meridian: 'AM',
      task: 'Design Meeting',
      text: false,
      source: 'Hangout',
      pic: ['assets/avatar1.jpg', 'assets/avatar2.jpg', 'assets/avatar3.jpg'],
      labelColor: Colors.yellow);
  HomeCardData card4 = new HomeCardData(
      id: 4,
      hour: '2',
      meridian: 'AM',
      task: 'Design Meeting',
      text: false,
      source: 'Hangout',
      pic: ['assets/avatar1.jpg', 'assets/avatar2.jpg', 'assets/avatar3.jpg'],
      labelColor: Colors.yellow);
  HomeCardData card5 = new HomeCardData(
      id: 5,
      hour: '',
      meridian: '',
      task: '',
      text: true,
      source: 'Hangout',
      pic: [],
      labelColor: Colors.yellow);
  DataListBuilder() {
    cardList.add(card1);
    cardList.add(card2);
    cardList.add(card3);
    cardList1.add(card4);
    newList.add(card5);
  }
}

class DateCard {
  String date;
  List<HomeCardData> list;
  DateCard({this.date, this.list});
}

class DateListBuilder {
  List<DateCard> dateList = new List<DateCard>();
  DateCard card1 =
      new DateCard(date: 'JANUARY, 2018', list: new DataListBuilder().cardList);
  DateCard card2 = new DateCard(
      date: 'FEBRUARY, 2018', list: new DataListBuilder().cardList1);
  DateCard card3 =
      new DateCard(date: 'MARCH, 2018', list: new DataListBuilder().cardList);
  DateCard card4 =
      new DateCard(date: 'APRIL, 2018', list: new DataListBuilder().cardList);
  DateCard card5 =
      new DateCard(date: 'MAY, 2018', list: new DataListBuilder().cardList1);
  DateCard card6 =
      new DateCard(date: 'JUNE, 2018', list: new DataListBuilder().cardList);
  DateCard card7 =
      new DateCard(date: 'JULY, 2018', list: new DataListBuilder().cardList1);
  DateCard card8 =
      new DateCard(date: 'AUGUST, 2018', list: new DataListBuilder().cardList);
  DateCard card9 = new DateCard(
      date: 'SEPTEMBER, 2018', list: new DataListBuilder().cardList1);
  DateCard card10 =
      new DateCard(date: 'OCTOBER, 2018', list: new DataListBuilder().cardList);
  DateCard card11 = new DateCard(
      date: 'NOVEMBER, 2018', list: new DataListBuilder().cardList1);
  DateCard card12 = new DateCard(
      date: 'DECEMBER, 2018', list: new DataListBuilder().cardList1);
  DateListBuilder() {
    dateList.add(card1);
    dateList.add(card2);
    dateList.add(card3);
    dateList.add(card4);
    dateList.add(card5);
    dateList.add(card6);
    dateList.add(card7);
    dateList.add(card8);
    dateList.add(card9);
    dateList.add(card10);
    dateList.add(card11);
    dateList.add(card12);
  }
}

class DayListBuilder {
  List<DateCard> dateList = new List<DateCard>();
  DateCard card1 = new DateCard(
      date: 'MON, MAR 23, 2018', list: new DataListBuilder().cardList);
  DateCard card2 = new DateCard(
      date: 'TUE, MAR 24, 2018', list: new DataListBuilder().cardList);
  DayListBuilder() {
    dateList.add(card1);
    dateList.add(card2);
  }
}

import 'package:flutter/material.dart';

class HomeCardData {
  String hour;
  String meridian;
  String task;
  String source;
  String status;
  dynamic statusColor;
  HomeCardData(
      {this.hour,
      this.meridian,
      this.task,
      this.source,
      this.status,
      this.statusColor});
}

class DataListBuilder {
  List<HomeCardData> cardList = new List<HomeCardData>();
  HomeCardData card1 = new HomeCardData(
      hour: '11',
      meridian: 'AM',
      task: '',
      source: '',
      status: '.',
      statusColor: Colors.white);
  HomeCardData card2 = new HomeCardData(
      hour: '12',
      meridian: 'AM',
      task: 'Design Meeting',
      source: 'App',
      status: '.',
      statusColor: const Color.fromRGBO(186, 119, 255, 1.0));
  HomeCardData card3 = new HomeCardData(
      hour: '1',
      meridian: 'PM',
      task: '',
      source: '',
      status: '.',
      statusColor: Colors.white);
  HomeCardData card4 = new HomeCardData(
      hour: '2',
      meridian: 'PM',
      task: 'Lunch Break',
      source: '',
      status: '.',
      statusColor: const Color.fromRGBO(80, 210, 194, 1.0));
  HomeCardData card5 = new HomeCardData(
      hour: '3',
      meridian: 'AM',
      task: '',
      source: '',
      status: '.',
      statusColor: Colors.white);
  HomeCardData card6 = new HomeCardData(
      hour: '4',
      meridian: 'AM',
      task: 'Catch up with Tom',
      source: '',
      status: '.',
      statusColor: const Color.fromRGBO(252, 171, 83, 1.0));
  HomeCardData card7 = new HomeCardData(
      hour: '3',
      meridian: 'AM',
      task: '',
      source: '',
      status: '.',
      statusColor: Colors.white);

  DataListBuilder() {
    cardList.add(card1);
    cardList.add(card2);
    cardList.add(card3);
    cardList.add(card4);
    cardList.add(card5);
    cardList.add(card6);
    cardList.add(card7);
  }
}

class WeekCardData {
  String day;
  String task;
  String source;
  String status;
  dynamic statusColor;
  WeekCardData(
      {this.day, this.task, this.source, this.status, this.statusColor});
}

class WeekListBuilder {
  List<WeekCardData> cardList = new List<WeekCardData>();
  WeekCardData card1 = new WeekCardData(
      day: 'MON', task: '', source: '', status: '.', statusColor: Colors.white);
  WeekCardData card2 = new WeekCardData(
      day: 'TUE',
      task: 'Design Meeting',
      source: 'App',
      status: '.',
      statusColor: const Color.fromRGBO(186, 119, 255, 1.0));
  WeekCardData card3 = new WeekCardData(
      day: 'WED', task: '', source: '', status: '.', statusColor: Colors.white);
  WeekCardData card4 = new WeekCardData(
      day: 'THU',
      task: 'Lunch Break',
      source: '',
      status: '.',
      statusColor: const Color.fromRGBO(80, 210, 194, 1.0));
  WeekCardData card5 = new WeekCardData(
      day: 'FRI', task: '', source: '', status: '.', statusColor: Colors.white);
  WeekCardData card6 = new WeekCardData(
      day: 'SAT',
      task: 'Catch up with Tom',
      source: '',
      status: '.',
      statusColor: const Color.fromRGBO(252, 171, 83, 1.0));
  WeekCardData card7 = new WeekCardData(
      day: 'SUN', task: '', source: '', status: '.', statusColor: Colors.white);

  WeekListBuilder() {
    cardList.add(card1);
    cardList.add(card2);
    cardList.add(card3);
    cardList.add(card4);
    cardList.add(card5);
    cardList.add(card6);
    cardList.add(card7);
  }
}

class MonthCardData {
  String day;
  String task;
  String source;
  String status;
  dynamic statusColor;
  MonthCardData(
      {this.day, this.task, this.source, this.status, this.statusColor});
}

class MonthListBuilder {
  List<MonthCardData> cardList = new List<MonthCardData>();
  MonthCardData card1 = new MonthCardData(
      day: 'JAN', task: '', source: '', status: '.', statusColor: Colors.white);
  MonthCardData card2 = new MonthCardData(
      day: 'FEB',
      task: 'Design Meeting',
      source: 'App',
      status: '.',
      statusColor: const Color.fromRGBO(186, 119, 255, 1.0));
  MonthCardData card3 = new MonthCardData(
      day: 'MAR', task: '', source: '', status: '.', statusColor: Colors.white);
  MonthCardData card4 = new MonthCardData(
      day: 'APR',
      task: 'Lunch Break',
      source: '',
      status: '.',
      statusColor: const Color.fromRGBO(80, 210, 194, 1.0));
  MonthCardData card5 = new MonthCardData(
      day: 'MAY', task: '', source: '', status: '.', statusColor: Colors.white);
  MonthCardData card6 = new MonthCardData(
      day: 'JUNE',
      task: 'Catch up with Tom',
      source: '',
      status: '.',
      statusColor: const Color.fromRGBO(252, 171, 83, 1.0));
  MonthCardData card7 = new MonthCardData(
      day: 'JULY',
      task: '',
      source: '',
      status: '.',
      statusColor: Colors.white);
  MonthCardData card8 = new MonthCardData(
      day: 'AUG', task: '', source: '', status: '.', statusColor: Colors.white);
  MonthCardData card9 = new MonthCardData(
      day: 'SEPT',
      task: 'Catch up with Tom',
      source: '',
      status: '.',
      statusColor: const Color.fromRGBO(252, 171, 83, 1.0));
  MonthCardData card10 = new MonthCardData(
      day: 'OCT', task: '', source: '', status: '.', statusColor: Colors.white);
  MonthCardData card11 = new MonthCardData(
      day: 'NOV',
      task: 'Design Meeting',
      source: 'App',
      status: '.',
      statusColor: const Color.fromRGBO(186, 119, 255, 1.0));
  MonthCardData card12 = new MonthCardData(
      day: 'DEC', task: '', source: '', status: '.', statusColor: Colors.white);

  MonthListBuilder() {
    cardList.add(card1);
    cardList.add(card2);
    cardList.add(card3);
    cardList.add(card4);
    cardList.add(card5);
    cardList.add(card6);
    cardList.add(card7);
    cardList.add(card8);
    cardList.add(card9);
    cardList.add(card10);
    cardList.add(card11);
    cardList.add(card12);
  }
}

import 'package:flutter/material.dart';

class ItemList {
  String item;
  bool complted;
  dynamic icon;
  dynamic color;

  ItemList({this.item, this.complted, this.icon, this.color});
}

class ItemListBuilder {
  List<ItemList> cardList = new List<ItemList>();
  ItemList card1 = new ItemList(
      item: 'Carrot',
      complted: false,
      icon: Icons.panorama_fish_eye,
      color: const Color.fromRGBO(0, 0, 0, 0.5));
  ItemList card2 = new ItemList(
      item: 'Nuts', complted: true, icon: Icons.done, color: Colors.green);
  ItemList card3 = new ItemList(
      item: 'Lettuce',
      complted: false,
      icon: Icons.panorama_fish_eye,
      color: const Color.fromRGBO(0, 0, 0, 0.5));
  ItemList card4 = new ItemList(
      item: 'Arugula', complted: true, icon: Icons.done, color: Colors.green);
  ItemList card5 = new ItemList(
      item: 'Dressing',
      complted: false,
      icon: Icons.panorama_fish_eye,
      color: const Color.fromRGBO(0, 0, 0, 0.5));
  ItemList card6 = new ItemList(
      item: 'Cheese',
      complted: false,
      icon: Icons.panorama_fish_eye,
      color: const Color.fromRGBO(0, 0, 0, 0.5));
  ItemList card7 = new ItemList(
      item: 'Lime',
      complted: false,
      icon: Icons.panorama_fish_eye,
      color: const Color.fromRGBO(0, 0, 0, 0.5));
  ItemListBuilder() {
    cardList.add(card1);
    cardList.add(card2);
    cardList.add(card3);
    cardList.add(card4);
    cardList.add(card5);
    cardList.add(card6);
    cardList.add(card7);
  }
}

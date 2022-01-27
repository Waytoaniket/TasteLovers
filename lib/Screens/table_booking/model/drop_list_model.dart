import 'package:flutter/material.dart';

class DropListModel {
  DropListModel(this.listOptionItems);

  List<OptionItem> listOptionItems = [];
  DropListModel.fromJson(Map<String, dynamic> json) {
    listOptionItems = [OptionItem(id: null, title: "Table no.", subtitle: "Capcity")];
    if (json['result'] != null && json['result']) {
      json['data'].forEach((v) {
        listOptionItems.add(new OptionItem.fromJson(v));
      });
    } else
      listOptionItems = <OptionItem>[];
  }
}

class OptionItem {
  String? id;
  String? title;
  String? subtitle;

  OptionItem({@required this.id, @required this.title, this.subtitle});
  OptionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = "T - " + json['table_no'].toString();
    subtitle = json['table_capacity'] + " Capacity";
  }
}

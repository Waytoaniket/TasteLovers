import 'dart:convert';

List<TableModel> tableModelFromJson(String str) =>
    List<TableModel>.from(json.decode(str).map((x) => TableModel.fromJson(x)));

String tableModelToJson(List<TableModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableModel {
  TableModel({this.id, this.tableNo, this.capacity});

  int? id;
  int? tableNo;
  String? capacity;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["id"],
        tableNo: json["table_no"],
        capacity: json["table_capacity"],
      );

  Map<String, dynamic> toJson() => {"id": id, "table_no": tableNo, "table_capacity": capacity};
}

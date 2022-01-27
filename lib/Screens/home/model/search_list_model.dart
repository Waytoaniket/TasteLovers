class SearchListModel {
  List<SearchItem>? searchList;

  SearchListModel({this.searchList});

  SearchListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      searchList = <SearchItem>[];
      json['data'].forEach((v) {
        searchList!.add(new SearchItem.fromJson(v));
      });
    } else
      searchList = <SearchItem>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchList != null) {
      data['data'] = this.searchList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchItem {
  int? id;
  String? name;

  SearchItem({this.id, this.name});

  SearchItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

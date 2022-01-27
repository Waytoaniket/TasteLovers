import 'package:blue_witcher/Screens/table_booking/model/drop_list_model.dart';
import 'package:flutter/material.dart';

class SelectDropList extends StatefulWidget {
  final OptionItem itemSelected;
  final List<OptionItem>? listOptionItems;
  final Color color;
  final Function(OptionItem optionItem) onOptionSelected;

  SelectDropList(
    this.itemSelected,
    this.listOptionItems,
    this.color,
    this.onOptionSelected,
  );

  @override
  _SelectDropListState createState() => _SelectDropListState(itemSelected);
}

class _SelectDropListState extends State<SelectDropList> with SingleTickerProviderStateMixin {
  OptionItem optionItemSelected;

  AnimationController? expandController;
  Animation<double>? animation;

  bool isShow = false;

  _SelectDropListState(this.optionItemSelected);

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController!,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController!.forward();
    } else {
      expandController!.reverse();
    }
  }

  @override
  void dispose() {
    expandController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black26, offset: Offset(0, 1))],
            ),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    this.isShow = !this.isShow;
                    _runExpandCheck();
                    setState(() {});
                  },
                  child: Text(
                    optionItemSelected.title!,
                    style: TextStyle(color: widget.color, fontSize: 16),
                  ),
                )),
                Align(
                  alignment: Alignment(1, 0),
                  child: Icon(
                    isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: widget.color,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
          SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation!,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26, offset: Offset(0, 4))],
                  ),
                  child: _buildDropListOptions(widget.listOptionItems!, context))),
//          Divider(color: Colors.grey.shade300, height: 1,)
        ],
      ),
    );
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey[200]!, width: 1),
                    right: BorderSide(color: Colors.grey[200]!, width: 1)),
              ),
              child: Center(
                child: Text(item.title!,
                    style: TextStyle(color: widget.color, fontWeight: FontWeight.w400, fontSize: 14),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey[200]!, width: 1),
                    left: BorderSide(color: Colors.grey[200]!, width: 1)),
              ),
              child: Center(
                child: Text(item.subtitle!,
                    style: TextStyle(color: widget.color, fontWeight: FontWeight.w400, fontSize: 14),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        if (item.id != null) this.optionItemSelected = item;
        isShow = false;
        expandController!.reverse();
        if (item.id != null) widget.onOptionSelected(item);
      },
    );
  }
}

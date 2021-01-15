import 'package:flutter/material.dart';
import 'package:multi_select_demo/item.dart';
import 'package:random_color/random_color.dart';

class ListItem extends StatefulWidget {
  final Item item;
  final ValueChanged<Key> onLongPress;
  final ValueChanged<Key> onTap;
  final bool isSelected;

  ListItem({Key key, this.item, this.onLongPress, this.onTap, this.isSelected})
      : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: widget.isSelected
                ? CircleAvatar(
                    child: Center(
                      child: Icon(
                        Icons.check,
                      ),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: widget.item.backgroundColor,
                    child: Text(
                      widget.item.title[0],
                    ),
                  ),
            title: Text(widget.item.title),
            subtitle: Text(widget.item.subTitle),
            trailing: Text(widget.key.toString()),
            onLongPress: () => widget.onLongPress(widget.key),
            onTap: () => widget.onTap(widget.key),
            selected: widget.isSelected,
          )
        ],
      ),
    );
  }
}

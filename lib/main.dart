import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:multi_select_demo/item.dart';
import 'package:multi_select_demo/list_item.dart';
import 'package:random_color/random_color.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Select Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Multi Select Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ColorHue> _hueType = <ColorHue>[
    ColorHue.green,
    ColorHue.red,
    ColorHue.pink,
    ColorHue.purple,
    ColorHue.blue,
    ColorHue.yellow,
    ColorHue.orange
  ];
  final List<Key> _selectedItemKeys = [];
  final RandomColor randomColorGenerator = RandomColor();

  List<Item> _items;
  List<Key> _itemKeys;
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = [];
      _itemKeys = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          var key = Key(_items[index].id.toString());

          if (!_itemKeys.contains(key)) {
            _itemKeys.add(key);
          }

          return ListItem(
            key: key,
            item: _items[index],
            onLongPress: _onLongPress,
            onTap: _onTap,
            isSelected: _selectedItemKeys.contains(key),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createdItem,
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: _isSelecting
          ? IconButton(icon: Icon(Icons.clear), onPressed: _clearSelection)
          : Container(),
      title: Text(_selectedItemKeys.isEmpty
          ? widget.title
          : '${_selectedItemKeys.length} items selected'),
      actions: [
        _isSelecting
            ? Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.select_all), onPressed: _selectAll),
                  IconButton(
                      icon: Icon(Icons.delete), onPressed: _deleteSelection)
                ],
              )
            : Container(),
      ],
    );
  }

  void _clearSelection() {
    setState(() {
      _selectedItemKeys.clear();
      _isSelecting = false;
    });
  }

  void _selectAll() {
    setState(() {
      _selectedItemKeys.clear();
      _selectedItemKeys.addAll(_itemKeys);
    });
  }

  void _deleteSelection() {
    setState(() {
      _selectedItemKeys.forEach((key) {
        ValueKey<String> valueKey = key;
        int id = int.parse(valueKey.value);
        _items.removeWhere((item) => item.id == id);
      });

      _selectedItemKeys.clear();
      _isSelecting = false;
    });
  }

  void _createdItem() {
    setState(() {
      var id = _items.length + 1;
      final newItem = Item(
        id: id,
        title: 'Test $id',
        subTitle: loremIpsum(words: 10),
        backgroundColor: randomColorGenerator.randomColor(
          colorHue: ColorHue.multiple(colorHues: _hueType),
          colorSaturation: ColorSaturation.random,
        ),
      );
      _items.add(newItem);
    });
  }

  void _onLongPress(Key key) {
    print(key.toString() + ' long pressed');

    setState(() {
      if (_selectedItemKeys.isEmpty) {
        _isSelecting = true;
        _selectedItemKeys.add(key);
      }
    });

    print(_selectedItemKeys);
  }

  void _onTap(Key key) {
    print(key.toString() + ' tapped');

    setState(() {
      if (_isSelecting) {
        if (_selectedItemKeys.contains(key)) {
          _selectedItemKeys.remove(key);
        } else {
          _selectedItemKeys.add(key);
        }

        if (_selectedItemKeys.isEmpty) {
          _isSelecting = false;
        }

        print('Still selecting? ' + _isSelecting.toString());
      }
    });

    print(_selectedItemKeys);
  }
}

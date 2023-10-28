import 'package:flutter/material.dart';
import 'package:flutter_sample/station/Item.dart';


// class StationsList extends StatelessWidget {
//   const StationsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(items[index].title),
//             // When a user taps the ListTile, navigate to the DetailScreen.
//             // Notice that you're not only creating a DetailScreen, you're
//             // also passing the current todo through to it.
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailScreen(item: items[index]),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class DetailScreen extends StatelessWidget {
//   // In the constructor, require a Todo.
//   const DetailScreen({super.key, required this.item});
//
//   // Declare a field that holds the Todo.
//   final Item item;
//
//   @override
//   Widget build(BuildContext context) {
//
//     // Use the Todo to create the UI.
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(item.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Text(item.description),
//       ),
//     );
//   }
// }

class StationsList extends StatefulWidget {
  const StationsList({super.key});

  @override
  ListTileSelectState createState() => ListTileSelectState();
}

class ListTileSelectState extends State<StationsList> {
  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isGridMode
            ? GridBuilder(
          isSelectionMode: isSelectionMode,
          selectedList: _selected,
          onSelectionChange: (bool x) {
            setState(() {
              isSelectionMode = x;
            });
          },
        )
            : ListBuilder(
          isSelectionMode: isSelectionMode,
          selectedList: _selected,
          onSelectionChange: (bool x) {
            setState(() {
              isSelectionMode = x;
            });
          },
        ));
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final Function(bool)? onSelectionChange;
  final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.selectedList.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () => _toggle(index),
            onLongPress: () {
              if (!widget.isSelectionMode) {
                setState(() {
                  widget.selectedList[index] = true;
                });
                widget.onSelectionChange!(true);
              }
            },
            child: GridTile(
                child: Container(
                  child: widget.isSelectionMode
                      ? Checkbox(
                      onChanged: (bool? x) => _toggle(index),
                      value: widget.selectedList[index])
                      : const Icon(Icons.image),
                )),
          );
        });
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.selectedList.length,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () => _toggle(index),
              onLongPress: () {
                if (!widget.isSelectionMode) {
                  setState(() {
                    widget.selectedList[index] = true;
                  });
                  widget.onSelectionChange!(true);
                }
              },
              trailing: widget.isSelectionMode
                  ? Checkbox(
                value: widget.selectedList[index],
                onChanged: (bool? x) => _toggle(index),
              )
                  : const SizedBox.shrink(),
              title: Text('item $index'));
        });
  }
}

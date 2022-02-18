import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:midterm_retry/room.dart';

class MoreDetailPage extends StatefulWidget {
  final Room room;
  const MoreDetailPage({Key? key, required this.room}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoreDetailPageState();
}

class _MoreDetailPageState extends State<MoreDetailPage> {
  late Room room;
  List productlist = [];
  late double screenHeight, screenWidth, resWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text('Room details',
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: CachedNetworkImage(
                      width: screenWidth,
                      fit: BoxFit.cover,
                      imageUrl: "https://slumberjer.com/rentaroom/images/" +
                          widget.room.roomid.toString() +
                          '_' +
                          '1' +
                          '.jpg',
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: CachedNetworkImage(
                      width: screenWidth,
                      fit: BoxFit.cover,
                      imageUrl: "https://slumberjer.com/rentaroom/images/" +
                          widget.room.roomid.toString() +
                          '_' +
                          '2' +
                          '.jpg',
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: CachedNetworkImage(
                      width: screenWidth,
                      fit: BoxFit.cover,
                      imageUrl: "https://slumberjer.com/rentaroom/images/" +
                          widget.room.roomid.toString() +
                          '_' +
                          '3' +
                          '.jpg',
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(widget.room.title.toString(),
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.3),
                        1: FractionColumnWidth(0.7)
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        TableRow(children: [
                          const Text('Description',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          Text(widget.room.description.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Price',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          Text("RM " +
                              double.parse(widget.room.price.toString())
                                  .toStringAsFixed(2)),
                        ]),
                        TableRow(children: [
                          const Text('Contact',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          Text(widget.room.contact.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Deposit',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          Text("RM " +
                              double.parse(widget.room.deposit.toString())
                                  .toStringAsFixed(2)),
                        ]),
                        TableRow(children: [
                          const Text('State',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          Text(widget.room.state.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Area',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          Text(widget.room.area.toString()),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Card(
                    elevation: 10,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                    ))),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:midterm_retry/room.dart';
import 'moredetailpage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List roomlist = [];
  String titlecenter = "Loading Rooms...";
  late double screenHeight, screenWidth, resWidth;
  late ScrollController _scrollController;
  int scrollcount = 6;
  int rowcount = 2;
  int numprd = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text('RentARoom',
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
      ),
      body: roomlist.isEmpty
          ? Center(
              child: Text(
                titlecenter,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "Available Rooms",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(numprd.toString() + " rooms found"),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: rowcount,
                    controller: _scrollController,
                    children: List.generate(scrollcount, (index) {
                      return Card(
                        child: InkWell(
                          onTap: () => {
                            _roomDetails(index),
                          },
                          child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "https://slumberjer.com/rentaroom/images/" +
                                          roomlist[index]['roomid'] +
                                          '_' +
                                          '1' +
                                          '.jpg',
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            truncateString(roomlist[index]
                                                    ['title']
                                                .toString()),
                                            style: TextStyle(
                                                fontSize: resWidth * 0.045,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "RM " +
                                                double.parse(roomlist[index]
                                                        ['price'])
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: resWidth * 0.03,
                                            )),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
    );
  }

  _roomDetails(int index) {
    Room room = Room(
      roomid: roomlist[index]['roomid'],
      contact: roomlist[index]['contact'],
      title: roomlist[index]['title'],
      description: roomlist[index]['description'],
      price: roomlist[index]['deposit'],
      deposit: roomlist[index]['deposit'],
      state: roomlist[index]['state'],
      area: roomlist[index]['area'],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MoreDetailPage(
                  room: room,
                )));
  }

  void _loadRooms() {
    http.post(Uri.parse("https://slumberjer.com/rentaroom/php/load_rooms.php"),
        body: {}).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        print(response.body);
        var extractdata = data['data'];
        setState(() {
          roomlist = extractdata["rooms"];
          numprd = roomlist.length;
          if (scrollcount >= roomlist.length) {
            scrollcount = roomlist.length;
          }
        });
      } else {
        setState(() {
          titlecenter = "No Data";
        });
      }
    });
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (roomlist.length > scrollcount) {
          scrollcount = scrollcount + 10;
          if (scrollcount >= roomlist.length) {
            scrollcount = roomlist.length;
          }
        }
      });
    }
  }

  String truncateString(String str) {
    if (str.length > 15) {
      str = str.substring(0, 15);
      return str + "...";
    } else {
      return str;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/view_itemcolor.dart';
import 'package:hawks/Repository/ApiServices.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/constants/url.dart';
import '../../constants/style.dart';
import 'package:http/http.dart' as http;

class ItemColor extends StatefulWidget {
  const ItemColor({Key? key}) : super(key: key);

  @override
  State<ItemColor> createState() => _ItemColorState();
}

class _ItemColorState extends State<ItemColor> {
  final TextEditingController color_code = TextEditingController();
  final TextEditingController color_name = TextEditingController();

  Future CreateItemColor() async {
    var request = http.MultipartRequest('POST', Uri.parse(create_itemcolor));
    request.fields
        .addAll({'color_code': color_code.text, 'color_name': color_name.text});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServices().ViewItemcolor();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Item Color"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SR.",
                      style: subheadline3,
                    ),
                    Text(
                      "Color Code",
                      style: subheadline3,
                    ),
                    Text(
                      "Color Name",
                      style: subheadline3,
                    ),
                    Text(
                      "Action",
                      style: subheadline3,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Expanded(
                    child: FutureBuilder<ViewItemcolorDetails>(
                        future: ApiServices().ViewItemcolor(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data?.data.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data?.data[index];
                                  return Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${index + 1}"),
                                            Text("#${data?.colorCode}"),
                                            Text("${data?.colorName}"),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    ApiServices()
                                                        .DeleteItemColorDetails(
                                                            "${data?.id}");
                                                    setState(() {});
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: redcolor,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                              color: primarycolor,
                            ));
                          }
                        }))
              ],
            )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: primarycolor,
            onPressed: () async {
              await _showDecline(context);
            },
            child: Icon(Icons.add),
          ),
        ));
  }

  Future<void> _showDecline(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Code"),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.clear)),
                ],
              ),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Color Code"),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .20),
                            Container(
                                width: MediaQuery.of(context).size.width * .30,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: lightblackcolor,
                                    width: 1.0,
                                  ),
                                )),
                                child: TextField(
                                  controller: color_code,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Color Code",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Color Name"),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .20),
                            Container(
                                width: MediaQuery.of(context).size.width * .30,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: lightblackcolor,
                                    width: 1.0,
                                  ),
                                )),
                                child: TextField(
                                  controller: color_name,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Color Name",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    )),
              ]),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Save"),
                  onPressed: () {
                    setState(() {
                      CreateItemColor();
                    });
                    Get.back();
                  },
                ),
                FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

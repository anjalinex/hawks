import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/view_itemsize_details.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/constants/url.dart';
import '../../Repository/ApiServices.dart';
import '../../constants/style.dart';
import 'package:http/http.dart' as http;

class ItemSize extends StatefulWidget {
  const ItemSize({Key? key}) : super(key: key);

  @override
  State<ItemSize> createState() => _ItemSizeState();
}

class _ItemSizeState extends State<ItemSize> {
  final TextEditingController size_code = TextEditingController();
  final TextEditingController size_name = TextEditingController();

  Future CreateItemSize() async {
    var request = http.MultipartRequest('POST', Uri.parse(create_itemsize));
    request.fields
        .addAll({'size_code': size_code.text, 'size_name': size_name.text});
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
    ApiServices().ViewItemsize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Item Size"),
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
                    Text("SR."),
                    Text("Size Code"),
                    Text("Size Name"),
                    Text("Action"),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Expanded(
                    child: FutureBuilder<ViewItemsizeDetails>(
                        future: ApiServices().ViewItemsize(),
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
                                            Text("${data?.sizeCode}"),
                                            Text("${data?.sizeName}"),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    ApiServices()
                                                        .DeleteItemSizeDetails(
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
                            Text("Size Code"),
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
                                  controller: size_code,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Size Code",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Size Name"),
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
                                  controller: size_name,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Size Name",
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
                      CreateItemSize();
                    });
                    Get.back();
                  },
                ),
                FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Get.back();
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

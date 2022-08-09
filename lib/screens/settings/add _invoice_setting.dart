import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Repository/ApiServices.dart';
import 'package:intl/intl.dart';
import '../../Model/models.dart';
import '../../Model/models.dart';
import '../../Model/models.dart';
import '../../Model/models.dart';
import '../../constants/color.dart';
import '../../constants/style.dart';
import '../../constants/url.dart';

class AddInvoiceSetting extends StatefulWidget {
  const AddInvoiceSetting({Key? key}) : super(key: key);

  @override
  State<AddInvoiceSetting> createState() => _AddInvoiceSettingState();
}

class _AddInvoiceSettingState extends State<AddInvoiceSetting> {
  final TextEditingController invoicename = TextEditingController();
  final TextEditingController terms_condition1 = TextEditingController();
  final TextEditingController terms_condition2 = TextEditingController();
  final TextEditingController terms_condition3 = TextEditingController();
  final TextEditingController terms_condition4 = TextEditingController();
  final TextEditingController bank_name = TextEditingController();
  final TextEditingController ifsc_code = TextEditingController();
  final TextEditingController account_no = TextEditingController();
  final TextEditingController bank_address = TextEditingController();
  final TextEditingController header_color = TextEditingController();

  late Branch Branchesdropdown = Branch(1, "ABC Private Limited");
  List<Branch> branch = <Branch>[
    Branch(1, 'ABC Private Limited'),
    Branch(2, 'ABC Private Limited2')
  ];

  late InvoiceFormat InvoiceFormatdropdownvalue = InvoiceFormat(1, "STANDARD");
  List<InvoiceFormat> invoiceFormat = <InvoiceFormat>[
    InvoiceFormat(1, 'STANDARD'),
    InvoiceFormat(2, 'THERMAL'),
    InvoiceFormat(3, 'SHORT THERMAL'),
    InvoiceFormat(4, 'CUSTOMIZED'),
    InvoiceFormat(5, 'STDCUSTOMIZED'),
    InvoiceFormat(6, 'TEMPLATE4'),
    InvoiceFormat(7, 'TEMPLATE5'),
  ];

  late InvoiceType InvoiceTypedropdownvalue = InvoiceType(1, "Sale");
  List<InvoiceType> invoiceType = <InvoiceType>[InvoiceType(1, 'Sale')];

  Future CreateInvoice() async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://hawksapi.nexinfosoft.com/Api/createinvoice'));
    request.fields.addAll({
      'branches': "${Branchesdropdown.Branch_value}",
      'invoice_type': "${InvoiceTypedropdownvalue.Invoice_value}",
      'invoice_format': "${InvoiceFormatdropdownvalue.InvoiceFormat_value}",
      'invoice_name': invoicename.text,
      'terms_condition1': terms_condition1.text,
      'terms_condition2': terms_condition2.text,
      'terms_condition3': terms_condition3.text,
      'terms_condition4': terms_condition4.text,
      'bank_name': bank_name.text,
      'ifsc_code': ifsc_code.text,
      'account_no': account_no.text,
      'bank_address': bank_address.text,
      'header_color': header_color.text
    });

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
    Branchesdropdown = branch[0];
    InvoiceFormatdropdownvalue = invoiceFormat[0];
    InvoiceTypedropdownvalue = invoiceType[0];
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: Text("Add Invoice Setting"),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView(children: [
            SizedBox(
              height: height * .02,
            ),
            Card(
                elevation: 2,
                shadowColor: primarycolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(width: 0.4, color: lightblackcolor),
                ),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Branches",
                              style: subheadline3,
                            ),
                            Container(
                              width: width * .50,
                              height: height * .04,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: lightblackcolor, width: 1)),
                              ),
                              child: DropdownButton<Branch>(
                                isExpanded: true,
                                underline: Container(),
                                hint: Text(
                                  "Select Branches",
                                  style: subheadline,
                                ),
                                value: Branchesdropdown,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: branch.map((Branch branch) {
                                  return DropdownMenuItem<Branch>(
                                    value: branch,
                                    child: Text(
                                      "${branch.Branch_value}".toString(),
                                      style: subheadline3,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Branch? newValue) {
                                  setState(() {
                                    Branchesdropdown = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Invoice Type",
                              style: subheadline3,
                            ),
                            Container(
                              width: width * .50,
                              height: height * .04,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: lightblackcolor, width: 1)),
                              ),
                              child: DropdownButton<InvoiceType>(
                                isExpanded: true,
                                underline: Container(),
                                hint: Text(
                                  "Select Invoice Type",
                                  style: subheadline,
                                ),
                                value: InvoiceTypedropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items:
                                    invoiceType.map((InvoiceType? invoiceType) {
                                  return DropdownMenuItem<InvoiceType>(
                                    value: invoiceType,
                                    child: Text(
                                      "${invoiceType?.Invoice_value}",
                                      style: subheadline3,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (InvoiceType? newValue) {
                                  setState(() {
                                    InvoiceTypedropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Invoice Format",
                              style: subheadline3,
                            ),
                            Container(
                              width: width * .50,
                              height: height * .04,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: lightblackcolor, width: 1)),
                              ),
                              child: DropdownButton<InvoiceFormat>(
                                isExpanded: true,
                                underline: Container(),
                                hint: Text(
                                  "Select Invoice Format",
                                  style: subheadline,
                                ),
                                value: InvoiceFormatdropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: invoiceFormat
                                    .map((InvoiceFormat? invoiceFormat) {
                                  return DropdownMenuItem<InvoiceFormat>(
                                    value: invoiceFormat,
                                    child: Text(
                                      "${invoiceFormat?.InvoiceFormat_value}",
                                      style: subheadline3,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (InvoiceFormat? newValue) {
                                  setState(() {
                                    InvoiceFormatdropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Invoice Name\nShow On Invoice",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: invoicename,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Terms &\nCondition Line 1",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: terms_condition1,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Terms &\nCondition Line 2",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: terms_condition2,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Terms &\nCondition Line 3",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: terms_condition3,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Terms &\nCondition Line 4",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: terms_condition4,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bank Name",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: bank_name,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "IFCS Code",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: ifsc_code,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Account No",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: account_no,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bank Address",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: bank_address,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Header Color",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextField(
                                  controller: header_color,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ))),
            SizedBox(
              height: height * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: width * .20,
                    child: CupertinoButton(
                      onPressed: () {
                        CreateInvoice();
                        // ApiServices().CreateInvoice(
                        //     Branchesdropdown.toString(),
                        //     InvoiceTypedropdownvalue.toString(),
                        //     InvoiceFormatdropdownvalue.toString(),
                        //     invoicename.text,
                        //     terms_condition1.text,
                        //     terms_condition2.text,
                        //     terms_condition3.text,
                        //     terms_condition4.text,
                        //     bank_name.text,
                        //     ifsc_code.text,
                        //     account_no.text,
                        //     bank_address.text,
                        //     header_color.text);
                        print(invoicename.text);
                         Get.back();
                      },
                      child: Text("Submit"),
                      color: primarycolor,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      pressedOpacity: 0.6,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )),
                Container(
                    width: width * .20,
                    child: CupertinoButton(
                      onPressed: () {},
                      child: Text("Cancle"),
                      color: lightblackcolor,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      pressedOpacity: 0.6,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ))
              ],
            ),
            SizedBox(
              height: height * .02,
            )
          ])),
    );
  }

  var _selectedDate;
  DateTime? datePicked;

  Future<void> _showDObPicker() async {
    datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(primary: primarycolor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });

    setState(() {
      _selectedDate = DateFormat("yyyy").format(datePicked!);
    });
  }
}

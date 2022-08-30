class ViewSalesDetails {
  String? message;
  List<Data>? data;

  ViewSalesDetails({this.message, this.data});

  ViewSalesDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? customerId;
  String? mobileNo;
  String? pos;
  String? salesType;
  String? salesOrdder;
  String? itemCentre;
  String? transVehNo;
  String? billNo;
  String? billDate;
  String? address;
  String? barcode;
  String? itemId;
  String? unitId;
  String? itemColorId;
  String? itemSizeId;
  String? currStock;
  String? qty;
  String? price;
  String? isdeleted;
  String? createdAt;
  String? unit;
  String? itemName;
  String? itemsize;
  String? itemcolor;

  Data(
      {this.id,
      this.customerId,
      this.mobileNo,
      this.pos,
      this.salesType,
      this.salesOrdder,
      this.itemCentre,
      this.transVehNo,
      this.billNo,
      this.billDate,
      this.address,
      this.barcode,
      this.itemId,
      this.unitId,
      this.itemColorId,
      this.itemSizeId,
      this.currStock,
      this.qty,
      this.price,
      this.isdeleted,
      this.createdAt,
      this.unit,
      this.itemName,
      this.itemsize,
      this.itemcolor});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    mobileNo = json['mobile_no'];
    pos = json['pos'];
    salesType = json['sales_type'];
    salesOrdder = json['sales_ordder'];
    itemCentre = json['item_centre'];
    transVehNo = json['trans_veh_no'];
    billNo = json['bill_no'];
    billDate = json['bill_date'];
    address = json['address'];
    barcode = json['barcode'];
    itemId = json['item_id'];
    unitId = json['unit_id'];
    itemColorId = json['item_color_id'];
    itemSizeId = json['item_size_id'];
    currStock = json['curr_stock'];
    qty = json['qty'];
    price = json['price'];
    isdeleted = json['isdeleted'];
    createdAt = json['created_at'];
    unit = json['unit'];
    itemName = json['item_name'];
    itemsize = json['itemsize'];
    itemcolor = json['itemcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['mobile_no'] = this.mobileNo;
    data['pos'] = this.pos;
    data['sales_type'] = this.salesType;
    data['sales_ordder'] = this.salesOrdder;
    data['item_centre'] = this.itemCentre;
    data['trans_veh_no'] = this.transVehNo;
    data['bill_no'] = this.billNo;
    data['bill_date'] = this.billDate;
    data['address'] = this.address;
    data['barcode'] = this.barcode;
    data['item_id'] = this.itemId;
    data['unit_id'] = this.unitId;
    data['item_color_id'] = this.itemColorId;
    data['item_size_id'] = this.itemSizeId;
    data['curr_stock'] = this.currStock;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['isdeleted'] = this.isdeleted;
    data['created_at'] = this.createdAt;
    data['unit'] = this.unit;
    data['item_name'] = this.itemName;
    data['itemsize'] = this.itemsize;
    data['itemcolor'] = this.itemcolor;
    return data;
  }
}

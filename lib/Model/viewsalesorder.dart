class ViewSalesOrderDetails {
  String? message;
  List<Data>? data;

  ViewSalesOrderDetails({this.message, this.data});

  ViewSalesOrderDetails.fromJson(Map<String, dynamic> json) {
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
  String? salesType;
  String? mobileNo;
  String? pos;
  String? customerId;
  String? saleType;
  String? billNo;
  String? billDate;
  String? deliveryDate;
  String? barcode;
  String? itemId;
  String? unitId;
  String? itemColorId;
  String? itmeSizeId;
  String? stock;
  String? qty;
  String? price;
  String? isdeleted;
  String? unit;
  String? itemsize;
  String? itemcolor;

  Data(
      {this.id,
        this.salesType,
        this.mobileNo,
        this.pos,
        this.customerId,
        this.saleType,
        this.billNo,
        this.billDate,
        this.deliveryDate,
        this.barcode,
        this.itemId,
        this.unitId,
        this.itemColorId,
        this.itmeSizeId,
        this.stock,
        this.qty,
        this.price,
        this.isdeleted,
        this.unit,
        this.itemsize,
        this.itemcolor});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesType = json['sales_type'];
    mobileNo = json['mobile_no'];
    pos = json['pos'];
    customerId = json['customer_id'];
    saleType = json['sale_type'];
    billNo = json['bill_no'];
    billDate = json['bill_date'];
    deliveryDate = json['delivery_date'];
    barcode = json['barcode'];
    itemId = json['item_id'];
    unitId = json['unit_id'];
    itemColorId = json['item_color_id'];
    itmeSizeId = json['itme_size_id'];
    stock = json['stock'];
    qty = json['qty'];
    price = json['price'];
    isdeleted = json['isdeleted'];
    unit = json['unit'];
    itemsize = json['itemsize'];
    itemcolor = json['itemcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sales_type'] = this.salesType;
    data['mobile_no'] = this.mobileNo;
    data['pos'] = this.pos;
    data['customer_id'] = this.customerId;
    data['sale_type'] = this.saleType;
    data['bill_no'] = this.billNo;
    data['bill_date'] = this.billDate;
    data['delivery_date'] = this.deliveryDate;
    data['barcode'] = this.barcode;
    data['item_id'] = this.itemId;
    data['unit_id'] = this.unitId;
    data['item_color_id'] = this.itemColorId;
    data['itme_size_id'] = this.itmeSizeId;
    data['stock'] = this.stock;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['isdeleted'] = this.isdeleted;
    data['unit'] = this.unit;
    data['itemsize'] = this.itemsize;
    data['itemcolor'] = this.itemcolor;
    return data;
  }
}

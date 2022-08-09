class Branch {
  int? Branch_id;
  String? Branch_value;

  Branch(this.Branch_id, this.Branch_value);
}

class InvoiceType {
  int? Invoice_id;
  String? Invoice_value;

  InvoiceType(this.Invoice_id, this.Invoice_value);
}

class InvoiceFormat {
  int? InvoiceFormat_id;
  String? InvoiceFormat_value;

  InvoiceFormat(this.InvoiceFormat_id, this.InvoiceFormat_value);
}

class TypeofCom {
  int? TypeofCom_id;
  String? TypeofCom_name;
  TypeofCom(this.TypeofCom_id, this.TypeofCom_name);
}

class Location{
  int? location_id;
  String? location_name;

  Location(this.location_id,this.location_name);
}

class Titel {
  int? title_id;
  String? title_name;

  Titel(this.title_id, this.title_name);
}

class GST {
  int? GST_id;
  String? GST_name;

  GST(this.GST_id, this.GST_name);
}

class GST1 {
  int? GST_id1;
  String? GST_name1;

  GST1(this.GST_id1, this.GST_name1);
}

class TaxCategory {
  int? taxcategory_id;
  String? taxcategory_name;
  TaxCategory(this.taxcategory_id, this.taxcategory_name);
}

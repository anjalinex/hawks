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

class Language {
  int? Language_id;
  String? Language_name;

  Language(this.Language_id, this.Language_name);
}

class DateFormate {
  int? dateformate_id;
  String? dateformate_name;

  DateFormate(this.dateformate_id, this.dateformate_name);
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

class Unit {
  int? unit_id;
  String? unit_name;
  Unit(this.unit_id, this.unit_name);
}

class PurcType {
  int? PurcType_id;
  String? PurcType_name;
  PurcType(this.PurcType_id, this.PurcType_name);
}

class GstType {
  int? GstType_id;
  String? GstType_name;
  GstType(this.GstType_id,this.GstType_name);
}

class SaleType{
  int? SaleType_id;
  String? SaleType_name;
  SaleType(this.SaleType_id,this.SaleType_name);
}

class SalesType{
  int? SalesType_id;
  String? SalesType_name;
  SalesType(this.SalesType_id,this.SalesType_name);
}
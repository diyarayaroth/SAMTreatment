class InsuranceListModel {
  int? page;
  int? recordCount;
  List<Rows>? rows;
  int? totalPages;

  InsuranceListModel({this.page, this.recordCount, this.rows, this.totalPages});

  InsuranceListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    recordCount = json['recordCount'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['recordCount'] = this.recordCount;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Rows {
  String? sIrow;
  String? frid;
  String? name1;
  String? name2;
  String? street1;
  String? city;
  String? street2;
  String? state;
  String? zip;
  String? phone;
  String? intake1;
  dynamic hotline1;
  String? website;
  String? latitude;
  String? longitude;
  String? otpIdNumber;
  String? miles;
  List<Services>? services;
  String? typeFacility;

  Rows(
      {this.sIrow,
      this.frid,
      this.name1,
      this.name2,
      this.street1,
      this.city,
      this.street2,
      this.state,
      this.zip,
      this.phone,
      this.intake1,
      this.hotline1,
      this.website,
      this.latitude,
      this.longitude,
      this.otpIdNumber,
      this.miles,
      this.services,
      this.typeFacility});

  Rows.fromJson(Map<String, dynamic> json) {
    sIrow = json['_irow'];
    frid = json['frid'];
    name1 = json['name1'];
    name2 = json['name2'];
    street1 = json['street1'];
    city = json['city'];
    street2 = json['street2'];
    state = json['state'];
    zip = json['zip'];
    phone = json['phone'];
    intake1 = json['intake1'];
    hotline1 = json['hotline1'];
    website = json['website'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    otpIdNumber = json['otp_id_number'];
    miles = json['miles'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    typeFacility = json['typeFacility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_irow'] = this.sIrow;
    data['frid'] = this.frid;
    data['name1'] = this.name1;
    data['name2'] = this.name2;
    data['street1'] = this.street1;
    data['city'] = this.city;
    data['street2'] = this.street2;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['intake1'] = this.intake1;
    data['hotline1'] = this.hotline1;
    data['website'] = this.website;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['otp_id_number'] = this.otpIdNumber;
    data['miles'] = this.miles;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['typeFacility'] = this.typeFacility;
    return data;
  }
}

class Services {
  String? f1;
  String? f2;
  String? f3;

  Services({this.f1, this.f2, this.f3});

  Services.fromJson(Map<String, dynamic> json) {
    f1 = json['f1'];
    f2 = json['f2'];
    f3 = json['f3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f1'] = this.f1;
    data['f2'] = this.f2;
    data['f3'] = this.f3;
    return data;
  }
}

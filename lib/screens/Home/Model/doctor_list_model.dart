// To parse this JSON data, do
//
//     final doctorListModel = doctorListModelFromJson(jsonString);

import 'dart:convert';

DoctorListModel doctorListModelFromJson(String str) =>
    DoctorListModel.fromJson(json.decode(str));

String doctorListModelToJson(DoctorListModel data) =>
    json.encode(data.toJson());

class DoctorListModel {
  final int total;
  final List<ProviderElement> providers;

  DoctorListModel({
    required this.total,
    required this.providers,
  });

  factory DoctorListModel.fromJson(Map<String, dynamic> json) =>
      DoctorListModel(
        total: json["total"],
        providers: List<ProviderElement>.from(
            json["providers"].map((x) => ProviderElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "providers": List<dynamic>.from(providers.map((x) => x.toJson())),
      };
}

class ProviderElement {
  final ProviderProvider provider;
  final Address address;
  final double distance;

  ProviderElement({
    required this.provider,
    required this.address,
    required this.distance,
  });

  factory ProviderElement.fromJson(Map<String, dynamic> json) =>
      ProviderElement(
        provider: ProviderProvider.fromJson(json["provider"]),
        address: Address.fromJson(json["address"]),
        distance: json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "provider": provider.toJson(),
        "address": address.toJson(),
        "distance": distance,
      };
}

class Address {
  final String street1;
  final String street2;
  final String city;
  final String state;
  final String zipcode;
  final String phone;

  Address({
    required this.street1,
    required this.street2,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street1: json["street1"],
        street2: json["street2"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "street1": street1,
        "street2": street2,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "phone": phone,
      };
}

class ProviderProvider {
  final String npi;
  final String name;
  final String providerType;
  final dynamic addresses;
  final dynamic plans;
  final List<String> specialties;
  final List<dynamic> facilityTypes;
  final bool valid;
  final String accepting;
  final String gender;
  final List<String> languages;
  final String taxonomy;
  final dynamic years;
  final String groupId;

  ProviderProvider({
    required this.npi,
    required this.name,
    required this.providerType,
    required this.addresses,
    required this.plans,
    required this.specialties,
    required this.facilityTypes,
    required this.valid,
    required this.accepting,
    required this.gender,
    required this.languages,
    required this.taxonomy,
    required this.years,
    required this.groupId,
  });

  factory ProviderProvider.fromJson(Map<String, dynamic> json) =>
      ProviderProvider(
        npi: json["npi"],
        name: json["name"],
        providerType: json["provider_type"],
        addresses: json["addresses"],
        plans: json["plans"],
        specialties: List<String>.from(json["specialties"].map((x) => x)),
        facilityTypes: List<dynamic>.from(json["facility_types"].map((x) => x)),
        valid: json["Valid"],
        accepting: json["accepting"],
        gender: json["gender"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        taxonomy: json["taxonomy"],
        years: json["years"],
        groupId: json["group_id"],
      );

  Map<String, dynamic> toJson() => {
        "npi": npi,
        "name": name,
        "provider_type": providerType,
        "addresses": addresses,
        "plans": plans,
        "specialties": List<dynamic>.from(specialties.map((x) => x)),
        "facility_types": List<dynamic>.from(facilityTypes.map((x) => x)),
        "Valid": valid,
        "accepting": accepting,
        "gender": gender,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "taxonomy": taxonomy,
        "years": years,
        "group_id": groupId,
      };
}

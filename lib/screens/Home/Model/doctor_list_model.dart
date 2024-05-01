// To parse this JSON data, do
//
//     final doctorListModel = doctorListModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

DoctorListModel doctorListModelFromJson(String str) =>
    DoctorListModel.fromJson(json.decode(str));

String doctorListModelToJson(DoctorListModel data) =>
    json.encode(data.toJson());

class DoctorListModel {
  dynamic total;
  List<ProviderElement>? providers;

  DoctorListModel({
    this.total,
    this.providers,
  });

  factory DoctorListModel.fromJson(Map<String, dynamic> json) =>
      DoctorListModel(
        total: json["total"],
        providers: json["providers"] == null
            ? []
            : List<ProviderElement>.from(
                json["providers"]!.map((x) => ProviderElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "providers": providers == null
            ? []
            : List<dynamic>.from(providers!.map((x) => x.toJson())),
      };
}

class ProviderElement {
  ProviderProvider? provider;
  Address? address;
  dynamic distance;

  ProviderElement({
    this.provider,
    this.address,
    this.distance,
  });

  factory ProviderElement.fromJson(Map<String, dynamic> json) =>
      ProviderElement(
        provider: json["provider"] == null
            ? null
            : ProviderProvider.fromJson(json["provider"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        distance: json["distance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "provider": provider?.toJson(),
        "address": address?.toJson(),
        "distance": distance,
      };
}

class Address {
  String? street1;
  Street2? street2;
  String? city;
  State? state;
  String? zipcode;
  String? phone;

  Address({
    this.street1,
    this.street2,
    this.city,
    this.state,
    this.zipcode,
    this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street1: json["street1"],
        street2: street2Values.map[json["street2"]]!,
        city: json["city"],
        state: stateValues.map[json["state"]]!,
        zipcode: json["zipcode"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "street1": street1,
        "street2": street2Values.reverse[street2],
        "city": city,
        "state": stateValues.reverse[state],
        "zipcode": zipcode,
        "phone": phone,
      };
}

enum State { MD, NJ, NY, PA }

final stateValues = EnumValues(
    {"MD": State.MD, "NJ": State.NJ, "NY": State.NY, "PA": State.PA});

enum Street2 { EMPTY, SUITE_2, SUITE_304, SUITE_B }

final street2Values = EnumValues({
  "": Street2.EMPTY,
  "SUITE 2": Street2.SUITE_2,
  "SUITE 304": Street2.SUITE_304,
  "SUITE B": Street2.SUITE_B
});

class ProviderProvider {
  String? npi;
  String? name;
  ProviderType? providerType;
  dynamic addresses;
  dynamic plans;
  List<String>? specialties;
  List<dynamic>? facilityTypes;
  bool? valid;
  Accepting? accepting;
  Gender? gender;
  List<String>? languages;
  String? taxonomy;
  dynamic years;
  String? groupId;

  ProviderProvider({
    this.npi,
    this.name,
    this.providerType,
    this.addresses,
    this.plans,
    this.specialties,
    this.facilityTypes,
    this.valid,
    this.accepting,
    this.gender,
    this.languages,
    this.taxonomy,
    this.years,
    this.groupId,
  });

  factory ProviderProvider.fromJson(Map<String, dynamic> json) =>
      ProviderProvider(
        npi: json["npi"],
        name: json["name"],
        providerType: providerTypeValues.map[json["provider_type"]]!,
        addresses: json["addresses"],
        plans: json["plans"],
        specialties: json["specialties"] == null
            ? []
            : List<String>.from(json["specialties"]!.map((x) => x)),
        facilityTypes: json["facility_types"] == null
            ? []
            : List<dynamic>.from(json["facility_types"]!.map((x) => x)),
        valid: json["Valid"],
        accepting: acceptingValues.map[json["accepting"]]!,
        gender: genderValues.map[json["gender"]]!,
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"]!.map((x) => x)),
        taxonomy: json["taxonomy"],
        years: json["years"],
        groupId: json["group_id"],
      );

  get firstName => null;

  Map<String, dynamic> toJson() => {
        "npi": npi,
        "name": name,
        "provider_type": providerTypeValues.reverse[providerType],
        "addresses": addresses,
        "plans": plans,
        "specialties": specialties == null
            ? []
            : List<dynamic>.from(specialties!.map((x) => x)),
        "facility_types": facilityTypes == null
            ? []
            : List<dynamic>.from(facilityTypes!.map((x) => x)),
        "Valid": valid,
        "accepting": acceptingValues.reverse[accepting],
        "gender": genderValues.reverse[gender],
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
        "taxonomy": taxonomy,
        "years": years,
        "group_id": groupId,
      };
}

enum Accepting { ACCEPTING, ACCEPTING_IN_SOME_LOCATIONS, NOT_ACCEPTING }

final acceptingValues = EnumValues({
  "accepting": Accepting.ACCEPTING,
  "accepting in some locations": Accepting.ACCEPTING_IN_SOME_LOCATIONS,
  "not accepting": Accepting.NOT_ACCEPTING
});

enum Gender { FEMALE, MALE, UNKNOWN }

final genderValues = EnumValues(
    {"Female": Gender.FEMALE, "Male": Gender.MALE, "unknown": Gender.UNKNOWN});

enum ProviderType { INDIVIDUAL }

final providerTypeValues = EnumValues({"Individual": ProviderType.INDIVIDUAL});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class CryptoModel {
  String coin;
  String wallet;
  String netWork;

  CryptoModel({
    required this.coin,
    required this.wallet,
    required this.netWork,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      coin: json["coin"] ?? "no i/p",
      wallet: json["wallet"] ?? "no i/p",
      netWork: json["netWork"] ?? "no i/p",
    );
  }
}

// Company Work
class CoordinatesModel {
  num lat;
  num lng;

  CoordinatesModel({required this.lat, required this.lng});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(lat: json["lat"], lng: json["lng"]);
  }
}

class AddressModel {
  String address;
  String city;
  String state;
  String stateCode;
  String postalCode;
  CoordinatesModel coordinates;
  String country;

  AddressModel({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.coordinates,
    required this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json["address"],
      city: json["city"],
      state: json["state"],
      stateCode: json["stateCode"],
      postalCode: json["postalCode"],
      coordinates: CoordinatesModel.fromJson(json["coordinates"]),
      country: json["country"],
    );
  }
}

class CompanyModel {
  String department;
  String name;
  String title;
  AddressModel address;

  CompanyModel({
    required this.department,
    required this.name,
    required this.title,
    required this.address,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      department: json["department"],
      name: json["name"],
      title: json["title"],
      address: AddressModel.fromJson(json["address"]),
    );
  }
}

class BankModel {
  String cardExpire;
  String cardNumber;
  String cardType;
  String currency;
  String iban;

  BankModel({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      cardExpire: json["cardExpire"],
      cardNumber: json["cardNumber"],
      cardType: json["cardType"],
      currency: json["currency"],
      iban: json["iban"],
    );
  }
}

class HairModel {
  String? color;
  String? type;

  HairModel({required this.color, required this.type});

  factory HairModel.fromJson(Map<String, dynamic> json) {
    return HairModel(color: json["color"], type: json["type"]);
  }
}

class UserModel {
  AddressModel address;
  int age;
  BankModel bank;
  String? birthDate;
  String? bloodGroup;
  CompanyModel company;
  CryptoModel crypto;
  String? ein;
  String email;
  String eyeColor;
  String? firstName;
  String gender;
  HairModel hair;
  num height;
  int id;
  String? image;
  String ip;
  String? lastName;
  String macAddress;
  String? maidenName;
  String password;
  String? phone;
  String role;
  String ssn;
  String university;
  String userAgent;
  String username;
  num weight;

  UserModel({
    required this.address,
    required this.age,
    required this.bank,
    required this.birthDate,
    required this.bloodGroup,
    required this.company,
    required this.crypto,
    required this.ein,
    required this.email,
    required this.eyeColor,
    required this.firstName,
    required this.gender,
    required this.hair,
    required this.height,
    required this.id,
    required this.image,
    required this.ip,
    required this.lastName,
    required this.macAddress,
    required this.maidenName,
    required this.password,
    required this.phone,
    required this.role,
    required this.ssn,
    required this.university,
    required this.userAgent,
    required this.username,
    required this.weight,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      address: AddressModel.fromJson(json["address"] ?? {}),
      age: json["age"] ?? 0,
      bank: BankModel.fromJson(json["bank"] ?? {}),
      birthDate: json["birthDate"] ?? "no i/p",
      bloodGroup: json["bloodGroup"] ?? "no i/p",
      company: CompanyModel.fromJson(json["company"] ?? {}),
      crypto: CryptoModel.fromJson(json["crypto"] ?? {}),
      ein: json["ein"]?? "no i/p",
      email: json["email"]?? "no i/p",
      eyeColor: json["eyeColor"]?? "no i/p",
      firstName: json["firstName"]?? "no i/p",
      gender: json["gender"]?? "no i/p",
      hair: HairModel.fromJson(json["hair"] ?? {}),
      height: json["height"]?? 0,
      id: json["id"] ?? 0,
      image: json["image"]??"https://oggyandthecockroaches.fandom.com/wiki/Oggy",
      ip: json["ip"]?? "no i/p",
      lastName: json["lastName"]?? "no i/p",
      macAddress: json["macAddress"]?? "no i/p",
      maidenName: json["maidenName"]?? "no i/p",
      password: json["password"]?? "no i/p",
      phone: json["phone"]?? "no i/p",
      role: json["role"]?? "no i/p",
      ssn: json["ssn"]?? "no i/p",
      university: json["university"]?? "no i/p",
      userAgent: json["userAgent"]?? "no i/p",
      username: json["username"]?? "no i/p",
      weight: json["weight"]?? "no i/p",
    );
  }
}

class AllDataModel {
  int total;
  int skip;
  int limit;
  List<UserModel> users;

  AllDataModel({
    required this.total,
    required this.skip,
    required this.limit,
    required this.users,
  });

  factory AllDataModel.fromJson(Map<String, dynamic> json) {
    List<UserModel> allData = [];

    for (Map<String, dynamic> eachJson in json["users"]) {
      allData.add(UserModel.fromJson(eachJson));
    }

    return AllDataModel(
      total: json["total"],
      skip: json["skip"],
      limit: json["limit"],
      users: allData,
    );
  }
}

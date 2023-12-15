// To parse this JSON data, do
//
//     final productCardResponse = productCardResponseFromJson(jsonString);

import 'dart:convert';

ProductCardResponse productCardResponseFromJson(String str) => ProductCardResponse.fromJson(json.decode(str));

String productCardResponseToJson(ProductCardResponse data) => json.encode(data.toJson());

class ProductCardResponse {
  List<Datum>? data;
  ProductCardResponseLinks? links;
  Meta? meta;
  bool? success;
  int? status;

  ProductCardResponse({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  factory ProductCardResponse.fromJson(Map<String, dynamic> json) => ProductCardResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    links: json["links"] == null ? null : ProductCardResponseLinks.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "success": success,
    "status": status,
  };
}

class Datum {
  int? id;
  String? name;
  String? thumbnailImage;
  bool? hasDiscount;
  String? discount;
  String? strokedPrice;
  String? mainPrice;
  int? rating;
  int? sales;
  bool? isWholesale;
  List<ChoiceOption>? choiceOptions;
  DatumLinks? links;

  Datum({
    this.id,
    this.name,
    this.thumbnailImage,
    this.hasDiscount,
    this.discount,
    this.strokedPrice,
    this.mainPrice,
    this.rating,
    this.sales,
    this.isWholesale,
    this.choiceOptions,
    this.links,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    thumbnailImage: json["thumbnail_image"],
    hasDiscount: json["has_discount"],
    discount: json["discount"],
    strokedPrice: json["stroked_price"],
    mainPrice: json["main_price"],
    rating: json["rating"],
    sales: json["sales"],
    isWholesale: json["is_wholesale"],
    choiceOptions: json["choice_options"] == null ? [] : List<ChoiceOption>.from(json["choice_options"]!.map((x) => ChoiceOption.fromJson(x))),
    links: json["links"] == null ? null : DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail_image": thumbnailImage,
    "has_discount": hasDiscount,
    "discount": discount,
    "stroked_price": strokedPrice,
    "main_price": mainPrice,
    "rating": rating,
    "sales": sales,
    "is_wholesale": isWholesale,
    "choice_options": choiceOptions == null ? [] : List<dynamic>.from(choiceOptions!.map((x) => x.toJson())),
    "links": links?.toJson(),
  };
}

class ChoiceOption {
  String? name;
  String? title;
  List<String>? options;

  ChoiceOption({
    this.name,
    this.title,
    this.options,
  });

  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
    name: json["name"],
    title: json["title"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
  };
}

class DatumLinks {
  String? details;

  DatumLinks({
    this.details,
  });

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
  };
}

class ProductCardResponseLinks {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  ProductCardResponseLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory ProductCardResponseLinks.fromJson(Map<String, dynamic> json) => ProductCardResponseLinks(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}


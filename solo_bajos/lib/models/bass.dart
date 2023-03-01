class BassResponse {
  List<Bass>? content;
  bool? last;
  bool? first;
  int? totalPages;
  int? totalElements;
  int? currentPage;

  BassResponse(
      {this.content,
      this.last,
      this.first,
      this.totalPages,
      this.totalElements,
      this.currentPage});

  BassResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Bass>[];
      json['content'].forEach((v) {
        content!.add(Bass.fromJson(v));
      });
    }
    last = json['last'];
    first = json['first'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    data['last'] = last;
    data['first'] = first;
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['currentPage'] = currentPage;
    return data;
  }
}

class Bass {
  String? brand;
  String? model;
  int? frets;
  String? image;
  String? origin;
  String? builtYear;
  int? price;
  int? discount;
  bool? isAvailable;
  String? state;

  Bass(
      {this.brand,
      this.model,
      this.frets,
      this.image,
      this.origin,
      this.builtYear,
      this.price,
      this.discount,
      this.isAvailable,
      this.state});

  Bass.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    model = json['model'];
    frets = json['frets'];
    image = json['image'];
    origin = json['origin'];
    builtYear = json['builtYear'];
    price = json['price'];
    discount = json['discount'];
    isAvailable = json['isAvailable'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand'] = brand;
    data['model'] = model;
    data['frets'] = frets;
    data['image'] = image;
    data['origin'] = origin;
    data['builtYear'] = builtYear;
    data['price'] = price;
    data['discount'] = discount;
    data['isAvailable'] = isAvailable;
    data['state'] = state;
    return data;
  }
}

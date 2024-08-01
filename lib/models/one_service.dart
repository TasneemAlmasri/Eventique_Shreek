enum ServiceCategories {
  venue,
  catering,
  flowers,
  cake,
  accesories,
  photography,
  entertainment,
  decoration,
  transportation,
}

class OneService {
  final int? serviceId;
  final String? name, vendorName;
  final double? price;
  final String? description;
  final bool? isDiscountedPackages;
  final bool? isActivated;
  final ServiceCategories? category;
  final double? rating;
  final List<String>? imgsUrl;

  OneService(
      {this.serviceId,
      this.name,
      this.vendorName,
      this.price,
      this.description,
      this.isDiscountedPackages,
      this.isActivated,
      this.category,
      this.rating,
      this.imgsUrl});
}

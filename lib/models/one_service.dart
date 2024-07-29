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
  final int serviceId;
  final String name,vendorName;
  final double price;
  final String description;
  final bool isDiscountedPackages;
  final bool isActivated;
  final ServiceCategories category;
  final double rating;
  final List<String>? imgsUrl;

  OneService(
      {required this.serviceId,
      required this.name,
      required this.vendorName,
      required this.price,
      required this.description,
      required this.isDiscountedPackages,
      required this.isActivated,
      required this.category,
      required this.rating,
      required this.imgsUrl});
}

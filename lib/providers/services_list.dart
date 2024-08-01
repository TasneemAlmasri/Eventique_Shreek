import '/models/one_service.dart';
import 'package:flutter/material.dart';

class AllServices with ChangeNotifier {
  final List<OneService> _allServices = [
    OneService(
      serviceId: 1,
      category: ServiceCategories.cake,
      name: 'Dream Cake',
      rating: 4.5,
      vendorName: 'Bee',
      imgsUrl: [
        'https://i.postimg.cc/jSD6s14x/photo-2024-04-25-23-30-29.jpg',
        'https://i.postimg.cc/1XznvgWm/photo-2024-04-25-23-30-28.jpg',
        'https://i.postimg.cc/y6rkV8QR/photo-2024-04-25-23-30-27.jpg'
      ],
      price: 24,
      description:
          'Indulge in our signature Velvet Symphony, a luxurious cake thats as much a feast for the eyes as it is for the palate. Each layer of this sumptuous treat is a harmonious blend of rich, moist red velvet cake, intertwined with delicate swirls of classic cream cheese frosting. Adorned with a crown of hand-piped rosettes and a sprinkle of edible gold dust, this cake is the perfect centerpiece for any celebration. Experience a taste of opulence with every slice',
      isDiscountedPackages: false,
      isActivated: true,
    ),
    OneService(
      serviceId: 2,
      category: ServiceCategories.flowers,
      name: 'Red Roses',
      rating: 4.1,
      vendorName: 'Sufian',
      imgsUrl: [
        'https://i.postimg.cc/1XznvgWm/photo-2024-04-25-23-30-28.jpg',
        'https://i.postimg.cc/jSD6s14x/photo-2024-04-25-23-30-29.jpg',
        'https://i.postimg.cc/y6rkV8QR/photo-2024-04-25-23-30-27.jpg'
      ],
      description:
          'They arrived in pristine condition, each rose vibrant and fragrant. Theyve been sitting on my dining table for over a week and still look as fresh as day one',
      price: 30,
      isDiscountedPackages: false,
      isActivated: true,
    ),
    OneService(
      serviceId: 3,
      category: ServiceCategories.venue,
      name: 'Royal Hall',
      rating: 3,
      vendorName: 'mimi',
      imgsUrl: [
        'https://i.postimg.cc/y6rkV8QR/photo-2024-04-25-23-30-27.jpg',
        'https://i.postimg.cc/jSD6s14x/photo-2024-04-25-23-30-29.jpg',
        'https://i.postimg.cc/1XznvgWm/photo-2024-04-25-23-30-28.jpg',
      ],
      price: 49,
      description: 'The staff was attentive, the ballroom was stunning',
      isDiscountedPackages: false,
      isActivated: true,
    ),
    OneService(
      serviceId: 4,
      category: ServiceCategories.catering,
      name: 'taboleh',
      rating: 1.1,
      vendorName: 'soso',
      imgsUrl: [
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
        'https://i.postimg.cc/y6rkV8QR/photo-2024-04-25-23-30-27.jpg',
        'https://i.postimg.cc/jSD6s14x/photo-2024-04-25-23-30-29.jpg',
        'https://i.postimg.cc/1XznvgWm/photo-2024-04-25-23-30-28.jpg',
      ],
      price: 188,
      description:
          'Refresh your senses with our Garden Fresco Salad, a vibrant tapestry of the seasons best. Crisp romaine lettuce, heirloom cherry tomatoes, and cool cucumber ribbons lay the foundation for a refreshing experience. Tossed with crunchy croutons, a sprinkle of feta cheese, and a light, zesty lemon-herb vinaigrette, this salad is a celebration of freshness. Perfect for a healthy lunch or a side to any entrée, our Garden Fresco Salad invites you to savor the bounty of the garden in every bite.',
      isDiscountedPackages: false,
      isActivated: true,
    ),
    OneService(
      serviceId: 5,
      category: ServiceCategories.cake,
      name: 'red velvet',
      rating: 2,
      vendorName: 'Lala',
      imgsUrl: [
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
        'https://i.postimg.cc/y6rkV8QR/photo-2024-04-25-23-30-27.jpg',
        'https://i.postimg.cc/jSD6s14x/photo-2024-04-25-23-30-29.jpg',
        'https://i.postimg.cc/1XznvgWm/photo-2024-04-25-23-30-28.jpg',
      ],
      price: 379,
      description:
          'Behold the Choco Indulgence, a cake that promises to take you on a journey of chocolate bliss. This decadent masterpiece features layers of moist, dark chocolate sponge cake, each one enrobed in a velvety ganache that melts in your mouth. The cake is finished with a lattice of chocolate drizzle and adorned with handcrafted truffles, creating a visual and sensory delight. Ideal for the chocolate connoisseur, the Choco Indulgence is a tribute to the timeless love affair with chocolate.',
      isDiscountedPackages: false,
      isActivated: true,
    ),
  ];

  List<OneService> get allServices {
    return [..._allServices];
  }

  OneService findById(int id) {
    return _allServices.firstWhere((element) => element.serviceId == id);
  }
}

import '/color.dart';
import '/providers/services_list.dart';
import '/widgets/image_slider.dart';
import '/widgets/my_tabBar.dart';
import '/widgets/my_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({super.key, required this.serviceId});
  final int serviceId;

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadedService = Provider.of<AllServices>(context, listen: false)
        .findById(widget.serviceId);

    return Scaffold(
      backgroundColor: beige,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Theme(
            data: Theme.of(context).copyWith(
              useMaterial3: false, // Disable Material 3 for NestedScrollView
            ),
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(
                      useMaterial3: true, // Enable Material 3 for SliverAppBar
                    ),
                    child: SliverAppBar(
                      backgroundColor: beige,
                      pinned: true,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          loadedService.name!,
                          style: TextStyle(
                              fontFamily: 'IrishGrover',
                              fontSize: 22,
                              color: primary),
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(4.0),
                        child: Container(
                          height: 4.0,
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ImageSliderScreen(imgList: loadedService.imgsUrl!),
                  ),
                  MyTabBar(tabController: _tabController),
                ];
              },
              body: MyTabBarView(
                tabController: _tabController,
                serviceId: widget.serviceId,
                description: loadedService.description!,
                vendorname: loadedService.vendorName!,
                serviceCategory: loadedService.category!.name,
                serviceRating: loadedService.rating!,
                price: loadedService.price!,
              ),
            ),
          );
        },
      ),
    );
  }
}

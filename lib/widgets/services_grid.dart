import '/models/one_service.dart';
import '/providers/services_list.dart';
import '/widgets/service_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesGrid extends StatelessWidget {
  ServicesGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<OneService> displayedServices =
        Provider.of<AllServices>(context).allServices;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        // Fade transition
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: (displayedServices.length > 0)
          ? GridView.builder(
              key: ValueKey<int>(
                  displayedServices.length), // Unique key for AnimatedSwitcher
              padding: const EdgeInsets.all(26),
              itemCount: displayedServices.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.9,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (ctx, i) => ServiceItem(
                imgurl: (displayedServices[i].imgsUrl != null ||
                        displayedServices[i].imgsUrl!.isNotEmpty)
                    ? displayedServices[i].imgsUrl![0]
                    : 'ops',
                name: displayedServices[i].name!, 
                rating: displayedServices[i].rating,
                serviceId: displayedServices[i].serviceId!,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            )
          : Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Text(
                'No Services Are Available Yet',
                style: TextStyle(
                  fontFamily: 'IrishGrover',
                  fontSize: 22,
                  color: Color.fromARGB(255, 227, 181, 193),
                ),
              ),
            ]),
    );
  }
}

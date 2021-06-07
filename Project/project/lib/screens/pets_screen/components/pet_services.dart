import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project/domain/models/pet_services_model.dart';
import 'package:project/widgets/app_size.dart';
import 'package:project/widgets/commons.dart';
import 'package:project/widgets/custom_text.dart';

import 'map_screen.dart';

List<PetServices> petServicesList = [
  PetServices(name: "Health", image: "health_pet.png"),
  PetServices(name: "Grooming", image: "grooming.png"),
  PetServices(name: "Flea treat", image: "bug.png"),
  PetServices(name: "Pet Sitting", image: "pet_sitting.png"),
  PetServices(name: "Nutrition", image: "feed.png"),
  PetServices(name: "Stores", image: "store.png"),
  PetServices(name: "Contact", image: "contact.png"),
];

class PetServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeFit.screenHeight / 5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: petServicesList.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: MapScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.transparent,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                            'assets/images/${petServicesList[index].image}'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: petServicesList[index].name,
                    size: 14,
                    color: ColorStyles.black,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

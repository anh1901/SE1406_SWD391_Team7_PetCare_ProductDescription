import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare/models/pet_services_model.dart';
import 'package:petcare/widgets/app_size.dart';

List<PetServices> petServicesList = [
  PetServices(
      name: "Health",
      image:
          "https://image.freepik.com/free-vector/tiny-doctors-caring-dog-vet-office_74855-6677.jpg"),
  PetServices(
      name: "Grooming", image: "https://en.pimg.jp/068/619/211/1/68619211.jpg"),
  PetServices(
      name: "Flea treat",
      image:
          "https://image.freepik.com/free-vector/dog-washing-service-flat-illustration-hairdresser-shampooing-cute-domestic-animal-cartoon-character_198278-4971.jpg"),
  PetServices(
      name: "Pet Sitting",
      image:
          "https://image.freepik.com/free-vector/pet-services-abstract-concept-illustration-pet-sitting-boarding-services-animal-care-services-dog-walking-grooming-salon-daycare-attention-transportation_335657-3646.jpg"),
  PetServices(
      name: "Nutrition",
      image:
          "https://image.freepik.com/free-vector/pet-shop-interior-with-scratching-post-cats-toys-bowl-feed-bag-cans-cartoon-illustration-store-with-accessories-domestic-animals-aquarium-fish-collar-dogs-balls_107791-5927.jpg"),
  PetServices(
      name: "Stores",
      image:
          "https://image.freepik.com/free-vector/pet-shop-illustration_1284-25873.jpg"),
  PetServices(
      name: "Contact us",
      image:
          "https://ecomchill.com/wp-content/uploads/2020/04/how-to-make-a-contact-us-page-on-shopify-2-1.jpg"),
];

class PetServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeFit.screenHeight / 5.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
          ),
          items: imageSliders,
        ),
      ),
    );
  }

  final List<Widget> imageSliders = petServicesList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item.image,
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            '${item.name}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
}

// Container(
// height: SizeFit.screenHeight / 5.3,
// child: ListView.builder(
// scrollDirection: Axis.horizontal,
// itemCount: petServicesList.length,
// itemBuilder: (_, index) {
// return GestureDetector(
// onTap: () {
// //
// },
// child: Padding(
// padding: const EdgeInsets.all(5.0),
// child: Column(
// children: <Widget>[
// Padding(
// padding: const EdgeInsets.all(5.0),
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(Radius.circular(20.0)),
// color: Colors.transparent,
// ),
// child: ClipRRect(
// borderRadius: BorderRadius.circular(8.0),
// child: Image.asset(
// 'assets/images/${petServicesList[index].image}'),
// ),
// ),
// ),
// SizedBox(
// height: 5,
// ),
// CustomText(
// text: petServicesList[index].name,
// size: 14,
// color: ColorStyles.black,
// )
// ],
// ),
// ),
// )

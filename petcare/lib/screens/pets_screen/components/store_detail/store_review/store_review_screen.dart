import 'package:flutter/material.dart';
import 'package:petcare/models/review_model.dart';
import 'package:petcare/screens/pets_screen/components/store_detail/store_review/review_item.dart';
import 'package:petcare/widgets/custom_text.dart';

List<Review> reviews = [
  Review(
      message: "Very confortable!!",
      user: "Nan",
      userImage: "https://pngimg.com/uploads/dog/dog_PNG50376.png",
      rate: 4),
  Review(
      message: "Good attention, good food, good. Amazing places",
      user: "Elliot",
      userImage: "https://pngimg.com/uploads/dog/dog_PNG50377.png",
      rate: 3),
  Review(
      message: "Best place for pet :)",
      user: "Matt",
      userImage: "https://pngimg.com/uploads/dog/dog_PNG50378.png",
      rate: 5),
];

class StoreReviewScreen extends StatelessWidget {
  const StoreReviewScreen({Key key, this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: "Customer's Reviews:",
              size: 20,
              fontWeight: FontWeight.bold),
          Divider(),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: reviews.length,
              itemBuilder: (context, index) =>
                  ReviewItem(review: reviews[index])),
        ],
      ),
    );
  }
}

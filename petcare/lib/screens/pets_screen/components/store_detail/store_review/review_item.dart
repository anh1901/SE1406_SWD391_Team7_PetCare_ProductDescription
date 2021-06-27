import 'package:flutter/material.dart';
import 'package:petcare/models/review_model.dart';
import 'package:petcare/widgets/custom_text.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({
    Key key,
    this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(review.userImage),
          ),
        ),
        title: Text(review.user),
        subtitle: Text(review.message),
        trailing: CustomText(
          text: review.rate.toString() + " stars",
          fontWeight: FontWeight.bold,
          size: 14,
        ),
      ),
    );
  }
}

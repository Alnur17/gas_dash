import 'package:get/get.dart';

class AboutDriverInformationController extends GetxController {
  var rating = 0.obs;
  var reviewText = ''.obs;

  bool get canSubmit => rating.value > 0 && reviewText.value.trim().isNotEmpty;

  void setRating(int newRating) {
    rating.value = newRating;
  }

  void setReviewText(String text) {
    reviewText.value = text;
  }

  // void submitReview() {
  //   if (canSubmit) {
  //     // Add your submit logic here
  //     Get.snackbar('Success', 'Review submitted',
  //         snackPosition: SnackPosition.BOTTOM);
  //     // Reset after submit
  //     rating.value = 0;
  //     reviewText.value = '';
  //   }
  // }
}

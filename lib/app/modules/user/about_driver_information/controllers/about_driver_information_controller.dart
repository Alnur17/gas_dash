import 'dart:convert';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../model/driver_review_model.dart';

class AboutDriverInformationController extends GetxController {
  var rating = 0.obs;
  var reviewText = ''.obs;
  var reviews = <Datum>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var driverFullName = 'Unknown'.obs;
  var driverRole = 'Driver'.obs;
  var driverExperience = 0.obs;
  var averageRating = 0.0.obs;

  bool get canSubmit => rating.value > 0 && reviewText.value.trim().isNotEmpty;

  void setRating(int newRating) {
    rating.value = newRating;
  }

  void setReviewText(String text) {
    reviewText.value = text;
  }

  // Fetch reviews for a driver and extract driver details
  Future<void> fetchReviews(String driverId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.accessToken)}',
      };

      final response = await BaseClient.getRequest(
        api: Api.getReviews(driverId),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      final driverReviewModel = DriverReviewModel.fromJson(result);

      if (driverReviewModel.success == true) {
        reviews.assignAll(driverReviewModel.data);

        // Extract driver details from the first review (if available)
        if (reviews.isNotEmpty && reviews[0].driverId != null) {
          driverFullName.value = reviews[0].driverId!.fullname ?? 'Unknown';
          driverRole.value = reviews[0].driverId!.role ?? 'Driver';
          driverExperience.value = reviews[0].driverId!.experience ?? 0;
        }

        // Calculate average rating
        if (reviews.isNotEmpty) {
          final totalRating = reviews.fold<double>(
            0.0,
                (sum, review) => sum + (review.rating ?? 0.0),
          );
          averageRating.value = totalRating / reviews.length;
        } else {
          averageRating.value = 0.0;
        }
      } else {
        errorMessage.value = driverReviewModel.message ?? 'Failed to load reviews';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Calculate rating distribution for progress bars (1 to 5 stars)
  Map<int, double> getRatingDistribution() {
    if (reviews.isEmpty) {
      return {5: 0.0, 4: 0.0, 3: 0.0, 2: 0.0, 1: 0.0};
    }

    final ratingCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in reviews) {
      final rating = (review.rating ?? 0.0).round();
      if (rating >= 1 && rating <= 5) {
        ratingCounts[rating] = ratingCounts[rating]! + 1;
      }
    }

    final totalReviews = reviews.length;
    return ratingCounts.map((key, value) => MapEntry(key, value / totalReviews));
  }

  // Submit a review for a driver
  Future<bool> submitReview(String? driverId) async {
    if (driverId == null) {
      errorMessage.value = 'Driver ID is required';
      return false;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final String? token = LocalStorage.getData(key: AppConstant.accessToken);
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Authentication token not found. Please log in.';
        return false;
      }

      Map<String, dynamic> decodedToken;
      try {
        decodedToken = JwtDecoder.decode(token);
      } catch (e) {
        errorMessage.value = 'Invalid authentication token';
        return false;
      }

      String? userId = decodedToken['userId']?.toString();
      if (userId == null) {
        errorMessage.value = 'User ID not found in token';
        return false;
      }

      final headers = {
        'Content-Type': 'application/json',
        //'Authorization': 'Bearer $token',
      };

      final body = json.encode({
        'driverId': driverId,
        'userId': userId,
        'rating': rating.value.toDouble(),
        'review': reviewText.value.trim(),
      });

      final response = await BaseClient.postRequest(
        api: Api.createReview(driverId),
        body: body,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      if (result['success'] == true) {
        // Clear the form
        rating.value = 0;
        reviewText.value = '';
        // Refresh reviews
        await fetchReviews(driverId);
        return true;
      } else {
        errorMessage.value = result['message'] ?? 'Failed to submit review';
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
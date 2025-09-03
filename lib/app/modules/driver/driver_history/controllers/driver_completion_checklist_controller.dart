import 'dart:convert';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_proof_of_delivery_view.dart';
import 'package:get/get.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../model/questions_model.dart';

class DriverCompletionChecklistController extends GetxController {
  // Reactive list to store questions from API
  var questions = <Datum>[].obs;

  // Reactive map to store user answers (question ID -> answer)
  var answers = <String, bool>{}.obs;

  // Loading state
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  // Fetch questions from API
  Future<void> fetchQuestions() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(
        api: Api.questions,
        headers: {'Content-Type': 'application/json'},
      );
      final result = await BaseClient.handleResponse(response);
      final questionsModel = QuestionsModel.fromJson(result);
      if (questionsModel.success == true && questionsModel.data != null) {
        questions.assignAll(questionsModel.data!.data);
        // Initialize answers map with default values (false for "No")
        for (var question in questions) {
          answers[question.id!] = false;
        }
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading(false);
    }
  }

  // Toggle answer for a question
  void toggleAnswer(String questionId, bool value) {
    answers[questionId] = value;
    debugPrint('Toggled answer for $questionId to $value'); // Debug to confirm update
    answers.refresh(); // Ensure UI updates
  }

  // Submit answers to API
  Future<void> submitAnswers(String deliveryId, String orderId) async {
    try {
      isLoading(true);
      // Prepare the body according to the API structure
      String accessToken = LocalStorage.getData(key: AppConstant.accessToken);
      final body = json.encode({
        'orderId': orderId,
        'questions': questions
            .map((q) => {
          'question': q.text,
          'answer': answers[q.id!], // Use boolean directly as per your current setup
          'explanation': answers[q.id!], // Adjust if explanation needs a string
        })
            .toList(),
      });
      debugPrint('Submitting with orderId: $orderId, body: $body');
      // Include Authorization token in headers
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await BaseClient.postRequest(
        api: Api.questionsCheckList,
        body: body,
        headers: headers,
      );
      final result = await BaseClient.handleResponse(response);
      if (result['success'] == true ||
          result['message'] == 'Checklist created successfully') {
        Get.to(() => DriverProofOfDeliveryView(deliveryId,orderId));
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading(false);
    }
  }
}
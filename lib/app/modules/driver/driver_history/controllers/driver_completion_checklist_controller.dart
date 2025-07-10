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
  var questions = <Datum>[].obs;
  var answers = <String, bool>{}.obs;
  var explanations = <String, String>{}.obs; // New map for explanations
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

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
        for (var question in questions) {
          answers[question.id!] = false;
          explanations[question.id!] = ''; // Initialize empty explanation
        }
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }

  void toggleAnswer(String questionId, bool value) {
    answers[questionId] = value;
    if (value == false && explanations[questionId]!.isEmpty) {
      explanations[questionId] = ''; // Ensure explanation is initialized
    }
    debugPrint('Toggled answer for $questionId to $value');
    answers.refresh();
    explanations.refresh();
  }

  void updateExplanation(String questionId, String explanation) {
    explanations[questionId] = explanation;
    explanations.refresh();
  }

  Future<void> submitAnswers(String deliveryId, String orderId) async {
    try {
      isLoading(true);
      final body = json.encode({
        'orderId': orderId,
        'questions': questions.map((q) => {
          'question': q.text,
          'answer': answers[q.id!],
          'explanation': explanations[q.id!] ?? '', // Include explanation
        }).toList(),
      });
      debugPrint('Submitting with orderId: $orderId, body: $body');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.accessToken)}',
      };

      final response = await BaseClient.postRequest(
        api: Api.questionsCheckList,
        body: body,
        headers: headers,
      );
      final result = await BaseClient.handleResponse(response);
      if (result['success'] == true ||
          result['message'] == 'Checklist created successfully') {
        Get.to(() => DriverProofOfDeliveryView(deliveryId, orderId));
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }
}
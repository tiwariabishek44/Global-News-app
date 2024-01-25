import 'dart:convert';
import 'dart:developer';


import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_reading/app/config/api_end_points.dart';
import 'package:news_reading/app/models/news_models.dart';
import 'package:news_reading/app/widget/custom_snackbar.dart';

class HomepageController extends GetxController {
  var dataList = <Article>[].obs; // Change to observe the list of Articles
  var isLoading = false.obs;
  var selectedCategory = 'All'.obs; 
  var _currentSlide = 0.obs;

  int get currentSlide => _currentSlide.value;

   List<String> categoriesList = [
      'All',
      'Entertainment',
      'Health',
      'Sports',
      'Business',
      'Technology'
    ];// Default selected category




  void onSlideChanged(int index, CarouselPageChangedReason reason) {
    _currentSlide.value = index;
  }

  



  Future<void> fetchData(String category) async {
    try {
      isLoading(true);
      String url = "${ApiEndpoints.baseUrl}everything?q=$category&apiKey=${ApiEndpoints.apiKey}";
      log("HITTING THE URL : $url");
      
      http.Response response = await http.get(Uri.parse("https://newsapi.org/v2/everything?q=${category}&apiKey=8a5ec37e26f845dcb4c2b78463734448"), headers: {
         "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        log("RESPONSE FORM NEWS: ${response}");
        var result = NewsModel.fromJson(json.decode(response.body));
        if (result.articles.isNotEmpty) {
          dataList.assignAll(result.articles);
        } else {
          dataList.clear(); // Clear the list if no articles are available
        }
      } else {
        dataList.clear(); // Clear the list on error status
      }
    } catch (e) {
      print('Error while getting data: $e');
      dataList.clear(); // Clear the list on error
    } finally {
      isLoading(false);
    }
  }

  void selectCategory(String category) {
    selectedCategory(category);
    fetchData(category); // Update data based on the selected category
  }

@override
void onInit() {
  super.onInit();
  // Fetch data only if the list is empty
  if (dataList.isEmpty) {
    fetchData(selectedCategory.value);
  }
}
}

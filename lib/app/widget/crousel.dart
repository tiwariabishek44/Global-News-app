import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:news_reading/app/modules/homepage/home_page_controller.dart';

class CustomCarouselItem extends StatelessWidget {
  final HomepageController myDataController = Get.put(HomepageController());

 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
              height: 200, // Adjust the height of the carousel
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                onPageChanged: myDataController.onSlideChanged,
                ),
                items: myDataController.dataList
                    .getRange(0, 5) // Displaying the first 5 items
                    .map((newsItem) {
                  return  Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[300],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              newsItem.urlToImage ?? '', // Use a default empty string if URL is null
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Display a placeholder icon or news image when there's an error
                return Icon(Icons.newspaper, size: 40);
              },
            ),
          ),
        );
                  
                  
                   
                }).toList(),
              ),
            ),
 Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5, // Change this to the total number of icons above
                    (index) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (index == myDataController.currentSlide)
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      );
                    },
                  ),
                )),
             
      ],
    );
    
    
   
  }
}
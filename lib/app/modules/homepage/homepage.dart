import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_reading/app/models/news_models.dart';
import 'package:news_reading/app/modules/details_page/details_page.dart';
import 'package:news_reading/app/modules/homepage/home_page_controller.dart';
import 'package:news_reading/app/widget/crousel.dart';
import 'package:news_reading/app/widget/custom_app_bar.dart';
import 'package:news_reading/app/widget/loading_screen.dart';
import 'package:news_reading/app/widget/no_data_widget.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatelessWidget {
  final HomepageController myDataController = Get.put(HomepageController());

  Future<void> _refreshData(String category) async {
    myDataController.fetchData(category); // Fetch data based on the selected category
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(leadingIcon: Icons.newspaper, title: 'HomePage', back: false),
    
    
    
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

           Container(
            child: Column(
              children: [
                SizedBox(
              height: 35, // Adjust the height as needed
              child:
              
               ListView.builder(
                 scrollDirection: Axis.horizontal,
                itemCount: myDataController.categoriesList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () {
                             myDataController.selectedCategory.value = myDataController.categoriesList[index];
                          _refreshData(myDataController.categoriesList[index]);
                       
                        },
                        style: ElevatedButton.styleFrom(
                          primary: myDataController.selectedCategory.value == myDataController.categoriesList[index]
                              ? Colors.red // Red background for selected category
                              : Colors.white, // Transparent background for others
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Rounded corners
                            side: BorderSide(color: Color.fromARGB(255, 27, 22, 22)), // Border color
                          ),
                        ),
                        child: Text(
                          myDataController.categoriesList[index],
                          style: TextStyle(
                            color: myDataController.selectedCategory.value == myDataController. categoriesList[index]
                                ? Colors.white // White text for selected category
                                : Colors.black, // Black text for others
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
              ],
            ),),
            // Horizontal scrollable list of categories
            

            SizedBox(height: 20,),

            
            Center(
              child: Obx(() {
                if (myDataController.isLoading.value) {
                  return LoadingScreen();
                } else {
                  return myDataController.dataList.isEmpty
                      ? NoDataWidget(message: "There is no news", iconData: Icons.error_outline)
                      : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCarouselItem( ),
                          SizedBox(height: 9,),

                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: const Text('Latest News', style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 24, 21, 21)),),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                             shrinkWrap:  true,
                              itemCount: myDataController.dataList.length,
                              itemBuilder: (context, index) {
                                final newsItem = myDataController.dataList![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => NewsDetailsPage(article: newsItem));
                                    },
                                    child: Card(
                                      elevation: 2,
                                      child: _buildCardContent(context, newsItem),
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                }}),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildCardContent(BuildContext context, newsItem) {
  final Source source = newsItem.source;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(newsItem.publishedAt);
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 2 / 5,
          height: MediaQuery.of(context).size.width * 2 / 5,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
  imageUrl: newsItem.urlToImage ?? '', // Use a default empty string if URL is null
  fit: BoxFit.cover,
  errorWidget: (context, url, error) => Icon(Icons.error_outline, size: 40), // Placeholder icon for error
),

          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsItem.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                newsItem.description ?? 'Description not available',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 1,),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          ' $formattedDate',
                          style: TextStyle(
                            
                            color: Colors.grey),
                        ),
                    ],
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 33.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      source.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 55, 132, 232),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


}

 
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:task_3/pages/login.pages.dart';
import 'package:task_3/services/preferences.services.dart';
import 'package:task_3/utilities/edges.dart';
import 'package:task_3/widgets/recommended_widget.dart';
import 'package:task_3/widgets/section_header.dart';
import 'package:task_3/widgets/today_widget.dart';

class HomePageScreen extends StatefulWidget {


  HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  var sliderIndex = 0;
  CarouselController carouselControllerEx = CarouselController();

  var images = [
    "images/slider_image1.jpg",
    "images/slider_image2.jpg",
    "images/slider_image3.jpg",
    "images/slider_image4.jpg",
    "images/slider_image5.jpg",
  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Edges.appHorizontalPadding),
          child: Icon(Icons.menu),
        ),
        actions: [Icon(Icons.notifications),
          PopupMenuButton<int>(onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0,
                child: Text("Logout"))
          ])
        ],

      ),
      body: Stack(
        children: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: Edges.appHorizontalPadding),
          child: ListView(
              scrollDirection: Axis.vertical,
              children: [
            SizedBox(height: 10,),
            Text("Bonjour, Maha", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10,),
            Expanded(child: Text("What would you like to cook today?", style: TextStyle(fontSize: 30),)),
            SizedBox(height: 10,),

            Row(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade300),
                  height: 50, width: 280,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                        labelText: "Search for recipes",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(width: 20,),

                Container(height: 50, width: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade300,),
                  child: IconButton(icon: Icon(Icons.menu) ,onPressed: (){
                  },),
                )

              ],
            ),

            SizedBox(height: 10,),
            CarouselSlider(
              carouselController: carouselControllerEx,
              options: CarouselOptions(
                  height: 200.0, autoPlay: true,
                  onPageChanged: (index,_){
                    sliderIndex = index;
                    setState(() {
                    });
                  }),
              items: images.map((i) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.amber
                        ),
                        child:
                        Image.asset(i, fit: BoxFit.cover,)
                        // Text('text $i', style: TextStyle(fontSize: 16.0),)
                    );

              }).toList(),
            ),
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      carouselControllerEx.previousPage(
                        duration: Duration(microseconds: 300),
                        curve: Curves.linear,
                      );

                    }, icon: Icon(Icons.arrow_back, size: 30,)),
                    IconButton(onPressed: (){
                      carouselControllerEx.nextPage(
                        duration: Duration(microseconds: 300),
                        curve: Curves.linear,
                      );
                    }, icon: Icon(Icons.arrow_forward, size: 30)),
                  ],
                ),
            DotsIndicator(
              dotsCount: images.length,
              position: sliderIndex,
              decorator: DotsDecorator(
                color: Colors.black87, // Inactive color
                activeColor: Colors.redAccent,
              ),
              onTap: (position)async {
                await carouselControllerEx.animateToPage(position);
                sliderIndex = position;
                setState(() {
                });
              },
            ),
            SizedBox(height: 10,),
            SectionHeader(sectionName: "Today's Fresh Recipes"),

            SizedBox(height: 10,),



            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 200, child: ListView.builder(
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return Row(
                            children: [
                              Container(height: 160,width: 200, margin: EdgeInsets.fromLTRB(0, 10, 40, 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade300 ),
                              child: TodayWidget(imageName: Image.asset("images/slider_image2.jpg"),
                                  headerText: "Breakfast",
                                  titleText: "French Toast with Berries", caloriesText: "120 Calories",
                                  timeText: "10 mins", servingText: "1 Serving"),
                              ),
                              Container(height: 160,width: 200, margin: EdgeInsets.fromLTRB(0, 10, 40, 10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade300 ),
                                child: TodayWidget(imageName: Image.asset("images/slider_image3.jpg"),
                                    headerText: "Breakfast",
                                    titleText: "Brown Sugar Cinnamon Toast", caloriesText: "135 Calories",
                                    timeText: "15 mins", servingText: "1 Serving"),
                              ),
                            ],
                          );
                        }),),


                    SectionHeader(sectionName: "Recommended"),
                    SizedBox(height: 10,),
                    Flexible(child:
                    ListView.separated(
                        itemCount: 1,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                      return Column(
                        children: [
                          RecommendedWidget(imageName: Image.asset("images/slider_image2.jpg",),
                            headerText: "Breakfast",
                            titleText: "Blueberry Muffins", caloriesText: "120 Calories",
                            timeText: "10 mins", servingText: "1 Serving"),
                          SizedBox(height: 10,),
                          RecommendedWidget(imageName: Image.asset("images/slider_image4.jpg"),
                              headerText: "Main Dish",
                              titleText: "Glazed Salmon", caloriesText: "280 Calories",
                              timeText: "45 mins", servingText: "1 Serving"),
                        ],
                      );
                    }, separatorBuilder: (context, index) { return SizedBox(height: 15,);
                          },
                    ))
                  ],
                ),
              ),
            )


          ]),
        ),


      ]),

    );
  }

  onSelected(BuildContext context, int item) {
    switch (item){
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
        PrefrencesService.prefs?.remove("user");
        PrefrencesService.prefs?.remove("password");
        break;
    }
  }

}

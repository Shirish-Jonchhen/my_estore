import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/consts/list.dart';
import 'package:my_estore/controllers/home_controller.dart';
import 'package:my_estore/services/firestore_services.dart';
import 'package:my_estore/views/category_screen/items_details.dart';
import 'package:my_estore/views/home_screen/search_screen.dart';
import 'package:my_estore/widgets/featured_button.dart';
import 'package:my_estore/widgets/home_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen  ({super.key});



  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: lightGrey,
              height: 60,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap((){
                    if(controller.searchController.text.isNotEmptyAndNotNull){
                      Get.to(() => SeacrchScreen(title: controller.searchController.text,));
                    }
                  }),
                  suffixIconColor: Colors.black,
                  filled: true,
                  fillColor: whiteColor, 
                  hintText: searchAnything,
                  hintStyle: TextStyle(color: textfieldGrey)
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column( 
                  children: [
                    //swiper (image slider)
                    VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150,
                      itemCount: slidersList.length, 
                      enlargeCenterPage: true,
                      itemBuilder: (context,index) => swiperBuilder(context, index, slidersList),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) => HomeButtons(
                        height: context.screenHeight*0.15,
                        width: context.screenWidth/2.5,
                        icon: index == 0? icTodaysDeal : icFlashDeal,
                        title: index == 0? todaysDeal : flaseSale,
                        onPress: (){},
                      )),
                    ),
                    10.heightBox,
                    //2nd slider
                    VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150,
                      itemCount: slidersList2.length, 
                      enlargeCenterPage: true,
                      itemBuilder: (context,index) => swiperBuilder(context, index, slidersList2),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (index) => HomeButtons(
                          height: context.screenHeight*0.15,
                          width: context.screenWidth/3.5,
                          icon: index == 0? icTopCategories :index == 1 ? icBrands : icTopSeller,
                          title: index == 0? topCategpries :index == 1 ? brand : topSellers,
                          onPress: (){},
                        )
                      ),
                    ),
                    20.heightBox,
              
                    //fratured categories
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(3, (index) => Column(
                          children: [
                            FeaturedButton(icon: fraturedImagesList1[index], title: fraturedTitleList1[index],),
                            10.heightBox,
                            FeaturedButton(icon: fraturedImagesList2[index], title: fraturedTitleList2[index],),
                          ],
                        )),
                      ),
                    ),

                    20.heightBox,
                    //featured products
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: redColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white.fontFamily(bold).size(18).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if(!snapshot.hasData){
                                  return const Center(
                                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
                                  );
                                }else if(snapshot.data!.docs.isEmpty){
                                  return "No Featured Products".text.white.makeCentered();
                                }else{

                                  var featuredData = snapshot.data!.docs;

                                  return Row(
                                    children: List.generate(featuredData.length, (index) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(featuredData[index]['p_imgs'][0], width: 150, height: 130,  fit: BoxFit.cover,),
                                        10.heightBox,
                                        "${featuredData[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                        10.heightBox,
                                        "${featuredData[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                      ],
                                    ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(8)).make().onTap(() {
                                      Get.to(()=>ItemDetails(title:"${featuredData[index]['p_name']}", data: featuredData[index],));
                                    })
                                  ),
                                );


                                }
                              }
                            ),
                          )
                        ],
                      ),
                    ),

                    20.heightBox,
                    //third slider
                    VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150,
                      itemCount: slidersList2.length, 
                      enlargeCenterPage: true,
                      itemBuilder: (context,index) => swiperBuilder(context, index, slidersList2),
                    ),

                    20.heightBox,

                    //all product section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: "All Products".text.fontFamily(bold).color(darkFontGrey).size(18).make(),
                    ),

                    20.heightBox,

                    StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(!snapshot.hasData){
                          return const Center(
                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
                          );
                        }else{

                          var allproductsdata = snapshot.data!.docs;

                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsdata.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 300),  
                            itemBuilder: (context,index) => allProductBuilder(context, index, allproductsdata)
                          );
                        }
                      },
                    ),


                    
              
              
              
                  ],
                ),
              ),
            )
           

          ],
        ) 
      ),
    );
  } 

  swiperBuilder(context, index, sliderLists){
    return  Image.asset(
        sliderLists[index], 
        fit: BoxFit.fill,
      ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
  }

  allProductBuilder(context, index, data){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(data[index]['p_imgs'][0], width: 200, height: 200, fit: BoxFit.cover,),
        const Spacer(),
        "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
        10.heightBox,
        "\$ ${data[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
      ],
    ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() {
      Get.to(()=>ItemDetails(title:"${data[index]['p_name']}", data: data[index],));
    });
  }
}
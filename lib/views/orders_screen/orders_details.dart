
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/views/orders_screen/components/order_place_details.dart';
import 'package:my_estore/views/orders_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({this.data,  super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
              
                children: [
                  OrderStatus(
                    color: redColor, 
                    icon: Icons.done,
                    title: "Placed", 
                    showDone: data['order_placed'],
                  ),
              
                  OrderStatus(
                    color: Colors.blue, 
                    icon: Icons.thumb_up,
                    title: "Confirmed", 
                    showDone: data['order_confirmed'],
                  ),
              
                  OrderStatus(
                    color: Colors.yellow, 
                    icon: Icons.car_crash_outlined,
                    title: "On Delivery", 
                    showDone: data['order_on_delivery'],
                  ),
              
                  OrderStatus(
                    color: Colors.purple, 
                    icon: Icons.done_all_rounded,
                    title: "Delivered", 
                    showDone: data['order_delivered'],
                  ),
              
                  const Divider(),
                  10.heightBox,
              
                  
                  Column(
                    children: [
                      OrderPlacesDetails(
                        title1: "Order Code",
                        titleDetail1: data['order_code'],
                        title2: "Shipping Method",
                        titleDetail2: data['shipping_method'],
                      ),
        
                      OrderPlacesDetails(
                        title1: "Order Date",
                        titleDetail1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
                        title2: "Payment Method",
                        titleDetail2: data['payment_method'],
                      ),
        
                      OrderPlacesDetails(
                        title1: "Payment Status",
                        titleDetail1: "Unpaid",
                        title2: "Delivery Status",
                        titleDetail2: "Order Placed",
                      ),
        
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Address".text.fontFamily(semibold).make(),
                                "${data['order_by_name']}".text.make(),
                                "${data['order_by_email']}".text.make(),
                                "${data['order_by_address']}".text.make(),
                                "${data['order_by_city']}".text.make(),
                                "${data['order_by_state']}".text.make(),
                                "${data['order_by_country']}".text.make(),
                                "${data['order_by_phone']}".text.make(),
                                "${data['order_by_postal_code']}".text.make(),
                                
                              ],
                            ),
        
        
                            SizedBox(
                              width: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Total Amount".text.fontFamily(semibold).make(),
                                  "${data['total_amount']}".text.color(redColor).fontFamily(bold).make()
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ).box.outerShadowMd.rounded.white.make(),
        
                  const Divider(),
                  10.heightBox,
        
                  "Ordered products".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
                  10.heightBox,
        
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      data['orders'].length,
                      (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrderPlacesDetails(
                              title1: data['orders'][index]['title'].toString(),
                              title2: data['orders'][index]['total_price'].toString(),
                              titleDetail1: data['orders'][index]['quantity'].toString(),
                              titleDetail2: "Refundable",
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                width: 30,
                                height: 20,
                                color: Color(data['orders'][index]['color']),
                              ),
                            ),
                            
                            const Divider(),                         
                          ],
                        );
                      },
                    ).toList()
                  ).box.outerShadowMd.rounded.margin(const EdgeInsets.only(bottom: 4)).white.make(),

                  20.heightBox,

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
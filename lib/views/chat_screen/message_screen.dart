import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/services/firestore_services.dart';
import 'package:my_estore/views/chat_screen/chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "No Messages yet".text.color(darkFontGrey).make(),
            );
          }else{

            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(

                            leading: const CircleAvatar(
                              child: Icon(Icons.person, color: whiteColor,),
                              backgroundColor: redColor,
                            ),
                            title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                            subtitle: "${data[index]['last_messgae']}".text.make(),
                            onTap: (){
                              Get.to(()=>ChatScreen(),
                                arguments: [
                                  data[0]['friend_name'].toString(), 
                                  data[0]['toId'].toString()
                                ]
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );

          }
          
        },
      ),
    );
  }
}
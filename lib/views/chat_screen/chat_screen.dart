import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/controllers/chats_controller.dart';
import 'package:my_estore/views/chat_screen/components/sender_bubble.dart';

import '../../services/firestore_services.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ChatsController());


    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              ()=>
              controller.isLoading.value ? 
              const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
              ):
              Expanded(
                child: StreamBuilder(
                  stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){
                      return const Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
                      );
                    } else if(snapshot.data!.docs.isEmpty){
                      return Center(
                        child: "Send a message..".text.color(darkFontGrey).make(),
                      );
                    } else{
                      return ListView(
                        children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                          var data = snapshot.data!.docs[index];
                          return Align(
                            alignment: data['uid'] == currentUser!.uid? Alignment.centerRight: Alignment.centerLeft,
                            child: SenderBubble(data: data,)
                          );
                        }).toList(),
                      );
                    }  
                  },
                )
            
              ),
            ),
            
            10.heightBox,

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.messageController,
                    decoration: const InputDecoration(
                      hintText: "message...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        )
                      ),
                    ),
                  )
                ),


                IconButton(
                  icon: const Icon(Icons.send, color: redColor,),
                  onPressed: (){
                    controller.sendMessage(controller.messageController.text);
                    controller.messageController.clear();
                  },
                )
              ],
            ).box.height(80).margin(const EdgeInsets.only(bottom: 8)).padding(const EdgeInsets.all(12)).make(),
          ],
        ),
      ),
    );
  }
}
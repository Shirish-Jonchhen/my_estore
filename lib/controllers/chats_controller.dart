import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/controllers/home_controller.dart';

class ChatsController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    getChatID();
    super.onInit();
  }
  var chats = firestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().userName;
  var currentId = currentUser!.uid;

  var messageController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  getChatID() async{

    isLoading.value = true;

    await chats.where('users', isEqualTo: {
      friendId: null,
      currentId: null,
    }).limit(1).get().then((QuerySnapshot snapshot){
      if(snapshot.docs.isNotEmpty){
        chatDocId = snapshot.docs.single.id;
      }else{
        chats.add({
          'created_on': null,
          'last_messgae': "",
          'users': {friendId: null, currentId: null},
          'toId':'',
          'fromId': friendName,
          'sender_name': senderName,
        }).then((value){
          chatDocId = value.id;
        });
      }
    });
    isLoading.value = false;
  }


  sendMessage(String message) async{
    if(message.trim().isNotEmpty){
      chats.doc(chatDocId).update({
          'created_on': FieldValue.serverTimestamp(),
          'last_messgae': message,
          'toId':friendId,
          'fromId': currentId,
          'friend_name': friendName,
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
          'created_on': FieldValue.serverTimestamp(),
          'message': message,
          'uid': currentId,
      });
    }
  }
}
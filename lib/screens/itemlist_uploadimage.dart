import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:UncleJons/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ItemImageUpload extends StatefulWidget {
  ItemImageUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemImageUpload> createState() => _ItemImageUploadState();
 }

class _ItemImageUploadState extends State<ItemImageUpload> {



  final ImageUploadController controller = Get.put(ImageUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.accent_color,
        title: Text('Item Image Upload Detail',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
             // onSaved: (){},
              autovalidateMode:
              AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your user name.';
                } else if (value.contains('@')) {
                  return 'Please don\'t use the @ char.';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(

                labelText: 'Mobile No.',
              ),
              // onSaved: (){},
              autovalidateMode:
              AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your mobile number name.';
                } else if (value.contains('@')) {
                  return 'Please don\'t use the @ char.';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 30,),

            // Obx(
            //   () => controller.selectedImage.value == null
            //       ? Text('No Image Selected')
            //       : Image.file(
            //           File(controller.selectedImage.value!.path),
            //         ),
            // ),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  controller.uploadSingleImageGallery();
                },
                child: Text('Select Image from Gallery'),
                style: ElevatedButton.styleFrom(
                  primary: MyTheme.accent_color,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton(

                onPressed: controller.takePicture,
                child: Text('Take Picture'),
                style: ElevatedButton.styleFrom(

                  primary: MyTheme.accent_color,
                ),
                // ElevatedButton(
                //   onPressed: controller.uploadImageToServer,
                //   child: Text('Upload Image'),
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//controller
class ImageUploadController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  Future<void> pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage.value = pickedImage;
    }
  }

  Future<void> takePicture() async {
    final takenImage = await _picker.pickImage(source: ImageSource.camera);
    if (takenImage != null) {
      selectedImage.value = takenImage;
    }
  }

  Future<File> pickImageGallery() async {
    var picker = ImagePicker();
    var image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        requestFullMetadata: false);
    var imageFile = File(image!.path);
    return imageFile;
  }

  Future<void> uploadSingleImageGallery() async {
    var image = await pickImageGallery();

    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse("http://143.198.151.57/api/upload-single-image"))
        ..fields["image"]
        ..files.add(
          http.MultipartFile(
            "image",
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: "profile.png",
          ),
        );
      var response = await request.send();
      //json response
      var jsonResponse = await response.stream.bytesToString().then((value) {
        return value;
      });
      Map responseMap = jsonDecode(jsonResponse);
      log(responseMap.toString());
      if (responseMap["status"]) {
        var imageUrl = responseMap["imageUrl"];
        Get.rawSnackbar(message: "Profile image upload successful");
      } else {
        Get.rawSnackbar(message: responseMap["message"],);
        // showErrorMessage(responseMap["message"]);
      }
    } catch (e) {
      log(e.toString());
      Get.rawSnackbar(message: "Something went wrong");
    }
  }
}

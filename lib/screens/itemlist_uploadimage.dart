import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

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
        backgroundColor: Colors.red,
        title: Text('Item Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => controller.selectedImage.value == null
                  ? Text('No Image Selected')
                  : Image.file(
                      File(controller.selectedImage.value!.path),
                    ),
            ),
            ElevatedButton(
              onPressed: controller.pickImageFromGallery,
              child: Text('Select Image from Gallery'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
              ),
            ),
            ElevatedButton(
              onPressed: controller.takePicture,
              child: Text('Take Picture'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
              ),
              // ElevatedButton(
              //   onPressed: controller.uploadImageToServer,
              //   child: Text('Upload Image'),
              // ),
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

  Future<void> uploadImageToServer() async {
    if (selectedImage.value == null) {
      return;
    }

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(selectedImage.value!.path),
      });

      // Replace with your API endpoint
      Response response = await dio.post('https://your-api-endpoint.com/upload',
          data: formData);

      // Handle the response as needed
      print('Response: ${response.data}');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}

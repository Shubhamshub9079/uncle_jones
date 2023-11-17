import 'dart:io';

import 'package:UncleJons/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class ItemImageUpload extends StatefulWidget {
  ItemImageUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemImageUpload> createState() => _ItemImageUploadState();
}

class _ItemImageUploadState extends State<ItemImageUpload> {

  final ItemImageUploadController controller = Get.put(ItemImageUploadController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.accent_color,
        title: Text(
          'Manual Order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                validator: (nameController) {
                  if (nameController!.isEmpty) {
                    return "Please Enter Moblie No";
                  }
                  return null;
                },
                //cursorColor: hexClr,
                controller: controller.nameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: "Enter Name",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10)
                ],
                validator: (mobileController) {
                  if (mobileController!.isEmpty) {
                    return "Please Enter Moblie No";
                  }
                  return null;
                },
                //cursorColor: hexClr,
                controller: controller.mobileController,
                decoration: InputDecoration(

                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: "Enter Mobile No.",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (addressController) {
                  if (addressController!.isEmpty) {
                    return "Please Enter Address";
                  }
                  return null;
                },
                //cursorColor: hexClr,
               controller: controller.addressController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: "Enter Address",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 5,
                controller:controller.commentController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  hintText: "Comment here..",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              // Obx(
              //   () => controller.selectedImage.value == null
              //       ? Text('No Image Selected')
              //       : Image.file(
              //           File(controller.selectedImage.value!.path),
              //         ),
              // ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color(0xffFFEBEE),
                        title: Text(
                          "From where do you want to take the photo?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              GestureDetector(
                                child: Text("Gallery",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                onTap: () {
                                  controller.pickImage(ImageSource.gallery);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                              Padding(padding: EdgeInsets.all(8.0)),
                              GestureDetector(
                                child: Text("Camera",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                onTap: () {
                                  controller.pickImage(ImageSource.camera);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text("Image Upload",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(primary: Colors.pink),
              ),

              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 40,
                width: 350,
                child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: MyTheme.accent_color, onPrimary: Colors.yellow),
                 onPressed:
                 controller.uploadData
                  ,child: Text('Submit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemImageUploadController extends GetxController {
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  Rx<File?> _image = Rx<File?>(null);

  File? get image => _image.value;

  void pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    setImage(pickedImage?.path != null ? File(pickedImage!.path) : null);
  }

  void setImage(File? pickedImage) {
    _image.value = pickedImage;
  }


  Future<void> uploadData() async {
    if (
    nameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        addressController.text.isEmpty) {
      // Handle validation or show an error message
      return;
    }

    // Prepare the data
    var formData = http.MultipartRequest(
        'POST', Uri.parse('https://unclejons.in/api/v2/manualorder'));
    formData.fields['name'] = nameController.text;
    formData.fields['phone'] = mobileController.text;
    print('phone: ${mobileController.text}');
    formData.fields['address'] = addressController.text;
    formData.fields['comment'] = commentController.text;

    var image = await http.MultipartFile.fromPath('image', _image.value!.path);
    formData.files.add(image);

    try {
      var response = await formData.send();
      if (response.statusCode == 200) {
        // Successfully uploaded
        print('Successfully uploaded');





      } else {
        print('Failed to upload image');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red, // Customize the color if needed
      );
      print('Error: $e');
    }
  }
}




//controller
// class ImageUploadController extends GetxController {
//   final ImagePicker _picker = ImagePicker();
//   Rx<XFile?> selectedImage = Rx<XFile?>(null);
//
//   Future<void> pickImageFromGallery() async {
//     final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       selectedImage.value = pickedImage;
//     }
//   }
//
//   Future<void> takePicture() async {
//     final takenImage = await _picker.pickImage(source: ImageSource.camera);
//     if (takenImage != null) {
//       selectedImage.value = takenImage;
//     }
//   }
//
//   Future<File> pickImageGallery() async {
//     var picker = ImagePicker();
//     var image = await picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 80,
//         requestFullMetadata: false);
//     var imageFile = File(image!.path);
//     return imageFile;
//   }
//
//   Future<void> uploadSingleImageGallery() async {
//     var image = await pickImageGallery();
//
//     try {
//       var request = http.MultipartRequest("POST", Uri.parse("https://unclejons.in/api/v2/manualorder"))
//         ..fields["image"]
//         ..files.add(
//           http.MultipartFile(
//             "image",
//             image.readAsBytes().asStream(),
//             image.lengthSync(),
//             filename: "profile.png",
//           ),
//         );
//       var response = await request.send();
//       //json response
//       var jsonResponse = await response.stream.bytesToString().then((value) {
//         return value;
//       });
//       Map responseMap = jsonDecode(jsonResponse);
//       log(responseMap.toString());
//       if (responseMap["status"]) {
//         var imageUrl = responseMap["imageUrl"];
//         Get.rawSnackbar(message: "Profile image upload successful");
//       } else {
//         Get.rawSnackbar(
//           message: responseMap["message"],
//         );
//         // showErrorMessage(responseMap["message"]);
//       }
//     } catch (e) {
//       log(e.toString());
//       Get.rawSnackbar(message: "Something went wrong");
//     }
//   }
// }

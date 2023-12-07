import 'dart:convert';
import 'dart:io';

import 'package:UncleJons/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import '../custom/toast_component.dart';
import '../helpers/auth_helper.dart';
import 'home.dart';

class ItemImageUpload extends StatefulWidget {
  ItemImageUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemImageUpload> createState() => _ItemImageUploadState();
}

class _ItemImageUploadState extends State<ItemImageUpload> {
  bool isLoading = false;
  bool apiSuccess = false;

  final ItemImageUploadController controller =
  Get.put(ItemImageUploadController());

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'You Want Order Manually\n     Please Fill this form',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 14,),
              Container(
                height: 2, width: 110,
                color: Colors.black,
              ),
              SizedBox(
                height: 30,
              ),

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
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
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
                controller: controller.commentController,
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
              Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: MyTheme.light_grey,
                              title: Text(
                                "From where do you want to take the photo?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Text(
                                        "Gallery",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      onTap: () {
                                        controller
                                            .pickImage(ImageSource.gallery);
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    ),
                                    Padding(padding: EdgeInsets.all(8.0)),
                                    GestureDetector(
                                      child: Text(
                                        "Camera",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      onTap: () {
                                        controller
                                            .pickImage(ImageSource.camera);
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
                      style:
                      ElevatedButton.styleFrom(primary: MyTheme.dark_grey),
                    ),
                  ),
                  Obx(
                        () =>
                    controller.isImageSelected && controller.image != null
                        ? Container(
                      height: 100,
                      width: 250,
                      padding: EdgeInsets.all(16),
                      child: controller.buildSelectedImage(),
                    )
                        : Container(), // You can return an empty container or a placeholder image
                  ),
                ],
              ),

              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
                width: 350,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyTheme.accent_color,
                    onPrimary: Colors.yellow,
                  ),
                  onPressed:
                  (controller.isApiSuccess || controller.isLoading.isTrue)
                      ? null
                      : () async {
                    try {
                      controller.setLoading(true);
                      await controller.uploadData(context);
                      // Check if the API response is successful (HTTP status code 200)
                      if (controller.isApiSuccess) {
                        // If successful, you can disable the button here if needed
                      }
                    } finally {
                      controller.setLoading(false);
                    }
                  },
                  child: Obx(
                        () =>
                    controller.isLoading.isTrue
                        ? CircularProgressIndicator(color: Colors.grey,)
                        : Text(
                      controller.isApiSuccess ? 'Yes' : 'Submit',
                      style: TextStyle(
                        color: controller.isApiSuccess
                            ? Colors.green
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemImageUploadController extends GetxController {
  RxBool isLoading = RxBool(false);

  final RxBool _isImageSelected = RxBool(false);

  RxBool _isApiSuccess = RxBool(false);

  bool get isApiSuccess => _isApiSuccess.value;

  bool get isImageSelected => _isImageSelected.value;

  void pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    setImage(pickedImage?.path != null ? File(pickedImage!.path) : null);
    _isImageSelected.value = _image.value != null;
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  Rx<File?> _image = Rx<File?>(null);

  File? get image => _image.value;

  void setImage(File? pickedImage) {
    _image.value = pickedImage;
  }

  Widget buildSelectedImage() {
    if (_image.value != null) {
      return Image.file(_image.value!);
    } else {
      return Container(); // You can return an empty container or a placeholder image
    }
  }

  Future<void> uploadData(BuildContext context) async {
    if (nameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        addressController.text.isEmpty) {
      // Handle validation or show an error message
      return;
    }
    setLoading(true);
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
        var responseData = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = json.decode(responseData);
        setLoading(false);
        var apiSuccess = jsonResponse['success'];
        // Assuming the API response has a 'message' field
        var apiMessage = jsonResponse['message'];

        print('Response: $apiMessage');
        ToastComponent.showDialog(apiMessage,
            gravity: Toast.center, duration: Toast.lengthLong);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
              return Home();
            }), (newRoute) => false);
        nameController.clear();
        mobileController.clear();
        addressController.clear();
        commentController.clear();
        setImage(null);
        _isApiSuccess.value = apiSuccess;
        print('Successfully uploaded');
      } else {
        print('Failed to upload image');
        setLoading(false);
      }
    } catch (e) {
      print('Error: $e');
      setLoading(false);
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

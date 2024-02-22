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
import 'home.dart';

class ItemImageUpload extends StatefulWidget {
  ItemImageUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemImageUpload> createState() => _ItemImageUploadState();
}


class _ItemImageUploadState extends State<ItemImageUpload> {
  //bool isLoading = false;
  //bool apiSuccess = false;

  final ItemImageUploadController controller =
      Get.put(ItemImageUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: MyTheme.accent_color,
      //   title: Text(
      //     'Manual Order',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            // color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            // child:
            // Image.asset(
            //   "assets/manual.png",
            //   fit: BoxFit.cover,height: 100,width: 100,
            // ),),
          ),
          Image.asset('assets/manual.png'),
          Positioned(
            top: 80, // Adjust the top position as needed
            left: 50,
            right: 10, // Adjust the left position as needed
            child: Text(
              'You Want to Order Manually\n        Please Fill this Form',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5), // Set your desired color
                  borderRadius: BorderRadius.circular(
                      10), // Make it circular by setting borderRadius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Your Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      TextFormField(
                        validator: (nameController) {
                          if (nameController!.isEmpty) {
                            return "Please Enter Name";
                          }
                          return null;
                        },
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          hintText: 'John Doe',
                          hintStyle: TextStyle(color: Color(0xffB8B8B8)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB8B8B8)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Enter Mobile No.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        controller: controller.mobileController,
                        keyboardType: TextInputType.number,
                        validator: (mobileController) {
                          if (mobileController!.isEmpty) {
                            return "Please Enter Moblie No";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '9079649090',
                          hintStyle: TextStyle(color: Color(0xffB8B8B8)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB8B8B8)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Enter Address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      TextFormField(
                        validator: (addressController) {
                          if (addressController!.isEmpty) {
                            return "Please Enter Address";
                          }
                          return null;
                        },
                        controller: controller.addressController,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(color: Color(0xffB8B8B8)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB8B8B8)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Comment Here',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      TextFormField(
                        controller: controller.commentController,
                        decoration: InputDecoration(
                          hintText: 'Hello there...',
                          hintStyle: TextStyle(color: Color(0xffB8B8B8)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB8B8B8)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Image Upload',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Obx(
                            () => Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    // color: Color(0xffe6e6e6),
                                    borderRadius: BorderRadius.circular(
                                        10), // Set a circular border radius
                                  ),
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      controller.pickImage(
                                                          ImageSource.gallery);
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                  ),
                                                  Divider(),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0)),
                                                  GestureDetector(
                                                    child: Text(
                                                      "Camera",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      controller.pickImage(
                                                          ImageSource.camera);
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
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyTheme.accent_color,
                                      // shape: CircleBorder(),
                                      padding: EdgeInsets.all(0),
                                    ),
                                    child: controller.isImageSelected &&
                                            controller.image != null
                                        ? Container(
                                            height: 38,
                                            width: 115,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(
                                                  File(controller.image!.path),
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            "Upload",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
                            foregroundColor: Colors.yellow, backgroundColor: MyTheme.accent_color,
                          ),
                          onPressed: (controller.isApiSuccess || controller.isLoading.isTrue)
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
                            () => controller.isLoading.isTrue
                                ? CircularProgressIndicator(
                                    color: Colors.green,
                                  )
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
            ),
          ),
        ]),
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
        'POST', Uri.parse('https://unclejons.in/api/v2/manualorder'),);
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

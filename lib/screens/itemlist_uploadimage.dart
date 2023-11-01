import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:UncleJons/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        title: Text(
          'Manual Order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              validator: (UsernameController) {
                if (UsernameController!.isEmpty) {
                  return "Please Enter Moblie No";
                }
                return null;
              },
              //cursorColor: hexClr,
              // controller: UsernameController,
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
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              keyboardType: TextInputType.number,
              validator: (UsernameController) {
                if (UsernameController!.isEmpty) {
                  return "Please Enter Moblie No";
                }
                return null;
              },
              //cursorColor: hexClr,
              // controller: UsernameController,
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

            // Obx(
            //   () => controller.selectedImage.value == null
            //       ? Text('No Image Selected')
            //       : Image.file(
            //           File(controller.selectedImage.value!.path),
            //         ),
            // ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WillPopScope(
                        onWillPop: () async => true,
                        // False will prevent and true will allow to dismiss

                        child: AlertDialog(
                          backgroundColor: Color(0xffFFEBEE),
                          // insetPadding: EdgeInsets.all(15),
                          title: Text(
                            "From where do you want to take the photo?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                GestureDetector(
                                  child: Text("Gallery",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    controller.uploadSingleImageGallery();
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                                Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: Text("Camera",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    controller.takePicture();
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "Image Upload",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 40,
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MyTheme.accent_color, // background
                  onPrimary: Colors.yellow, // foreground
                ),
                onPressed: () {},
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
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
      var request = http.MultipartRequest("POST", Uri.parse(""))
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
        Get.rawSnackbar(
          message: responseMap["message"],
        );
        // showErrorMessage(responseMap["message"]);
      }
    } catch (e) {
      log(e.toString());
      Get.rawSnackbar(message: "Something went wrong");
    }
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:admin/constants.dart';
import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/helper/custom_toast.dart';
import 'package:admin/models/add_product_model.dart';
import 'package:admin/widgest/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:admin/responsive.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController pricePerUnit = TextEditingController();
  TextEditingController shortDescription = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController quantity = TextEditingController();
  bool isLoading = false;
  File? image;
  ImagePicker imagePicker = ImagePicker();
  AddProductModel addProductModel = AddProductModel();
  Uint8List? imageData; // To store the image as bytes
  String? imageName; // To store the image file name

  Future<void> pickImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Restrict to images only
    uploadInput.click(); // Programmatically click to open file dialog

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]); // Read as bytes (Uint8List)

        reader.onLoadEnd.listen((event) {
          setState(() {
            imageData = reader.result as Uint8List; // Store image bytes
            imageName = files[0].name; // Store the image name
            print('Image selected: $imageName');
          });
        });
      }
    });
  }

  addProduct() async {
    var url = Uri.parse('http://54.199.29.47:3000/api/addproducts');

    var request = http.MultipartRequest('POST', url);
    setState(() {
      isLoading = true;
    });

    request.fields['name'] = titleController.text;
    request.fields['price'] = price.text;
    request.fields['quantity'] = quantity.text;
    request.fields['shortDescription'] = shortDescription.text;
    request.fields['description'] = description.text;
    request.fields['category'] = category.text;

    if (imageData != null && imageName != null) {
      var file = http.MultipartFile.fromBytes(
        'image',
        imageData!,
        filename: imageName,
        contentType:
            MediaType('image', 'jpeg'), // Check if the image type is correct
      );
      request.files.add(file);
    }

    try {
      var res = await request.send();
      final resBody = await res.stream.bytesToString();
      print('Response Status Code: ${res.statusCode}');
      print('Response Body: $resBody');

      if (res.statusCode == 200) {
        addProductModel = addProductModelFromJson(resBody);
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        print('Product added successfully');
      } else {
        print('Error: ${res.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: context.read<MenuAppController>().controlMenu,
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                primary: false,
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Overview",
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "Product Title",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              CustomTextField(
                                controller: titleController,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "Short Description",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              CustomTextField(
                                controller: shortDescription,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "Product Description",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              TextFormField(
                                maxLines: 4,
                                controller: description,
                                cursorColor: Colors.grey,
                                style: TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "Pricing",
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Price Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Price",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CustomTextField(
                                              controller: price,
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Price Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Quantity",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CustomTextField(
                                              controller: quantity,
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  // Cost Per Item Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Category",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CustomTextField(
                                              controller: category,
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "Media",
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              imageData != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: MemoryImage(
                                              imageData!), // Use MemoryImage for Uint8List
                                          fit: BoxFit.fitHeight,
                                        ),
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.150,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: pickImage,
                                              child: SvgPicture.asset(
                                                  'assets/icons/image_selector.svg',
                                                  color: Colors.grey)),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text('Upload Image',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    if (price.text.isNotEmpty &&
                                        description.text.isNotEmpty &&
                                        quantity.text.isNotEmpty &&
                                        titleController.text.isNotEmpty) {
                                      await addProduct();
                                      if (addProductModel.status == "success") {
                                        setState(() {
                                          price.clear();
                                          description.clear();
                                          shortDescription.clear();
                                          quantity.clear();
                                          category.clear();
                                          titleController.clear();
                                          imageData = null;
                                        });

                                        CustomToast.showToast(
                                            message: addProductModel.message
                                                .toString());
                                      } else {
                                        CustomToast.showToast(
                                            message: addProductModel.message
                                                .toString());
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 54,
                                    width: 335,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: isLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'Add Product',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

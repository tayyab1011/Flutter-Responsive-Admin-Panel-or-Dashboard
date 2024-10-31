import 'package:admin/constants.dart';
import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/helper/base_url.dart';
import 'package:admin/models/get_products.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  TextEditingController searchController = TextEditingController();
  GetProductModel getProductModel = GetProductModel();
  List filteredProducts = [];
  void _onMenuSelected(String value, int index) async {
    switch (value) {
      case 'delete':
        delete(index);
        break;
    }
  }

  void delete(int index) {
    // Handle the edit action here
    print('Edit job at index $index');
  }

  getAllProducts() async {
    var headersList = {
      'Accept': '*/*',
      
    };
    var url = Uri.parse('http://54.199.29.47:3000/api/getproducts');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      getProductModel = getProductModelFromJson(resBody);
      filteredProducts = getProductModel.data!;
      if (mounted) {
        setState(() {});
      }
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllProducts();

    // Listen for changes in search input and filter products accordingly
    searchController.addListener(() {
      filterProducts();
    });
  }

  // Method to filter products based on search input
  void filterProducts() {
    List results = [];
    if (searchController.text.isEmpty) {
      results = getProductModel.data!;
    } else {
      results = getProductModel.data!.where((product) {
        return product.name!
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
      }).toList();
    }

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getProductModel.data != null
            ? Row(
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
                                    TextFormField(
                                      controller: searchController,
                                      cursorColor: Colors.grey,
                                      style: TextStyle(color: Colors.grey),
                                      decoration: InputDecoration(
                                        hintText: "Search for products",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: filteredProducts.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Image.network(
                                                    '$baseImageUrl${filteredProducts[index].image}',
                                                    height: 100,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.16,
                                                    child: Text(
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      filteredProducts[index]
                                                          .name
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    filteredProducts[index]
                                                        .category
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    filteredProducts[index]
                                                        .quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "\$${filteredProducts[index].price.toString()}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  PopupMenuButton<String>(
                                                    onSelected: (value) =>
                                                        _onMenuSelected(
                                                            value, index),
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        value: 'delete',
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 7),
                                                              child: Text(
                                                                'Delete',
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    child: Icon(
                                                      Icons.more_vert,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                height: 50,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    )
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
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

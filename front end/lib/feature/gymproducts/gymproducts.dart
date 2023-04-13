import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fyp/core/widgets/drawer.dart';
import 'package:fyp/feature/gymproducts/subgymproducts.dart';
import 'package:fyp/modals/products.dart';
import 'package:http/http.dart' as http;

class GymProducts extends StatefulWidget {
  const GymProducts({Key? key}) : super(key: key);

  @override
  State<GymProducts> createState() => _GymProductsState();
}

class _GymProductsState extends State<GymProducts> {
  late Future<List<ProductsModel>> futureProducts;
  bool showTextField = false;
  Widget _buildFloatingSearchBtn() {
    return Expanded(
      child: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          setState(() {
            showTextField = !showTextField;
          });
        },
      ),
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: Center(
        child: TextField(
          onTap: () {
            showTextField = false;
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  Future<List<ProductsModel>> fetchProducts() async {
    final response = await http.get(
      Uri.parse("http://192.168.10.132:8000/api/product/all/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ProductsModel.fromJson(data)).toList();
    } else {
      throw Exception('Unable to get products list');
    }
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                leading: IconButton(
                    padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                    icon: Image.asset(
                      'images/drawer.png',
                      color: Colors.white,
                      height: 40,
                    ),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    }),
                backgroundColor: Colors.black,
                actions: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 120, 0),
                      child: Text(
                        'Gym Products',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SanFranciscos",
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            extendBodyBehindAppBar: false,
            drawer: MainDrawer(),
            body: FutureBuilder<List<ProductsModel>>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ProductsModel> data = snapshot.data!;
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      child: Image.network(
                                        data[index].image,
                                        height: 100,
                                      )),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Text(data[index].name),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GymProduct1(
                                          id: data[index].id,
                                        )),
                              );
                            },
                          );
                        });
                  } else {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                })));
  }
}

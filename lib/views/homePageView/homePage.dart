import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/components/colors.dart';
import 'package:margintop_solutions/views/loginView/loginScreen.dart';
import 'package:margintop_solutions/views/productView.dart/productDetail.dart';
import 'package:margintop_solutions/views/productView.dart/productModel.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  /********Search Operation Code******/
  List<ProductModel> _foundProduct = [];

  // Build the ListView Builder dynamicaly
  Widget _buildProductList() {
    return ListView.builder(
      itemCount: _foundProduct.length, //productSamples.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          key: Key("${_foundProduct[index]}"),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(1),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(30),
            ),
            child: Row(
              children: [
                const Material(
                  elevation: 2,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage("assets/images/item.jpg"),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${_foundProduct[index].name}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Container(
                  color: Colors.green.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "${_foundProduct[index].price}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Container(
                  color: Colors.blue.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "${_foundProduct[index].weight} kg",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                            productDetails: _foundProduct[index],
                          )));
            },
          ),
        );
      },
    );
  }

  void _runFilter(String enteredKeyword) {
    List<ProductModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = productSamples;
    } else {
      results = productSamples
          .where((product) =>
              product.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundProduct = results;
    });
  }

  @override
  void initState() {
    _foundProduct = productSamples;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
              child: SizedBox(
                width: size.width,
                height: size.height / 3.3,
                child: AppBar(
                  backgroundColor: appColor,
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: appColor, elevation: 0),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "All Categories",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {
                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text(
                                  "Categories",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text(
                                      "Category - 1",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text(
                                      "Category - 2",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text(
                                      "Category - 3",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                    const Spacer(),
                    const Text(
                      "Pos",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              color: appColor,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(color: appColor),
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 110,
              left: 20,
              right: 20,
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: "Search Product",
                    prefixIcon: const Icon(Icons.search)),
              ),
            ),
            Positioned.fill(
              top: 180,
              left: 20,
              right: 20,
              child: Card(
                child: _buildProductList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

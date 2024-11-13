

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:margintop_solutions/cartView/cartLocalStorage.dart';
import 'package:margintop_solutions/components/colors.dart';
import 'package:margintop_solutions/views/productView.dart/productModel.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel productDetails;
  const ProductDetailPage({
    Key? key,
    required this.productDetails,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final CartLocalStorage _cartStorage = CartLocalStorage();

  /*******Add to cart******/
  Future<void> _addToCart() async {
  bool isInCart = await _cartStorage.isProductInCart(widget.productDetails.name);
  
  if (isInCart) {
    Fluttertoast.showToast(
      msg: "Product is already in cart",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else {
    await _cartStorage.addProductToCart(widget.productDetails);
    Fluttertoast.showToast(
      msg: "Product added to cart",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "${widget.productDetails.name}",
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height / 3,
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/item.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 5,
                    width: 70,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "${widget.productDetails.name}",
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: size.width / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.withOpacity(0.8),
                  ),
                  child: Center(
                    child: Text(
                      "P= ${widget.productDetails.price}",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: size.width / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.withOpacity(0.8),
                  ),
                  child: Center(
                    child: Text(
                      "W= ${widget.productDetails.weight} kg",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: InkWell(
                onTap: _addToCart, 
                child: Container(
                  height: size.height / 15,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appColor,
                  ),
                  child: const Center(
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

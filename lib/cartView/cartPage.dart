import 'package:flutter/material.dart';
import 'package:margintop_solutions/cartView/cartLocalStorage.dart';
import 'package:margintop_solutions/components/colors.dart';
import 'package:margintop_solutions/views/loginView/loginScreen.dart';
import 'package:margintop_solutions/views/productView.dart/productModel.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductModel> _cartProducts = [];
  Map<String, int> _quantities = {}; // Stores quantity for each product
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCartProducts();
  }

  // Function to load cart products from local storage
  Future<void> _loadCartProducts() async {
    final CartLocalStorage storage = CartLocalStorage();
    List<ProductModel> products = await storage.getCartProducts();

    setState(() {
      _cartProducts = products;
      _quantities = {
        for (var product in products) product.name: 1
      }; // Default quantity of 1
      _calculateTotal();
    });
  }

  // Function to calculate the total price based on quantities
  void _calculateTotal() {
    double total = 0.0;
    for (var product in _cartProducts) {
      int quantity = _quantities[product.name] ?? 1;
      total += product.price * quantity;
    }
    setState(() {
      _totalPrice = total;
    });
  }

  // Function to increase the quantity of an item
  void _increaseQuantity(ProductModel product) {
    setState(() {
      _quantities[product.name] = (_quantities[product.name] ?? 1) + 1;
      _calculateTotal();
    });
  }

  // Function to decrease the quantity of an item
  void _decreaseQuantity(ProductModel product) {
    setState(() {
      int currentQuantity = _quantities[product.name] ?? 1;
      if (currentQuantity > 1) {
        _quantities[product.name] = currentQuantity - 1;
        _calculateTotal();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: size.width,
              height: size.width / 2,
              child: AppBar(
                backgroundColor: appColor,
                title: const Text(
                  "Your Cart Items",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                actions: [
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
          Positioned.fill(
            top: 110,
            left: 20,
            right: 20,
            bottom: 0,
            child: Card(
              child: _cartProducts.isEmpty
                  ? const Center(
                      child: Text("Your cart is empty..."),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 90),
                      itemCount: _cartProducts.length,
                      itemBuilder: (context, index) {
                        final product = _cartProducts[index];
                        final quantity = _quantities[product.name] ?? 1;
                        final itemTotal = product.price * quantity;

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 10),
                          child: Container(
                            height: size.height / 8,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Material(
                                    elevation: 2,
                                    shape: CircleBorder(),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage("assets/images/item.jpg"),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () =>
                                              _decreaseQuantity(product),
                                        ),
                                        Text(
                                          "$quantity",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () =>
                                              _increaseQuantity(product),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.delete,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        await CartLocalStorage()
                                            .removeProductFromCart(
                                                product.name);
                                        _loadCartProducts();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: Text(
                                          "INR: $itemTotal",
                                          style:
                                              const TextStyle(color: appColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(17),
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Text(
                      "Total-",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "INR $_totalPrice",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
              elevation: 2,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                      color: Colors.blue.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Text(
                    "Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}


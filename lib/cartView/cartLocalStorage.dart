import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:margintop_solutions/views/productView.dart/productModel.dart';

class CartLocalStorage {
  static const String cartItems = 'cart_products';

  // Function to save a list of ProductModel to SharedPreferences
  Future<void> saveCartProducts(List<ProductModel> products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> productJsonList =
        products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList(cartItems, productJsonList);
  }

  // Function to get the list of ProductModel from SharedPreferences
  Future<List<ProductModel>> getCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> productJsonList = prefs.getStringList(cartItems) ?? [];
    return productJsonList
        .map((productJson) => ProductModel.fromJson(jsonDecode(productJson)))
        .toList();
  }

  // Function to check if a product is already in the cart by name
  Future<bool> isProductInCart(String productName) async {
    List<ProductModel> currentCart = await getCartProducts();
    return currentCart.any((product) => product.name == productName);
  }

  // Function to add a single ProductModel to the cart list
  Future<void> addProductToCart(ProductModel product) async {
    List<ProductModel> currentFavorites = await getCartProducts();
    currentFavorites.add(product);
    await saveCartProducts(currentFavorites);
  }
  
  // Function to remove a single ProductModel from the cart list by name
  Future<void> removeProductFromCart(String productName) async {
    List<ProductModel> currentFavorites = await getCartProducts();
    currentFavorites.removeWhere((product) => product.name == productName);
    await saveCartProducts(currentFavorites);
  }
}




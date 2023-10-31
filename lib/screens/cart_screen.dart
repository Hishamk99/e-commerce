import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/screens/product_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = Provider.of<CartItem>(context).products;
    final double heightScreen = MediaQuery.of(context).size.height;
    final double widthtScreen = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Cart',
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            LayoutBuilder(
              builder: (conext, constrain) {
                if (products.isNotEmpty) {
                  return SizedBox(
                    height: heightScreen -
                        (heightScreen * .14) -
                        appBarHeight -
                        statusBarHeight,
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: GestureDetector(
                            onTapUp: (details) {
                              showCutomMenu(details, context, products[index]);
                            },
                            child: Container(
                              height: heightScreen * .15,
                              color: kTextFieldColor,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: heightScreen * .15 / 2,
                                    backgroundImage:
                                        AssetImage(products[index].location),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                products[index].name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '\$ ${products[index].price}',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            products[index]
                                                .kQuantity
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox(
                    height: heightScreen -
                        (heightScreen * .14) -
                        appBarHeight -
                        statusBarHeight,
                    child: const Center(
                      child: Text(
                        'Cart is empty',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                    width: widthtScreen,
                    height: heightScreen * .09,
                    decoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'ORDER',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showCutomMenu(TapUpDetails details, BuildContext context,
      ProductModel product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx1 = MediaQuery.of(context).size.width - dx;
    double dy1 = MediaQuery.of(context).size.width - dy;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx1, dy1),
        items: [
          PopupMenuItem(
            onTap: () async {
              final navigator = Navigator.of(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
              await Future.delayed(Duration.zero);

              navigator.pushNamed(ProductInfoPage.id,
                  arguments: product);
            },
            child: const Text('Edit'),
          ),
          PopupMenuItem(
            onTap: () {
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
            },
            child: const Text('Delete'),
          ),
        ]);
  }
}

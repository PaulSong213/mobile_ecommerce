import 'package:amazon_clone_tutorial/common/widgets/loader.dart';
import 'package:amazon_clone_tutorial/features/account/widgets/single_product.dart';
import 'package:amazon_clone_tutorial/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone_tutorial/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone_tutorial/models/product.dart';
import 'package:flutter/material.dart';

import '../services/admin_services.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              body: GridView.builder(
                  itemCount: products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final productData = products![index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProduct(image: productData.images[0]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete_outline),
                            )
                          ],
                        )
                      ],
                    );
                  }),
              floatingActionButton: FloatingActionButton(
                onPressed: navigateToAddProduct,
                tooltip: 'Add a Product',
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          );
  }
}

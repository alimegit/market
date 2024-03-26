import 'package:flutter/material.dart';
import 'package:market/screens/edit/add.dart';
import 'package:market/view_models/product_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../data/model/product_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const  AddScreen()));
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsViewModel>().listenProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<ProductModel> list = snapshot.data as List<ProductModel>;
            return ListView(
              children: [
                ...List.generate(
                  list.length,
                      (index) {
                    ProductModel product = list[index];
                    return ListTile(
                      leading: Image.network(
                        product.imageUrl,
                        width: 50,
                      ),
                      title: Text(product.productName),
                      subtitle: Text(product.docId),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context
                                    .read<ProductsViewModel>()
                                    .deleteProduct(product.docId, context);
                              },
                              icon: const Icon(Icons.delete,color: Colors.red,),
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     context
                            //         .read<ProductsViewModel>()
                            //         .updateProduct(
                            //       CategoryModel(
                            //         imageUrl:
                            //         "https://dnr.wisconsin.gov/sites/default/files/feature-images/ECycle_Promotion_Manufacturers.jpg",
                            //         categoryName: "Electronics",
                            //         docId: category.docId,
                            //       ),
                            //       context,
                            //     );
                            //   },
                            //   icon: const Icon(Icons.edit),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

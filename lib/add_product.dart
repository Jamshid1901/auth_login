import 'package:auth_login/get_product.dart';
import 'package:auth_login/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: descController,
              decoration: InputDecoration(labelText: "desc"),
            ),
            TextFormField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                labelText: "price",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  firestore
                      .collection("product")
                      .add(ProductModel(
                      name: nameController.text.toLowerCase(),
                      desc: descController.text,
                      price: double.tryParse(priceController.text) ?? 0)
                      .toJson())
                      .then((value) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (_) => const GetProductPage()), (
                        route) => false);
                  });
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}

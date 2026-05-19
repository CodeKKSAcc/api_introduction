import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_6/api_models/product_model.dart';

class ApiProduct extends StatelessWidget {
  List<ProductModel> allData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products"), centerTitle: true),
      body: FutureBuilder<List<ProductModel>>(
        future: getComments(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }

          if (snap.hasError) {
            return Text(snap.error.toString());
          }

          if (snap.hasData) {
            allData = snap.data ?? [];
            return allData.isNotEmpty
                ? ListView.builder(
                    itemCount: allData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(9),
                        margin: EdgeInsets.only(right: 12, left: 12, top: 12),
                        decoration: BoxDecoration(
                          color:
                              Colors.primaries[Random().nextInt(
                                Colors.primaries.length,
                              )],
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment(0, 0),
                              width: double.infinity,
                              child: Text(
                                "All Product Details :",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 21),
                            Row(
                              children: [
                                Image.network(
                                  allData[index].images[0],
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.fill,
                                ),
                                Spacer(),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Id: ${allData[index].id}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "Title: ${allData[index].title}",
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "Description: ${allData[index].description}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "Category: ${allData[index].category}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "Price: ${allData[index].price}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "Stock: ${allData[index].stock}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "Tags: ${allData[index].tags[0]}/${allData[index].tags[0]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Dimension: ${allData[index].dimensions.height} * ${allData[index].dimensions.width} * ${allData[index].dimensions.depth} *",
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Created at: ${allData[index].meta.createdAt}",
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Barcode No: ${allData[index].meta.barcode}",
                            ),
                            SizedBox(height: 21),
                            Container(
                              alignment: Alignment(0, 0),
                              width: double.infinity,
                              child: Text(
                                "Reviews :",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 21),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: allData[index].reviews.length,
                              itemBuilder: (context, ind) {
                                return Container(
                                  padding: EdgeInsets.all(9),
                                  margin: EdgeInsets.only(right: 12, left: 12, top: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all()
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ratings: ${allData[index].reviews[ind].rating}",
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "Comment: ${allData[index].reviews[ind].comment}",
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "Reviewer name: ${allData[index].reviews[ind].reviewerName}",
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "Reviewer email: ${allData[index].reviews[ind].reviewerEmail}",
                                      ),
                                      SizedBox(height: 12),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(child: Text("No Cart Yet !!!"));
          }

          return Center(
            child: Text("Something Wrong", style: TextStyle(fontSize: 27)),
          );
        },
      ),
    );
  }

  Future<List<ProductModel>> getComments() async {
    String url = "https://dummyjson.com/products";
    http.Response myRsp = await http.get(Uri.parse(url));

    if (myRsp.statusCode == 200) {
      dynamic data = jsonDecode(myRsp.body);
      AllProductDataModel allData = AllProductDataModel.fromJson(data);
      return allData.products;
    } else {
      return [];
    }
  }
}

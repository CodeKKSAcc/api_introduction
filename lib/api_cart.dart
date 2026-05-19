

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_6/api_models/cart_model.dart';

class ApiCart extends StatelessWidget {
  List<CartModel> allData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carts"), centerTitle: true),
      body: FutureBuilder<List<CartModel>>(
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
              itemCount: allData.length ,
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
                    children: [
                      Text("All cart details :", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                      SizedBox(height: 21,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cart id: ${allData[index].id}", style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 12,),
                          Text("User id: ${allData[index].userId}", style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 12,),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total: ${allData[index].total}", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Discounted Total: ${allData[index].discountedTotal}", style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total: ${allData[index].total}", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Discounted Total: ${allData[index].discountedTotal}", style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total: ${allData[index].totalProducts}", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Total Quantity: ${allData[index].totalQuantity}", style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Text("Product details :", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                      SizedBox(height: 21,),
                      ListView.builder(
                        itemCount: allData[index].products.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, indx){
                         return Container(
                           padding: EdgeInsets.all(9),
                           margin: EdgeInsets.only(right: 12, left: 12, top: 12),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(12),
                             border: Border.all()
                           ),
                           child: Row(
                             children: [
                               Image.network(allData[index].products[indx].thumbnail, height: 81, width: 81, fit: BoxFit.fill,),
                               Expanded(child: SizedBox(width: 12,)),
                               Expanded(
                                 child: Column(
                                   children: [
                                     Text("Id: ${allData[index].products[indx].id}", style: TextStyle(fontWeight: FontWeight.bold),),
                                     SizedBox(height: 12,),
                                     Text("Title: ${allData[index].products[indx].title}", maxLines: 2, style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis,),softWrap: true,),
                                     SizedBox(height: 12,),
                                     Text("Price: ${allData[index].products[indx].price}", style: TextStyle(fontWeight: FontWeight.bold),),
                                     SizedBox(height: 12,),
                                     Text("Quantity: ${allData[index].products[indx].quantity}", style: TextStyle(fontWeight: FontWeight.bold),),
                                     SizedBox(height: 12,),
                                     Text("Total: ${allData[index].products[indx].total}", style: TextStyle(fontWeight: FontWeight.bold),),
                                     SizedBox(height: 12,),
                                     Text("Discounted Total: ${allData[index].products[indx].discountedTotal}", style: TextStyle(fontWeight: FontWeight.bold),),
                                   ],
                                 ),
                               )
                             ],
                           ),
                         );
                      })
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

  Future<List<CartModel>> getComments() async {
    String url = "https://dummyjson.com/carts";
    http.Response myRsp = await http.get(Uri.parse(url));

    if (myRsp.statusCode == 200) {
      dynamic data = jsonDecode(myRsp.body);
      AllCartModel allData = AllCartModel.fromJson(data);
      return allData.carts;
    } else {
      return [];
    }
  }
}



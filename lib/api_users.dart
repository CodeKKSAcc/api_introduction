import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_6/api_models/user_model.dart';

class ApiUsers extends StatelessWidget {
  List<UserModel> allData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users"), centerTitle: true),
      body: FutureBuilder<List<UserModel>>(
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personal Details",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 18),
                            Row(
                              children: [
                                Image.network(allData[index].image ?? "https://oggyandthecockroaches.fandom.com/wiki/Oggy", height: 81, width: 81, fit: BoxFit.fill,),
                                SizedBox(width: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Id: ${allData[index].id}"),
                                    SizedBox(width: 21,),
                                    Text("Role: ${allData[index].role}"),
                                    SizedBox(width: 36,),
                                    Text("Name: ${allData[index].firstName}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text("Gender: ${snap.data![index].gender}"),
                            SizedBox(height: 12),
                            Text("Blood Group: ${snap.data![index].bloodGroup}"),
                            SizedBox(height: 12),
                            Text("Eye color: ${snap.data![index].eyeColor}"),
                            SizedBox(height: 12,),
                            Text("Height: ${snap.data![index].height}"),
                            SizedBox(height: 12,),
                            Text("Hair color: ${snap.data![index].hair.color}"),
                            SizedBox(height: 12,),
                            Text("Personal Address:", style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 18,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text("Address: ${allData[index].address.address}"),
                              Text("City: ${allData[index].address.city}"),
                              Text("State: ${allData[index].address.state}")
                            ],),
                            SizedBox(height: 12,),
                            Text("Postal-code: ${allData[index].address.postalCode}"),SizedBox(height: 12,),
                            Text("State-code: ${allData[index].address.stateCode}"),SizedBox(height: 12,),
                            Text("Country: ${allData[index].address.country}"),
                            SizedBox(height: 12,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text("Coordinates: ${allData[index].address.coordinates.lat}/${allData[index].address.coordinates.lng}"),
                              Text("SSN: ${allData[index].ssn}"),
                            ],),
                            SizedBox(height: 12,),
                            Text("Phone: ${allData[index].phone}"),
                            SizedBox(height: 12,),
                            Text("Email: ${allData[index].email}"),
                            SizedBox(height: 12,),
                            Text("IP  Address: ${allData[index].ip}"),
                            SizedBox(height: 12,),
                            Text("Bank Details", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,),),
                            SizedBox(height: 18,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text("Card Type: ${allData[index].bank.cardType}"),
                              Text("Currency Type: ${allData[index].bank.currency}"),
                              ],),
                            SizedBox(height: 12,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text("Card Number: ${allData[index].bank.cardNumber}"),
                              Text("Card Expire: ${allData[index].bank.cardExpire}"),
                            ],),
                            SizedBox(height: 12,),
                            Text("Company Details", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,),),
                            SizedBox(height: 18,),
                            Text("Company Name: ${allData[index].company.name}"),
                            SizedBox(height: 12,),
                            Text("Department: ${allData[index].company.department}"),
                            SizedBox(height: 12,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Company Address: "),
                                SizedBox(width: 12,),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Address: ${allData[index].company.address.address}"),
                                    SizedBox(height: 9,),
                                    Text("City: ${allData[index].company.address.city}"),
                                    SizedBox(height: 9,),
                                    Text("State: ${allData[index].company.address.state}"),
                                    SizedBox(height: 9,),
                                    Text("Country: ${allData[index].company.address.country}"),
                                    SizedBox(height: 9,),
                                    Text("Coordinates: ${allData[index].company.address.coordinates.lng}/${allData[index].company.address.coordinates.lat}"),
                                    SizedBox(height: 9,),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )
                : Center(child: Text("No User Yet !!!"));
          }

          return Center(
            child: Text("Something Wrong", style: TextStyle(fontSize: 27)),
          );
        },
      ),
    );
  }

  Future<List<UserModel>> getComments() async {
    String url = "https://dummyjson.com/users";
    http.Response myRsp = await http.get(Uri.parse(url));

    if (myRsp.statusCode == 200) {
      dynamic data = jsonDecode(myRsp.body);
      AllDataModel allData = AllDataModel.fromJson(data);
      return allData.users;
    } else {
      return [];
    }
  }
}

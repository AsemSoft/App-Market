import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/models/order.dart';
import 'package:global_market/screens/admin/orderDetails.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(LocaleKeys.Order_Manage_Page.tr()) ,
      ),
        body: StreamBuilder<QuerySnapshot>(
      stream: _store.loadOrders(),
      builder: (context, snapshot) {
        if (! snapshot.hasData) {
          return Center(
            child: Text(LocaleKeys.NO_Order.tr()),
          );
        }
        else {
          List<Order> orders = [];
          for (var doc in snapshot.data.docs){
              orders.add(Order(
                totalPrice: doc[kTotalPrice],
                address:doc[kAddress],
                docId: doc.id,
                orderDate:doc[kDate] ,
                userPhone:doc[kPhone] ,
                userEmail:doc[kEmail] ,
                userName: doc[kUsersName],
            ));
          }
          return ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: ()
                {
                  Navigator.pushNamed(context, OrderDetails.id,arguments:orders[index].docId );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .38,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Name
                      SizedBox(
                        height: 20,
                      ),
                      Text(LocaleKeys.User_name.tr()+': ${orders[index].userName}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      //Email
                      Text(LocaleKeys.Email.tr()+': ${orders[index].userEmail}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      //time
                      Text(LocaleKeys.Time_Date.tr()+': ${orders[index].orderDate}',
                        style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //day
                      // Text(LocaleKeys.Day.tr()+': ${orders[index].orderDay}',
                      //   style:
                      //   TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      //Phone
                      Text(LocaleKeys.Phone_number.tr()+': ${orders[index].userPhone}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      //Location
                      Text(LocaleKeys.User_Location.tr()+': ${orders[index].address}',
                        style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      //Total Price
                      Text(LocaleKeys.Total_price.tr()+': \$${orders[index].totalPrice}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),

                    ],
                  ),
                ),
              ),
            ),
            itemCount: orders.length,
          );
        }
      },
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';

import 'package:imaginary_bank_locator/shared/dialog_view.dart';

class ViewDetailsScreen extends StatefulWidget {
  const ViewDetailsScreen({Key key}) : super(key: key);
  static const route = '/view-details-screen';
  @override
  _ViewDetailsScreenState createState() => _ViewDetailsScreenState();
}

class _ViewDetailsScreenState extends State<ViewDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as MapsData;
    String phone = data.phone == null ? 'No number' : data.phone;
    return Scaffold(
      backgroundColor: Color.fromRGBO(4, 160, 160, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(4, 160, 160, 1),
        centerTitle: true,
        title: Text('LOCATION'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.keyboard_arrow_left_sharp,
            size: 35,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: data.type == 'branch'
                          ? Image.asset('assets/images/ic_pin_branch.png')
                          : Image.asset('assets/images/ic_pin_atm.png'),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.name,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            data.address,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Column()
                  ],
                ),
              ),
            ),
            Card(
              color: Color.fromRGBO(99, 192, 192, 1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact center',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(phone,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    Container(
                      child: Image.asset('assets/images/ic_phone.png'),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, DialogView.route),
              child: Card(
                color: Color.fromRGBO(99, 192, 192, 1),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Work Hours',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text('Opened',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                      Container(
                        child: Image.asset('assets/images/ic_clock.png'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Color.fromRGBO(99, 192, 192, 1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.address,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text('Solni trg 5',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    Container(
                      child: Image.asset('assets/images/ic_location.png'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color.fromRGBO(99, 192, 192, 1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meeting request',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(data.email,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    Container(
                      child: Image.asset('assets/images/ic_address.png'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color.fromRGBO(99, 192, 192, 1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Web site',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(data.website,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    Container(
                      child: Image.asset('assets/images/ic_web.png'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

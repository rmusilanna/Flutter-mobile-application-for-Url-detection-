import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:condition/condition.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TransactionListPage extends StatefulWidget {
  TransactionListPage({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  TransactionListState createState() => TransactionListState(text);
}

class TransactionListState extends State<TransactionListPage> {
  String text;
  bool isdata = true;
  TransactionListState(this.text);
  Future<Transations> getData() async {
    //complete fetch ....
    Map<String, String> _headers = {
      "Content-type": "application/json",
    };
    String links = text; //UrlDetection.link;
    print("Entered URL: " + text);
    var dataq = await http.post(
      'https://mldetector.herokuapp.com/test',
      body: json.encode({'url': links}),
      headers: _headers,
    );
    // print('connected.......................s.');

    var data = (json.decode(dataq.body));

    print("Domain Details");
    print(data);

    var domain = data['domain'];

    if (domain.isEmpty) {
      isdata = false;
      return Transations.fromJson1(data);
    }

    return Transations.fromJson(data);
  }

  final String t = '';
  Future f;

  @override
  void initState() {
    f = getData();
    print("kdsk");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Domain Details         '),
        ),
      ),
      body: FutureBuilder(
        future: f,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // print("snapshot1234");

          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading...'),
              ),
            );
          }
          print("sknfjnks");
          print(snapshot.data.isSafe);
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Conditioned.boolean(
                        snapshot.data.isSafe == true,
                        trueBuilder: () => Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'The link ${snapshot.data.url} is Safe to visit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 2.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          color: Colors.green,
                        ),
                        falseBuilder: () => Card(
                          color: Colors.red[500],
                          child: Text(
                            'The link ${snapshot.data.url} is Malicious',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              height: 2.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Conditioned.boolean(
                    isdata == true,
                    trueBuilder: () => DataTable(
                      horizontalMargin: 10,
                      columnSpacing: 50.0,
                      dataRowHeight: 50.0,
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(""),
                        ),
                        DataColumn(
                          label: Text(""),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                'Domain Name: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${snapshot.data.domain.domainName}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                'Organization: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${snapshot.data.domain.registrantDetails.organization}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                'Creation Date: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${snapshot.data.domain.creationDate}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                'Expiration Date: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${snapshot.data.domain.expirationDate}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                'Country:  ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${snapshot.data.domain.registrantDetails.country}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                'Country Code:  ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${snapshot.data.domain.registrantDetails.countryCode}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                'State:  ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${snapshot.data.domain.registrantDetails.state}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    falseBuilder: () => Container(
                      child: Center(
                        child: Text(
                          "Domain details not found",
                          style: TextStyle(fontSize: 20, height: 15),
                        ),
                      ),
                    ),
                  ),
                  Conditioned.boolean(
                    snapshot.data.isSafe,
                    trueBuilder: () => Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.blue[200],
                          onPressed: () async {
                            if (await canLaunch(snapshot.data.url)) {
                              launch(snapshot.data.url);
                            }
                          },
                          child: Text('Visit'),
                        ),
                      ],
                    ),
                    falseBuilder: () => Column(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class Transations {
  Domain domain;
  bool isSafe;
  String url;

  Transations.isa({this.url, this.isSafe});

  factory Transations.fromJson1(Map<String, dynamic> json) => Transations(
        // domain: Domain.fromJson(json["domain"]),
        isSafe: json["isSafe"],
        url: json["url"],
      );

  Transations({
    this.domain,
    this.isSafe,
    this.url,
  });

  factory Transations.fromJson(Map<String, dynamic> json) => Transations(
        domain: Domain.fromJson(json["domain"]),
        isSafe: json["isSafe"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "domain": domain.toJson(),
        "isSafe": isSafe,
        "url": url,
      };
}

class Domain {
  String creationDate;
  String domainName;
  String expirationDate;
  RegistrantDetails registrantDetails;
  String registrarName;
  String updationDate;

  Domain({
    this.creationDate = '',
    this.domainName = '',
    this.expirationDate = '',
    this.registrantDetails,
    this.registrarName = '',
    this.updationDate = '',
  });

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
        creationDate: json["Creation Date"],
        domainName: json["Domain Name"],
        expirationDate: json["Expiration Date"],
        registrantDetails:
            RegistrantDetails.fromJson(json["Registrant Details"]),
        registrarName: json["Registrar Name"],
        updationDate: json["Updation Date"],
      );

  Map<String, dynamic> toJson() => {
        "Creation Date": creationDate,
        "Domain Name": domainName,
        "Expiration Date": expirationDate,
        "Registrant Details": registrantDetails.toJson(),
        "Registrar Name": registrarName,
        "Updation Date": updationDate,
      };
}

class RegistrantDetails {
  String country;
  String countryCode;
  String organization;
  String state;
  String street;

  RegistrantDetails({
    this.country = '',
    this.countryCode = '',
    this.organization = '',
    this.state = '',
    this.street = '',
  });

  factory RegistrantDetails.fromJson(Map<String, dynamic> json) =>
      RegistrantDetails(
        country: json["country"],
        countryCode: json["countryCode"],
        organization: json["organization"],
        state: json["state"],
        street: json["street"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "countryCode": countryCode,
        "organization": organization,
        "state": state,
        "street": street,
      };
}

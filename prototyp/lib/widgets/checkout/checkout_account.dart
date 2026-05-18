import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/credit_card.dart';
import 'package:prototyp/model/imat/customer.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/widgets/checkout/navigation_button.dart';
import 'package:provider/provider.dart';

class CheckoutAccount extends StatefulWidget {
  const CheckoutAccount({super.key});

  @override
  State<CheckoutAccount> createState() => _CheckoutAccountState();
}

class _CheckoutAccountState extends State<CheckoutAccount> {

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController addressController;
  late TextEditingController postCodeController;
  late TextEditingController creditCardNumberController;
  late TextEditingController creditCardCVCController;
  late TextEditingController creditCardMonthController;
  late TextEditingController creditCardYearController;

    @override
  void initState() {
    super.initState();

    var dataHandler =
        Provider.of<ImatDataHandler>(context, listen: false);

    Customer customer = dataHandler.getCustomer();
    CreditCard creditCard = dataHandler.getCreditCard();

    firstNameController =
        TextEditingController(text: customer.firstName);

    lastNameController =
        TextEditingController(text: customer.lastName);

    addressController =
        TextEditingController(text: customer.address);

    postCodeController =
        TextEditingController(text: customer.postCode);

    creditCardNumberController =
        TextEditingController(text: creditCard.cardNumber);

    creditCardCVCController = 
        TextEditingController(text: creditCard.verificationCode.toString());

    creditCardMonthController =
        TextEditingController(text: creditCard.validMonth.toString());

    creditCardYearController =
        TextEditingController(text: creditCard.validYear.toString());
  }

  @override
  Widget build(BuildContext context) {
    var dataHandler = context.watch<ImatDataHandler>();
    var customer = dataHandler.getCustomer();
    var creditCard = dataHandler.getCreditCard();

    if (customer.firstName != '' && creditCard.holdersName != '') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Dina Uppgifter",
            style: TextStyle(fontSize: 25)
          ),
          SizedBox(width: 1600, height: 780, child: Card(child: Padding(padding: EdgeInsets.all(20), child: Column(children: [
            Row(children: [
              Text("Förnamn: " + customer.firstName),
            ]),
            Row(children: [
              Text("Efternamn: " + customer.lastName),
            ]),
            Row(children: [
              Text("Adress: " + customer.address),
            ]),
            Row(children: [
              Text("Postkod: " + customer.postCode),
            ]),
            SizedBox(height: 50),
            Row(children: [
              Text("Kortnummer: " + creditCard.cardNumber),
            ]),
            Row(children: [
              Text("Utgångsdatum: " + creditCard.validMonth.toString() + "/" + creditCard.validYear.toString()),
            ]),
            Row(children: [
              Text("CVC: " + creditCard.verificationCode.toString()),
            ]),
            Spacer(),
            Row(children: [
              NavigationButton(text: "Spara Uppgifter", func: (){})
            ],)
          ])))),
          SizedBox(height: 30),
        ],);}
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Dina Uppgifter",
            style: TextStyle(fontSize: 25)
          ),
          SizedBox(width: 1600, height: 780, child: Card(child: Padding(padding: EdgeInsets.all(20), child: Column(children: [
            Row(children: [
              Text("Förnamn:"),
              Spacer(),
              SizedBox(width: 400, height: 50, child: TextField(
                controller: firstNameController,
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 0),
                  hintText: 'Ditt namn här',
                ),
              )),
              SizedBox(width: 900)
            ]),
            Row(children: [
              Text("Efternamn:"),
              Spacer(),
              SizedBox(width: 400, height: 50, child: TextField(
                controller: lastNameController,
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 0),
                  hintText: 'Ditt namn här',
                ),
              )),
              SizedBox(width: 900)
            ]),
            Row(children: [
              Text("Adress:"),
              Spacer(),
              SizedBox(width: 400, height: 50, child: TextField(
                controller: addressController,
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 0),
                  hintText: 'Din address här',
                ),
              )),
              SizedBox(width: 900,)
            ]),
            Row(children: [
              Text("Postkod:"),
              Spacer(),
              SizedBox(width: 400, height: 50, child: TextField(
                controller: postCodeController,
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 0),
                  hintText: 'Din Postkod här',
                ),
              )),
              SizedBox(width: 900,)
            ]),
            SizedBox(height: 50),
            Row(children: [
              Text("Kortnummer:"),
              Spacer(),
              SizedBox(width: 400, height: 50, child: TextField(
                controller: creditCardNumberController,
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 0),
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
              )),
              SizedBox(width: 900,)
            ]),
            Row(children: [
              Text("Utgångsdatum:"),
              Spacer(),
              SizedBox(width: 200, height: 50, child: TextField(
                controller: creditCardMonthController,
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 0),
                  hintText: 'Månad',
                ),
              )),
              SizedBox(width: 200, height: 50, child: TextField(
                controller: creditCardYearController,
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 0),
                  hintText: 'År',
                ),
              )),
              SizedBox(width: 900)
            ]),
            Row(children: [
              Text("CVC:"),
              Spacer(),
              SizedBox(width: 400, height: 50, child: TextField(
                controller: creditCardCVCController,
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 0),
                  hintText: 'CVC',
                ),
              )),
              SizedBox(width: 900,)
            ]),
            Spacer(),
            Row(children: [
              NavigationButton(text: "Spara Uppgifter", func: (){
                Customer customer = dataHandler.getCustomer();
                CreditCard card = dataHandler.getCreditCard();

                customer.firstName = firstNameController.text;
                customer.lastName = lastNameController.text;
                customer.address = addressController.text;
                customer.postCode = postCodeController.text;
                card.cardNumber = creditCardNumberController.text;
                card.verificationCode = int.parse(creditCardCVCController.text);
                card.validMonth = int.parse(creditCardMonthController.text);
                card.validYear = int.parse(creditCardYearController.text);

                dataHandler.setCustomer(customer);
                dataHandler.setCreditCard(card);
              })
            ],)
          ])))),
          SizedBox(height: 30),
        ],);
    }
  }
}
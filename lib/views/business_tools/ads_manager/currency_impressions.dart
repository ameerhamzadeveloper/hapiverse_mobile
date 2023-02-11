import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../components/secondry_button.dart';

class CurrencyImpressions extends StatefulWidget {
  const CurrencyImpressions({Key? key}) : super(key: key);

  @override
  State<CurrencyImpressions> createState() => _CurrencyImpressionsState();
}

class _CurrencyImpressionsState extends State<CurrencyImpressions> {
  List<String> currency = [
    'USD',
  ];

  double usdAmount = 5.0;
  String localCurrency = '5';
  String impressions = '5000';
  // String amout = '12';
  String currencyVal = 'USD';
  String location = 'United States';
  double impressionVal = 100;

  void getAmounts() async {
    if(currencyVal == 'USD'){
      usdAmount = double.parse(localCurrency);
      // var usdConvert = await MoneyConverter.convert(
      //     Currency(Currency.USD, amount: amout), Currency(Currency.USD));
      // setState(() {
      //   amout = usdConvert!;
      // });
    }else if(currencyVal == 'GPB'){
      location = 'United Kingdom';
      // var usdConvert = await MoneyConverter.convert(
      //     Currency(Currency.GBP, amount: double.parse(localCurrency)), Currency(Currency.USD));
      setState(() {
        // usdAmount = usdConvert!;
      });
    }else if(currencyVal == 'EUR'){
      location = 'Germany';
      // var usdConvert = await MoneyConverter.convert(
      //     Currency(Currency.EUR, amount: double.parse(localCurrency)), Currency(Currency.USD));
      // setState(() {
      //   usdAmount = usdConvert!;
      // });
      print(usdAmount);
    }
    impressions = (usdAmount * 1000).round().toString();
  }
  calculateImpressions(){

  }
  @override
  void initState() {
    super.initState();
    getAmounts();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency & Impressions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Currency",style: TextStyle(fontSize: 18),),
            ),
            SizedBox(height: 10,),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(isExpanded:true,value: currencyVal,items: currency.map((e){
                    return DropdownMenuItem(child: Text(e),value: e,);
                  }).toList(), onChanged: (c){
                    setState(() {
                      currencyVal = c.toString();
                    });
                    getAmounts();
                  }),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Divider(),
            SizedBox(height: 10,),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Text("Impressions",style: TextStyle(fontSize: 18),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$localCurrency $currencyVal - $impressions Impressions",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 10,),
            Slider(value: impressionVal,min: 5,max: 500, onChanged: (v){
              setState(() {
                impressionVal = v;
                localCurrency = v.round().toString();
                getAmounts();
              });
            })
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SecendoryButton(text: "Done",onPressed: (){
          bloc.setCurrency(currencyVal, location, localCurrency, impressions);
          Navigator.pop(context);
        },),
      ),
    );
  }
}

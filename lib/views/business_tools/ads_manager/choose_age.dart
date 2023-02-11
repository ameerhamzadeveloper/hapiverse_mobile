import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/components/secondry_button.dart';
class ChoseAdsAge extends StatefulWidget {
  const ChoseAdsAge({Key? key}) : super(key: key);

  @override
  State<ChoseAdsAge> createState() => _ChoseAdsAgeState();
}

class _ChoseAdsAgeState extends State<ChoseAdsAge> {
  RangeValues _currentRangeValues = const RangeValues(4, 65);

  static String _valueToString(double value) {
    return value.toStringAsFixed(0);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location & Audionce"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("People you choose through targeting"),
            SizedBox(height: 10,),
            Text("Location",style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                showCountryPicker(
                  // showWorldWide: true,
                  context: context,
                  countryListTheme: CountryListThemeData(
                    flagSize: 25,
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                    // bottomSheetHeight: 500, // Optional. Country list modal height
                    //Optional. Sets the border radius for the bottomsheet.
                    borderRadius:const  BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    //Optional. Styles the search field.
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Start typing to search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                  onSelect: (Country country)
                  {
                    bloc.addAdsLocations(country.name);
                    print('Select country: ${country.name}');
                    },
                );
              },
              child: Container(
                width: getWidth(context),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)
                ),
                child: Text("Search country",style: TextStyle(color: Colors.grey),),
              ),
            ),
            SizedBox(height: 10,),
            state.locations == null ? Container():Wrap(
              spacing: 10,
              children: List.generate(state.locations!.length, (index){
                return Chip(
                  onDeleted: (){
                    bloc.removeCountry(index);
                  },
                  label: Text(state.locations![index]),
                  backgroundColor: Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                );
              }),
            ),
            Divider(),
            Text("Audionce",style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Age ${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(height: 10,),
            RangeSlider(
              values: _currentRangeValues,
              min: 4,
              max: 65,
              divisions: 30,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                  bloc.setAdsAudionce("${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}",_currentRangeValues.start.round().toString(),'${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}');
                });
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SecendoryButton(text: "Done",onPressed: (){Navigator.pop(context);},),
      ),
    );
  },
);
  }
}

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../../data/model/languages.dart';
import '../../../utils/constants.dart';
class TranslatorLanguage extends StatefulWidget {
  const TranslatorLanguage({Key? key}) : super(key: key);

  @override
  State<TranslatorLanguage> createState() => _TranslatorLanguageState();
}

class _TranslatorLanguageState extends State<TranslatorLanguage> {

  LanguagesForTranslator lan = LanguagesForTranslator();

  String firstLan = 'English';
  String secondLan = 'French';
  String firstCode = 'en';
  String secCode = 'fr';
  String text = '';
  String translation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      color: Colors.white
                    ),
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        underline: const Divider(color: Colors.grey,thickness: 1.5,),
                        isExpanded: true,
                        iconEnabledColor: kUniversalColor,
                        items: lan.languages.map((e) {
                          return DropdownMenuItem(
                            onTap: (){
                              print(e);
                              firstCode = e['code']!;
                            },
                            value: e['name'],
                            child: Text(e['name']!),
                          );
                        }).toList(),
                        value: firstLan,
                        onChanged: (val){
                          setState(() {
                            firstLan = val.toString();
                          });
                        },
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                        color: Colors.white
                    ),
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        underline: const Divider(color: Colors.grey,thickness: 1.5,),
                        isExpanded: true,
                        iconEnabledColor: kUniversalColor,
                        items: lan.languages.map((e) {
                          return DropdownMenuItem(
                            onTap: (){
                              print(e);
                              secCode = e['code']!;
                            },
                            value: e['name'],
                            child: Text(e['name']!),
                          );
                        }).toList(),
                        value: secondLan,
                        onChanged: (val){
                          print(val);
                          setState(() {
                            secondLan = val.toString();
                          });
                        },
                        isDense: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Text"
                ),
                onChanged: (v){
                  setState(() {
                    text = v;
                  });
                  GoogleTranslator().translate(text,from: firstCode,to: secCode).then((value){
                    print(value);
                    setState(() {
                      translation = value.text;
                    });
                  });
                },
              ),
            ),
            SizedBox(height: 10,),
            text == '' ? Container():
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: TextEditingController(text: translation),
                maxLines: 6,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Translation"
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

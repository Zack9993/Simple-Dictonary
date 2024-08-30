import 'package:flutter/material.dart';
import 'package:myapp/dictonary_model.dart';
import 'package:myapp/services.dart';

class DictonaryHomepage extends StatefulWidget {
  const DictonaryHomepage({super.key});

  @override
  State<DictonaryHomepage> createState() => _DictonaryHomepageState();
}

class _DictonaryHomepageState extends State<DictonaryHomepage> {
  DictonaryModel? myDictonaryModel;
  bool isLoading = false;
  String noDataFound = "Now you can search the word";

  searchContain(String word) async {
    setState(() {
      isLoading = true;
    });
    try {
      myDictonaryModel = await APIservices.fetchData(word);
    } catch (e) {
      myDictonaryModel = null;
      noDataFound = "Meaning can't be found";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dictonary"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            //Used to search the word.
            SearchBar(
              hintText: "Search the word here",
              onSubmitted: (value) {
                searchContain(value);
              },
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const LinearProgressIndicator()
            else if (myDictonaryModel != null)
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      myDictonaryModel!.word,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    Text(myDictonaryModel!.phonetics.isEmpty
                        ? myDictonaryModel!.phonetics[0].text ?? ""
                        : ""),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: myDictonaryModel!.meanings.length,
                        itemBuilder: (context, index) {
                          
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              Center(
                child: Text(
                  noDataFound,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
          ],
        ),
      ),
    );
  }

  showMeaning(Meaning meaning) {
    String wordDefination = "";
    for (var element in meaning.definitions) {
      int index = meaning.definitions.indexOf(element);
      wordDefination += "\n${index + 1}. ${element.definition}\n";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Text(
              meaning.partOfSpeech,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.blue),
            ),
            const SizedBox(height: 10),
            const Text(
              "Definations: ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
            Text(
              wordDefination,
              style: const TextStyle(
                fontSize: 16,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

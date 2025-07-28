import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  String? selectedPeriod;

  String? selected;
  double? totalInterest;
  double? monthlyInterest;
  double? monthlyInstallment;

  void loancalculation() {
    if (selectedPeriod == null) {
      
      return;
    }
    final amount = int.parse(_controller1.text) - int.parse(_controller2.text);
    final tinterest =
        amount * (double.parse(_controller3.text) / 100) * int.parse(selected!);
    final minterest = tinterest / (int.parse(selected!) * 12);
    final minstall = (amount + tinterest) / (int.parse(selected!) * 12);

    setState(() {
      totalInterest = tinterest;
      monthlyInterest = minterest;
      monthlyInstallment = minstall;
    });
  }

  Widget result({String? title, double? amount}) {
    return Expanded(
      
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title ?? '', style: TextStyle(fontSize: 20)),
            Text(
              "TL${amount?.toStringAsFixed(2) ?? '0'}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Widget buildPeriodRow(int start, int end) {
    return Row(
      children: [
        for (var i = start; i <= end; i++)
          loadperiod(
            period: i.toString(),
            selectedPeriod: selectedPeriod,
            onTap: () {
              setState(() {
                selectedPeriod = i.toString();
                selected = i.toString();
              });
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.notes, size: 30, color: Colors.black),
        toolbarHeight: 30,
        backgroundColor: Colors.yellow,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.info, size: 30, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Taşıt Kredisi ",
                        style: GoogleFonts.robotoMono(fontSize: 35),
                      ),
                      Text(
                        "Hesaplama",
                        style: GoogleFonts.robotoMono(fontSize: 35),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 40, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inputform("Araba fiyat", _controller1, "örn: 500.000 TL"),
                      SizedBox(height: 10),
                      inputform("Peşinat", _controller2, "örn: 100.000 TL"),
                      SizedBox(height: 10),
                      inputform("Faiz Oranı (%)", _controller3, "örn: % 2.5"),
                      SizedBox(height: 10),
                      Text(
                        "Taksit",
                        style: GoogleFonts.robotoMono(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      buildPeriodRow(1, 6),
                      SizedBox(height: 5),
                      buildPeriodRow(7, 12),
                      SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              loancalculation();
                              Future.delayed(Duration.zero);
                              showModalBottomSheet(
                                isDismissible: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        20,
                                        30,
                                        0,
                                        0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Sonuç",
                                            style: GoogleFonts.robotoMono(
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 1250,
                                                  child: result(
                                                    title: "Toplam Faiz",
                                                    amount: totalInterest,
                                                  ),
                                                ),
                                                Container(
                                                  width: 1250,
                                                  child: result(
                                                    title: "Aylık Faiz",
                                                    amount: monthlyInterest,
                                                  ),
                                                ),
                                                Container(
                                                  width: 1250,
                                                  child: result(
                                                    title: "Aylık Taksit",
                                                    amount: monthlyInstallment,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 60,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Tekrar Hesapla',
                                                  style: GoogleFonts.robotoMono(
                                                    fontSize: 20,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                "Hesapla",
                                style: GoogleFonts.robotoMono(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget loadperiod({
  required String period,
  required String? selectedPeriod,
  required VoidCallback onTap,
}) {
  final isSelected = selectedPeriod == period;

  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 16, 0),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: isSelected ? Border.all(color: Colors.red, width: 2) : null,
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            period,
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget inputform(String label, TextEditingController controller, String hint) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: GoogleFonts.robotoMono(fontSize: 18)),
      SizedBox(height: 5),
      Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: hint,
          ),
        ),
      ),
    ],
  );
}

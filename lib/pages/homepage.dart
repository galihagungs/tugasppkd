import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_new/bloc/category/category_bloc.dart';
import 'package:ui_new/bloc/product/product_bloc.dart';
import 'package:ui_new/local/dbHelper.dart';
import 'package:ui_new/local/query/productLocalQuery.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DbHelper dbhelper = DbHelper();
  final TextEditingController _namaBarang = TextEditingController();
  final TextEditingController _kuantitasBarang = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCatetgory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inventory",
          style: TextStyle(fontFamily: "Kanit", fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container(
                      color: Colors.white,
                      child: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Selamat Datang, User",
                    style: TextStyle(fontFamily: "Kanit", fontSize: 15),
                  ),
                ],
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
            ],
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 160,
                child: ElevatedButton(
                  onPressed: () {
                    openDialog2();
                  },
                  child: Row(children: [Icon(Icons.add), Text("Tambah Data")]),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryFailed) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      constraints: BoxConstraints(
                        minHeight: 25,
                        minWidth: 25,
                        maxHeight: 25,
                        maxWidth: 25,
                      ),
                    ),
                  );
                } else if (state is CategorySucces) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.cattegory.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                state.cattegory[index].images.toString(),
                                width: 25,
                              ),
                              Text(state.cattegory[index].name.toString()),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return Center(child: Text("Failed Load Data"));
              },
            ),
          ),

          Expanded(
            flex: 12,
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductFailed) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductSucces) {
                  return ListView.builder(
                    itemCount: state.map2.length,
                    itemBuilder: (context, index) {
                      return Text(state.map2[index]['nama']);
                    },
                  );
                }
                return Center(child: Text("Failed Load Data"));
              },
            ),
          ),
        ],
      ),
    );
  }

  void openDialog2() {
    showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: MediaQuery.of(context).size.height * 0.3,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Masukan Data",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        "Nama Barang",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                      inputpop(_namaBarang),

                      SizedBox(height: 10),
                      Text(
                        "Kuantitas",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                      inputpop(_kuantitasBarang),

                      Center(
                        child: Row(
                          children: [
                            TextButton(
                              child: Text("Submit"),
                              onPressed: () {
                                dbhelper.insertProduct(
                                  titleData: ProductQuery.tableName,
                                  data: {
                                    ProductQuery.id: null,
                                    ProductQuery.nama: _namaBarang.text,
                                    ProductQuery.quantity:
                                        _kuantitasBarang.text,
                                  },
                                );
                                context.read<ProductBloc>().add(
                                  GetProductAll(),
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextField inputpop(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}

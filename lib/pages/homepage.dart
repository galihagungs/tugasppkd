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
  String? selected;
  String? catNow;
  Map<String, dynamic>? data;
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
              IconButton(
                onPressed: () {
                  openDialog2(false);
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),

          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                context.read<ProductBloc>().add(
                  SearchProduct(
                    searchData: value,
                    namaCategory: catNow.toString(),
                  ),
                );
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
                hintText: "Search by Name",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),

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
                  catNow = state.cattegory[0].name.toString();
                  context.read<ProductBloc>().add(
                    GetProductByCategory(catNow.toString()),
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.cattegory.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<ProductBloc>().add(
                              GetProductByCategory(
                                state.cattegory[index].name.toString(),
                              ),
                            );
                            catNow = state.cattegory[index].name.toString();
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(2, 2), // Shadow position
                                ),
                              ],
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
                  return state.map2.isEmpty
                      ? Center(child: Text("Data Kosong"))
                      : ListView.builder(
                        itemCount: state.map2.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(state.map2[index]['nama']),
                                        Text(state.map2[index]['category']),
                                        Text(
                                          state.map2[index]['quantity']
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            data = state.map2[index];
                                            _namaBarang.text =
                                                state.map2[index]['nama'];
                                            _kuantitasBarang.text =
                                                state.map2[index]['quantity']
                                                    .toString();
                                            selected =
                                                state.map2[index]['category'];
                                            openDialog2(true);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.yellowAccent,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            dbhelper.deleteProduct(
                                              id: state.map2[index]['id'],
                                            );
                                            context.read<ProductBloc>().add(
                                              GetProductByCategory(
                                                catNow.toString(),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
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

  void openDialog2(bool isEdit) {
    context.read<CategoryBloc>().add(SetDropdownCatetgory());
    showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: MediaQuery.of(context).size.height * 0.26,
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
                  child:
                      isEdit
                          ? isiPop(context, isEdit, data: data)
                          : isiPop(context, isEdit),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column isiPop(
    BuildContext context,
    bool isEdit, {
    Map<String, dynamic>? data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isEdit
            ? Text(
              "Edit Data",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            )
            : Text(
              "Masukan Data",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

        SizedBox(height: 10),
        Text(
          "Nama Barang",
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.start,
        ),
        isEdit
            ? inputpop(_namaBarang, true, valueNew: data?['nama'])
            : inputpop(_namaBarang, false),

        SizedBox(height: 10),
        Text(
          "Kuantitas",
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.start,
        ),
        isEdit
            ? inputpop(
              _kuantitasBarang,
              true,
              valueNew: data?['quantity'].toString(),
            )
            : inputpop(_kuantitasBarang, false),

        SizedBox(height: 10),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CategorySuccesDrowDown) {
              return DropdownButton<String>(
                value: state.valueDrop.isEmpty ? selected : state.valueDrop,
                items:
                    state.cattegory.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.name,
                        child: Text(category.name.toString()),
                      );
                    }).toList(),
                onChanged: (value) {
                  context.read<CategoryBloc>().add(
                    SetDropdownCatetgory(valueData: value),
                  );
                  selected = value;
                },
                hint: Text("Select Category"),
              );
            }
            return Center();
          },
        ),
        Center(
          child: Row(
            children: [
              TextButton(
                child: Text("Submit"),
                onPressed: () {
                  if (_kuantitasBarang.text.isNotEmpty ||
                      _namaBarang.text.isNotEmpty ||
                      (selected?.isNotEmpty ?? false)) {
                    isEdit
                        ? dbhelper.updateProduct(
                          data: {
                            ProductQuery.id: data?['id'],
                            ProductQuery.nama: _namaBarang.text,
                            ProductQuery.category: data?['category'],
                            ProductQuery.quantity: _kuantitasBarang.text,
                          },
                        )
                        : dbhelper.insertProduct(
                          titleData: ProductQuery.tableName,
                          data: {
                            ProductQuery.id: null,
                            ProductQuery.nama: _namaBarang.text,
                            ProductQuery.category: selected,
                            ProductQuery.quantity: _kuantitasBarang.text,
                          },
                        );
                    context.read<ProductBloc>().add(
                      GetProductByCategory(catNow.toString()),
                    );
                    context.read<CategoryBloc>().add(GetCatetgory());
                    _kuantitasBarang.clear();
                    _namaBarang.clear();
                    selected = null;
                    Navigator.of(context).pop();
                  }
                },
              ),

              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<CategoryBloc>().add(GetCatetgory());
                  _kuantitasBarang.clear();
                  _namaBarang.clear();
                  selected = null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextFormField inputpop(
    TextEditingController controller,
    bool isEdit, {
    String? valueNew,
  }) {
    return TextFormField(
      onChanged: (value) {
        controller.text = value;
      },
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

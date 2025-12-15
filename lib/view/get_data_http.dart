import '../data/Product.dart';
import 'package:flutter/material.dart';
import 'package:dppb/service/product_http.dart';

class GetDataHttp extends StatefulWidget {
  const GetDataHttp({super.key});

  @override
  State<GetDataHttp> createState() => _GetDataHttpState();
}

class _GetDataHttpState extends State<GetDataHttp> {
  List<Product> daftarProduct = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ambil data"),),
      body: FutureBuilder(
          future: getProductList(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              daftarProduct = snapshot.data!;
               return ListView.builder(
                  itemCount: daftarProduct.length,
                  itemBuilder: (BuildContext context, int index){
                    String foto = daftarProduct[index].foto.toString();
                     return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                         foto!="null" ? Image.network(foto) : Image.network("https://picsum.photos/640/480?random=94599"),
                          ListTile(
                            leading: Icon(Icons.list),
                            title: Text(daftarProduct[index].name.toString()),
                            subtitle: Text(daftarProduct[index].description.toString()),
                            trailing: Icon(Icons.arrow_forward),
                          )
                        ],
                      ),
                    );
                  },
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            else{
              return Text("Kesalahan ketika mengambil data");
            }
          })
    );
  }
}

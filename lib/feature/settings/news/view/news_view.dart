import 'package:cepdovizapp/core%20/enums/applocalizations.dart';
import 'package:cepdovizapp/core%20/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../detail/news_detail_view.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.salt,
      appBar: AppBar(
        scrolledUnderElevation: 00,
        title: Text(
          AppLocalizations.of(context).translate('Haber'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: CustomColors.salt,
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('haberler').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: CustomColors.grey,
                strokeWidth: 5,
              );
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text("Veri bulunamadı");
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 6.0,
                  childAspectRatio: 1.30,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var document = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(
                            title: document['baslik'],
                            description: document['icerik'],
                            date: document['tarih'],
                            imageUrl: document['imageUrl'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Card(
                        elevation: 3.0,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: FutureBuilder(
                                  future: Future.delayed(
                                      const Duration(seconds: 1)),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: CustomColors.grey,
                                          strokeWidth: 5,
                                        ),
                                      );
                                    } else {
                                      return document['imageUrl'] != null
                                          ? Image.network(
                                        document['imageUrl'],
                                        fit: BoxFit.fitHeight,
                                        alignment: Alignment.center,
                                      )
                                          : Container();
                                    }
                                  },
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document['baslik'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('Devam'),
                                      style: const TextStyle(
                                        color: CustomColors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );

  }
}

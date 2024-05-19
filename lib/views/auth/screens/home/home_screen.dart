
import 'package:flutter/material.dart';
import 'package:ft_e_buy/components/category_card.dart';
import 'package:ft_e_buy/components/my_appbar.dart';
import 'package:ft_e_buy/providers/auth_provider.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Consumer<AuthProvider>(builder: (context, provider, w) {
        return  provider.allCategories == null
            ? const Center(
          child: Text('No Categories Found'),
        )
            : ListView.builder(
            itemCount: provider.allCategories!.length,
            itemBuilder: (context, index) {
              return CategoryCard(provider.allCategories![index]);
            });
      }),
    );
  }
}
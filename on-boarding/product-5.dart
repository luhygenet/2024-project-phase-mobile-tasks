// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<Card> _BuildCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(product.assetName,
                  package: product.assetPackage, fit: BoxFit.fitWidth),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: theme.textTheme.titleLarge,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          formatter.format(product.price),
                          style: theme.textTheme.titleSmall,
                        )
                      ],
                    )))
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          title: Text('SHRINE'),
          actions: [
            IconButton(
              onPressed: () {
                print('Search Button');
              },
              icon: Icon(
                Icons.search,
                semanticLabel: 'search',
              ),
            ),
            IconButton(
              onPressed: () {
                print('Filter Button');
              },
              icon: Icon(
                Icons.tune,
                semanticLabel: 'filter',
              ),
            )
          ],
        ),
        body: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            children: _BuildCards(context)));
  }
}

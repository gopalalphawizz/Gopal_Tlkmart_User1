import 'package:alpha_ecommerce_18oct/utils/routes.dart';
import 'package:alpha_ecommerce_18oct/viewModel/searchViewModel.dart';
import 'package:flutter/material.dart';

import '../../utils/color.dart';

List<Map<dynamic, dynamic>> sort = [
  {'text': 'Top Rated'},
  {'text': 'New Arrival'},
  {'text': 'Oldest First'},
  {'text': 'Price - Low to high'},
  {'text': 'Price - High to low'}
];
String selectedType = "";

Future<void> homeSort(context, SearchViewModel searchProvider) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          child: SingleChildScrollView(
            child: Container(
                color: colors.overlayBG,
                height: 310,
                child: SortClass(
                  searchProvider: searchProvider,
                )),
          ));
    },
  );
}

class SortClass extends StatefulWidget {
  final SearchViewModel searchProvider;
  const SortClass({super.key, required this.searchProvider});

  @override
  State<SortClass> createState() => _SortClassState();
}

class _SortClassState extends State<SortClass> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: const Text(
                "Sort by",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            for (int i = 0; i < sort.length; i++)
              InkWell(
                onTap: () {
                  //  {'text': 'Top Rated'},
                  // {'text': 'New Arrival'},
                  // {'text': 'Oldest First'},
                  // {'text': 'Price - Low to high'},
                  // {'text': 'Price - High to low'}
                  setState(() {
                    selectedType = sort[i]['text'];
                  });
                  if (selectedType == sort[0]['text']) {
                    widget.searchProvider.sortBy = "review";
                    widget.searchProvider.orderBy = "DESC";
                  } else if (selectedType == sort[1]['text']) {
                    widget.searchProvider.sortBy = "id";
                    widget.searchProvider.orderBy = "DESC";
                  } else if (selectedType == sort[2]['text']) {
                    widget.searchProvider.sortBy = "id";
                    widget.searchProvider.orderBy = "ASC";
                  } else if (selectedType == sort[3]['text']) {
                    widget.searchProvider.sortBy = "price";
                    widget.searchProvider.orderBy = "ASC";
                  } else if (selectedType == sort[4]['text']) {
                    widget.searchProvider.sortBy = "price";
                    widget.searchProvider.orderBy = "DESC";
                  }
                  Routes.navigateToPreviousScreen(context);
                  widget.searchProvider.getProductsListNew(context, "25", "1");
                  //Price
// Low to high
// sort_by: price
// order_by: ASC

// High To Low
// sort_by: price
// order_by: DESC

// New Arrival
// sort_by: id
// order_by: DESC

// Oldest First
// sort_by: id
// order_by: ASC

// Top Rated
// sort_by: review
// order_by: DESC
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sort[i]['text'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: sort[i]['text'] == selectedType,
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

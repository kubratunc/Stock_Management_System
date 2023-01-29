import 'package:flutter/material.dart';

import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/custom_text_field.dart';
import '../../backend/theme.dart';
import '../../widgets/list_table.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/top_bar.dart';

List<Map<dynamic, dynamic>> listedSales = [];

class ListSalesScreen extends StatefulWidget {
  const ListSalesScreen({Key? key}) : super(key: key);

  @override
  State<ListSalesScreen> createState() => _ListSalesScreenState();
}

class _ListSalesScreenState extends State<ListSalesScreen> {
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    listedSales =
        DatabaseService().getSales(null, null, null, null, null, null);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          TopBar(
            widgets: [
              Expanded(
                flex: 1,
                child: MenuButton(
                  text: "Geri",
                  bgColor: YMColors().red,
                  textColor: YMColors().white,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  height: 50,
                ),
              ),
              Expanded(
                flex: 10,
                child: Text(
                  "Satışlar",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: YMColors().white,
                    fontSize: YMSizes().fontSizeLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SalesListSearchBar(notifyParent: refresh),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ListTable(
                        titlesBar: const SalesTitlesBar(),
                        items: [
                          for (int i = 0; i < listedSales.length; i++)
                            SalesListItem(
                              sale: listedSales[i],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SalesListSearchBar extends StatelessWidget {
  final Function() notifyParent;
  const SalesListSearchBar({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    TextEditingController dateController = TextEditingController();
    TextEditingController minAmountController = TextEditingController();
    TextEditingController maxAmountController = TextEditingController();
    TextEditingController minPriceController = TextEditingController();
    TextEditingController maxPriceController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: YMColors().lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: MenuButton(
                  text: "Temizle",
                  onPressed: () {
                    listedSales = DatabaseService()
                        .getSales(null, null, null, null, null, null);
                    notifyParent();
                  },
                  height: 50,
                  textColor: YMColors().white,
                  bgColor: YMColors().grey,
                ),
              ),
            ),
            ListTableVerticalSeperator(
              color: YMColors().grey,
              space: 10,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFieldComponent(
                  hintText: "Tarih",
                  height: 50,
                  controller: dateController,
                ),
              ),
            ),
            ListTableVerticalSeperator(
              color: YMColors().grey,
              space: 10,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Fiyat (En Az)",
                          height: 50,
                          controller: minPriceController,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Fiyat (En Fazla)",
                          height: 50,
                          controller: maxPriceController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTableVerticalSeperator(
              color: YMColors().grey,
              space: 10,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Adet (En Az)",
                          height: 50,
                          controller: minAmountController,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Adet (En Fazla)",
                          height: 50,
                          controller: maxAmountController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTableVerticalSeperator(
              color: YMColors().grey,
              space: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: MenuButton(
                  text: "Ara",
                  onPressed: () {
                    listedSales = DatabaseService().getSales(
                      null,
                      (dateController.text.isEmpty)
                          ? null
                          : dateController.text,
                      (minPriceController.text.isEmpty)
                          ? null
                          : double.parse(minPriceController.text),
                      (maxPriceController.text.isEmpty)
                          ? null
                          : double.parse(maxPriceController.text),
                      (minAmountController.text.isEmpty)
                          ? null
                          : int.parse(minAmountController.text),
                      (maxAmountController.text.isEmpty)
                          ? null
                          : int.parse(maxAmountController.text),
                    );
                    notifyParent();
                  },
                  height: 50,
                  textColor: YMColors().white,
                  bgColor: YMColors().red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesTitlesBar extends StatelessWidget {
  const SalesTitlesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: YMColors().lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
          child: Row(
            children: [
              const ListTableTitlesBarItem(text: "ID", flex: 1),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Ürün", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Adet", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Fiyat", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Tarih", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "İşlemler", flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesListItem extends StatelessWidget {
  final Map<dynamic, dynamic> sale;
  const SalesListItem({
    super.key,
    required this.sale,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: YMColors().white,
            ),
            child: Row(
              children: [
                ListTableItemPart(
                  value: (sale[Product().id] != null)
                      ? sale[Product().id].toString()
                      : null,
                  flex: 1,
                  textColor: YMColors().grey,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (sale[Product().name] != null)
                      ? sale[Product().name].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (sale[Product().brand] != null)
                      ? sale[Product().brand].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (sale[Product().category] != null)
                      ? sale[Product().category].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (sale[Product().color] != null)
                      ? sale[Product().color].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (sale[Product().size] != null)
                      ? sale[Product().size].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (sale[Product().sizeType] != null)
                      ? sale[Product().sizeType].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (sale[Product().price] != null)
                      ? sale[Product().price].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (sale[Product().amount] != null)
                      ? sale[Product().amount].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Düzenle",
                              bgColor: YMColors().grey,
                              textColor: YMColors().white,
                              onPressed: () {
                                editedItem = sale;
                                Navigator.pushReplacementNamed(
                                    context, '/edit_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Satın Alım",
                              bgColor: YMColors().blue,
                              textColor: YMColors().white,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/buy_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Satış Yap",
                              bgColor: YMColors().red,
                              textColor: YMColors().white,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/sell_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            height: 2,
            thickness: 2,
            color: YMColors().lightGrey,
          ),
        ],
      ),
    );
  }
}

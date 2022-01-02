import 'package:custom_widget/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final data = const [
    ProductCardData(
      image: NetworkImage(
          "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/ce415b10-a56c-4cc8-b8f7-47fa2283ba50/jordan-ma2-shoe-qw1Z6m.png"),
      name: "Jordan white shoes",
      location: "Jakarta",
      price: 300,
    ),
    ProductCardData(
      image: NetworkImage(
          "https://www.mytrendyphone.eu/images2/Orbit-Glasses-Bluetooth-Tracker-ORB523-Black-05062018-02-p.jpg"),
      name: "Orbit glasses bluetooth",
      location: "New York",
      price: 30,
    ),
    ProductCardData(
      image: NetworkImage(
          "https://cdn.lumen.id/commerce/digimap/file/99e99c97-fe01-4f22-85c1-af91cbd3a638/MacBook_Pro_13_SpGry_PDP_Image_Position-1_M1_Chip-medium.jpeg"),
      name: "Macbook air pro 2021",
      location: "Bali",
      price: 2400,
    ),
    ProductCardData(
      image: NetworkImage(
          "https://i.pinimg.com/564x/1b/a6/d4/1ba6d43b85fc9727b9535c8c35479fe1--small-computer-desks-home-office.jpg"),
      name: "Small computer desk home office",
      location: "Philadelphia",
      price: 200,
    )
  ];
  late bool isLoading;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadData,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // Build Design With BUILDER
                    _buildDesignProductWithBuilder(),

                    // Build Same Design Without BUILDER
                    _buildDesignProductWithoutBuilder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesignProductWithBuilder() {
    return (isLoading)
        ? const ProductCard.loadingBuilder(
            label: "Product",
            total: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          )
        : ProductCard.builder(
            label: "Product",
            shrinkWrap: true,
            data: data,
            onPressed: (index, data) {},
            physics: const NeverScrollableScrollPhysics(),
          );
  }

  Widget _buildDesignProductWithoutBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Product",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: isLoading ? 2 : data.length,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return (isLoading)
                ? const ProductCard.loading()
                : ProductCard(
                    data: data[index],
                    onPressed: () {},
                  );
          },
        ),
      ],
    );
  }
}

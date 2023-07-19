import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/data/providers/detail_provider.dart';
import 'package:restaurant_app/data/providers/restaurant_provider.dart';

class DetailResto extends StatefulWidget {
  static const routeName = '/detail_resto';
  final String id;
  const DetailResto({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailResto> createState() => _DetailRestoState();
}

class _DetailRestoState extends State<DetailResto> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   final id = ModalRoute.of(context)?.settings.arguments as String;
    //   context.read<DetailProvider>().getDetail(id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailProvider>(
        builder: (context, detailProvider, _) {
          if (detailProvider.state == DetailState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (detailProvider.state == DetailState.hasData) {
            return RestoInfo(detail: detailProvider.detail);
          } else if (detailProvider.state == DetailState.error) {
            return Center(
              child: Text(detailProvider.message),
            );
          } else {
            return const Text('data');
          }
        },
      ),
    );
  }
}

class RestoInfo extends StatelessWidget {
  final Restaurant detail;
  const RestoInfo({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text(
              'Detail Restaurant',
              style: Theme.of(context).textTheme.headline6,
            ),
            // FavoriteButton(),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              detail.pictureId.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              detail.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            // buildRating(context, detail)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              detail.city,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Description',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          detail.description,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // buildDrinks(context, resto),
                        SizedBox(
                          height: 10,
                        ),
                        // buildFoods(context, resto)
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

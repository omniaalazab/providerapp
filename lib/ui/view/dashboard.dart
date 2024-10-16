import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/controller/houseman/houseman_cubit.dart';
import 'package:providerapp/controller/houseman/houseman_state.dart';
import 'package:providerapp/controller/services/services_cubit.dart';
import 'package:providerapp/controller/services/services_status.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/view/home.dart';
import 'package:providerapp/ui/view/housman_all.dart';
import 'package:providerapp/ui/view/service_list.dart';
import 'package:providerapp/ui/view/services_details.dart';
import 'package:providerapp/ui/widget/custom_row_title.dart';
import 'package:providerapp/ui/widget/houseman_details.dart';
import 'package:providerapp/ui/widget/listtile_dashboard.dart';
import 'package:providerapp/ui/widget/rating_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<HousemanCubit>().getAllHouseman();
    context.read<ServicesCubit>().getAllservices();
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    final List<ChartData> chartData = [
      ChartData(S.of(context).Jan, 35),
      ChartData(S.of(context).Feb, 28),
      ChartData(S.of(context).Mar, 34),
      ChartData(S.of(context).Apr, 32),
      ChartData(S.of(context).May, 25),
      ChartData(S.of(context).june, 40),
      ChartData(S.of(context).July, 0),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Home,
            style: TextStyleHelper.textStylefontSize19
                .copyWith(color: Colors.white)),
        backgroundColor: ColorHelper.purple,
        actions: [
          Row(
            children: [
              InkWell(
                  onTap: () {},
                  child: const SizedBox(
                      height: 16,
                      width: 16,
                      child:
                          Image(image: AssetImage("assets/images/Chat.png")))),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '${S.of(context).CommisionType} : ${S.of(context).Company}',
                                style: TextStyleHelper.textStylefontSize15,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${S.of(context).MyCommision} :  20  ${S.of(context).Fixed}  ',
                                style: TextStyleHelper.textStylefontSize15,
                              ),
                            ],
                          )
                        ],
                      ),
                      CircleAvatar(
                        // backgroundColor: ColorHelper.purple,
                        child: Image.asset(
                          "assets/images/Discount.png",
                          //  color: ColorHelper.darkPurple,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTileDashBoard(
                          listTileTitle: "98",
                          listTileSubtitle: S.of(context).TotalService,
                          imagePathTrailing: "assets/images/Ticket.png",
                        ),
                      ),
                      Expanded(
                        child: ListTileDashBoard(
                          listTileTitle: "15",
                          listTileSubtitle: S.of(context).TotalService,
                          imagePathTrailing: "assets/images/Icon.png",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTileDashBoard(
                          listTileTitle: "30",
                          listTileSubtitle: S.of(context).Houseman,
                          imagePathTrailing: "assets/images/Profile1.png",
                        ),
                      ),
                      Expanded(
                        child: ListTileDashBoard(
                          listTileTitle: "45",
                          listTileSubtitle: S.of(context).TotalEarning,
                          imagePathTrailing: "assets/images/Discount.png",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: SfCartesianChart(
                  title: ChartTitle(
                    text: S.of(context).MonthlyRevenueUSD,
                    textStyle: TextStyleHelper.textStylefontSize18
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  primaryXAxis: const CategoryAxis(
                    interval: 1,
                  ),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomRowTitle(
                  title: S.of(context).Houseman,
                  title2: S.of(context).ViewAll,
                  onPressedFunction: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const AllHouseman()));
                  }),
              SizedBox(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<HousemanCubit, HousemanStatus>(
                    builder: (context, state) {
                      if (state is HousemanLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is Housemanloaded) {
                        final houseman = (state).housemanList;
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2.5 / 3,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: houseman.length - 2,
                            itemBuilder: (context, index) {
                              return HousemanDetails(
                                imagePath: houseman[index].imagePath,
                                textHouseMan: houseman[index].name,
                              );
                            });
                      } else if (state is HousemanFailure) {
                        return Center(child: Text(state.errorMessage));
                      } else {
                        return Container();
                      }
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
              CustomRowTitle(
                  title: S.of(context).Services,
                  title2: S.of(context).ViewAll,
                  onPressedFunction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AllServiceList()));
                  }),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 700,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<ServicesCubit, ServicesStatus>(
                  builder: (context, state) {
                    if (state is ServicesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is Servicesloaded) {
                      final services = (state).servicesList;
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // childAspectRatio: 1.0,
                            childAspectRatio: 2.5 / 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: services.length - 2,
                          itemBuilder: (context, index) {
                            return ServicesList(
                              onTapFunction: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ServicesDetails(
                                              index: index,
                                            )));
                              },
                              serviceImagePath:
                                  services[index].imagePathService,
                              price: services[index].price,
                              rating: services[index].houseman.rate,
                              serviceName: (currentLocale.languageCode == 'ar')
                                  ? services[index].nameServiceAr
                                  : services[index].nameServiceEn,
                              housemanName: services[index].houseman.name,
                              housemanImagePath:
                                  services[index].houseman.imagePath,
                            );
                          });
                    } else if (state is ServicesFailure) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class ServicesList extends StatelessWidget {
  ServicesList(
      {super.key,
      required this.serviceImagePath,
      required this.rating,
      required this.serviceName,
      required this.housemanName,
      required this.price,
      required this.housemanImagePath,
      required this.onTapFunction});

  final String serviceImagePath;
  final double rating;
  final String serviceName;
  final String housemanImagePath;
  final String housemanName;
  final double price;
  void Function()? onTapFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: InkWell(
        onTap: onTapFunction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    serviceImagePath,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 90,
                  bottom: 10,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorHelper.purple,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "$price",
                      style: TextStyleHelper.textStylefontSize14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CustomRatingBar(rating: rating),
                const SizedBox(width: 5),
                Text("$rating", style: TextStyleHelper.textStylefontSize14),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              serviceName,
              style: TextStyleHelper.textStylefontSize14,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    housemanImagePath,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    housemanName,
                    style: TextStyleHelper.textStylefontSize14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

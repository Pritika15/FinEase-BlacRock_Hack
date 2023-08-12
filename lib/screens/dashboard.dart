import 'package:fin_ease/screens/learn_more.dart';
import 'package:fin_ease/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../common/gap.dart';
import '../common/skeleton.dart';
import '../common/static.dart';
import '../models/target_model.dart';
import '../models/transaction_model.dart';
import '../repository/repository.dart';
import '../style/color.dart';
import '../style/typography.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isLoad = true;
  bool _isHidden = true;
  bool _isMore = true;
  bool isLoading = false;
  void isLoadingSuccess() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    isLoadingSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileSection(),
                const VerticalGap20(),
                balanceSection(context),

                const VerticalGap10(),
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        splashColor: buttonColor,
                        highlightColor: buttonColor,
                        focusColor: buttonColor,
                        child: Column(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: primaryColor,
                              ),
                              child: Icon(
                                Icons.money,
                                color: textColor,
                              ),
                            ),
                            const VerticalGap5(),
                            Expanded(
                              child: Text(
                                'Invest more',
                                style: poppinsCaption.copyWith(
                                  color: textColor.withOpacity(.75),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      !isLoading
                          ? InkWell(
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                var stockData = await fetchFinanceData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => FinanceDataPage(
                                            apiResponse: stockData))));
                                isLoading = false;
                              },
                              splashColor: buttonColor,
                              highlightColor: buttonColor,
                              focusColor: buttonColor,
                              child: Column(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: primaryColor,
                                    ),
                                    child: Icon(
                                      Icons.book,
                                      color: textColor,
                                    ),
                                  ),
                                  const VerticalGap5(),
                                  Expanded(
                                    child: Text(
                                      'Learn more',
                                      style: poppinsCaption.copyWith(
                                        color: textColor.withOpacity(.75),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : CircularProgressIndicator()
                    ],
                  ),
                ),
                // paymentSection(context),
                const VerticalGap20(),
                savingTargetSection(context),
                const VerticalGap20(),
                transactionSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Skeleton transactionSection(BuildContext context) {
    return Skeleton(
      duration: const Duration(seconds: 2),
      isLoading: _isLoad,
      themeMode: ThemeMode.dark,
      darkShimmerGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          secondaryColor,
          secondaryColor.withOpacity(.75),
          secondaryColor,
        ],
        tileMode: TileMode.repeated,
      ),
      skeleton: const ListViewSkeleton(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.receipt_rounded,
                    color: textColor,
                    size: 24,
                  ),
                  const HorizontalGap5(),
                  Text(
                    'Recent Activities in community',
                    style: poppinsH4.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.arrow_circle_right,
                  color: textColor,
                  size: 28,
                ),
              )
            ],
          ),
          const VerticalGap10(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 325,
            child: FutureBuilder<List<TransactionModel>>(
              future: Repository().getTransaction(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return ListView.separated(
                    separatorBuilder: (context, index) => const VerticalGap10(),
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: secondaryColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: primaryColor,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            data[index].photoUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: data[index].status == true
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        child: Icon(
                                          data[index].status == false
                                              ? Icons.arrow_upward_rounded
                                              : Icons.arrow_downward_rounded,
                                          color: textColor,
                                          size: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const HorizontalGap10(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].name,
                                      style: poppinsBody1.copyWith(
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      '${data[index].dateTransfer}, ${data[index].timeTransfer}',
                                      style: poppinsCaption.copyWith(
                                        color: textColor.withOpacity(.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  data[index].status == false
                                      ? '- ₹${data[index].totalMoney}'
                                      : '+ ₹${data[index].totalMoney}',
                                  style: poppinsH3.copyWith(
                                    color: data[index].status == false
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Skeleton savingTargetSection(BuildContext context) {
    return Skeleton(
      duration: const Duration(seconds: 2),
      isLoading: _isLoad,
      themeMode: ThemeMode.dark,
      darkShimmerGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          secondaryColor,
          secondaryColor.withOpacity(.75),
          secondaryColor,
        ],
        tileMode: TileMode.repeated,
      ),
      skeleton: const MediumSkeleton(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.cloud_circle_rounded,
                      color: textColor,
                      size: 24,
                    ),
                    const HorizontalGap5(),
                    Text(
                      'Saving Targets & Goals',
                      style: poppinsH4.copyWith(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.arrow_circle_right,
                    color: textColor,
                    size: 28,
                  ),
                )
              ],
            ),
            const VerticalGap10(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 140,
              child: FutureBuilder<List<SavingTargetModel>>(
                future: Repository().getSavingTarget(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const HorizontalGap10(),
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        final formatter = NumberFormat('#,###');
                        final savingValue =
                            formatter.format(data[index].hasSaving);
                        final targetValue =
                            formatter.format(data[index].totalSaving);
                        return Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: secondaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data[index].purposeName,
                                    style: poppinsBody1.copyWith(
                                      color: textColor.withOpacity(.75),
                                    ),
                                  ),
                                  const VerticalGap5(),
                                  Text(
                                    '₹$savingValue',
                                    style: poppinsBody1.copyWith(
                                      fontSize: 28,
                                      color: buttonColor,
                                    ),
                                  ),
                                  const VerticalGap5(),
                                  Text(
                                    '₹$targetValue left in ${data[index].monthDuration} months',
                                    style: poppinsBody2.copyWith(
                                      color: textColor.withOpacity(.5),
                                    ),
                                  ),
                                ],
                              ),
                              CircularPercentIndicator(
                                radius: 40,
                                lineWidth: 6,
                                percent: data[index].hasSaving /
                                    data[index].totalSaving,
                                center: Text(
                                  '${(data[index].hasSaving / data[index].totalSaving * 100).toStringAsFixed(0)}%',
                                  style: poppinsBody1.copyWith(
                                    color: textColor,
                                  ),
                                ),
                                backgroundColor: textColor.withOpacity(.1),
                                progressColor: buttonColor,
                                animation: true,
                                animationDuration: 2000,
                                animateFromLastPercent: true,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: buttonColor,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Skeleton paymentSection(BuildContext context) {
    return Skeleton(
      duration: const Duration(seconds: 2),
      isLoading: _isLoad,
      themeMode: ThemeMode.dark,
      darkShimmerGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          secondaryColor,
          secondaryColor.withOpacity(.75),
          secondaryColor,
        ],
        tileMode: TileMode.repeated,
      ),
      skeleton: const SmallSkeleton(),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: secondaryColor,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: InkWell(
            onTap: () {},
            splashColor: buttonColor,
            highlightColor: buttonColor,
            focusColor: buttonColor,
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: primaryColor,
                  ),
                  child: Icon(
                    Icons.money,
                    color: textColor,
                  ),
                ),
                const VerticalGap5(),
                Expanded(
                  child: Text(
                    'Invest more',
                    style: poppinsCaption.copyWith(
                      color: textColor.withOpacity(.75),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Skeleton balanceSection(BuildContext context) {
    return Skeleton(
      duration: const Duration(seconds: 2),
      isLoading: _isLoad,
      themeMode: ThemeMode.dark,
      darkShimmerGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          secondaryColor,
          secondaryColor.withOpacity(.75),
          secondaryColor,
        ],
        tileMode: TileMode.repeated,
      ),
      skeleton: const MediumSkeleton(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: secondaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Balance',
                  style: poppinsBody2.copyWith(
                    color: textColor.withOpacity(.75),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isMore = !_isMore;
                    });
                  },
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: textColor.withOpacity(.75),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  _isHidden ? '₹550,752' : '---------',
                  style: poppinsH1.copyWith(
                    color: buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const HorizontalGap5(),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isHidden = !_isHidden;
                    });
                  },
                  child: Icon(
                    _isHidden
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: textColor.withOpacity(.75),
                    size: 20,
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: _isMore
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: const SizedBox(),
              secondChild: Column(
                children: [
                  const VerticalGap10(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: textColor.withOpacity(.25),
                  ),
                  const VerticalGap10(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Investment',
                        style: poppinsH5.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                      Text(
                        '₹332000',
                        style: poppinsH5.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                    ],
                  ),
                  const VerticalGap5(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage(imgBibit),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const HorizontalGap5(),
                          Text(
                            'Stocks',
                            style: poppinsBody2.copyWith(
                              color: textColor.withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₹3000',
                        style: poppinsBody2.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage(imgBibit),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const HorizontalGap5(),
                          Text(
                            'Mutual Funds',
                            style: poppinsBody2.copyWith(
                              color: textColor.withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₹8000',
                        style: poppinsBody2.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage(imgBibit),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const HorizontalGap5(),
                          Text(
                            'Bonds',
                            style: poppinsBody2.copyWith(
                              color: textColor.withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₹10000',
                        style: poppinsBody2.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage(imgBibit),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const HorizontalGap5(),
                          Text(
                            'Gold',
                            style: poppinsBody2.copyWith(
                              color: textColor.withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₹20000',
                        style: poppinsBody2.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                    ],
                  ),
                  const VerticalGap10(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cash Money',
                        style: poppinsH5.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                      Text(
                        '₹218752',
                        style: poppinsH5.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage(imgBibit),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const HorizontalGap5(),
                          Text(
                            'Cash',
                            style: poppinsBody2.copyWith(
                              color: textColor.withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₹218752',
                        style: poppinsBody2.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                    ],
                  ),
                  const VerticalGap5(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Skeleton profileSection() {
    return Skeleton(
      duration: const Duration(seconds: 2),
      isLoading: _isLoad,
      themeMode: ThemeMode.dark,
      darkShimmerGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          secondaryColor,
          secondaryColor.withOpacity(.75),
          secondaryColor,
        ],
        tileMode: TileMode.repeated,
      ),
      skeleton: const SmallSkeleton(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Evening!',
                style: poppinsBody2.copyWith(
                  color: textColor.withOpacity(.75),
                ),
              ),
              Text(
                'Rishabh',
                style: poppinsBody1.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                image: const DecorationImage(
                  image: AssetImage(imgProfile),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
    );
  }
}

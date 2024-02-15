import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtils.SecondaryGrayExtraLight,
      appBar: AppBar(
        backgroundColor: AppUtils.PrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Clients",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.white)),
            Icon(
              Icons.notifications_outlined,
              color: AppUtils.White,
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              clientCard('PHS', 'Glenn Fritz', 'email@user.com', '12/02/2024'),
              clientCard('CHS', 'Agbor', 'email@user.com', '12/02/2024'),
              clientCard('Regional Hospital', 'Dr. Gareth', 'email@user.com',
                  '12/02/2024'),
              clientCard(
                  'Solidary Clinic', 'Grey', 'email@user.com', '12/02/2024'),
              clientCard('Diligent Clinic', 'Wenworth', 'email@user.com',
                  '12/02/2024'),
              clientCard('Acha Annex', 'Betty', 'email@user.com', '12/02/2024'),
              clientCard('Kawa Hospital', 'Jessica', 'email@user.com',
                  '12/02/2024'),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget clientCard(
      String clientName, String username, String email, String date) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
          decoration: BoxDecoration(
              color: AppUtils.White,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 211, 211, 211),
                    blurRadius: 10,
                    spreadRadius: 0.5)
              ]),
          child: Row(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/img-requests-recieved-request1 (1).png'),
                      fit: BoxFit.fill),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clientName,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            // fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    // const SizedBox(
                    //   height: ,
                    // ),
                    Text(
                      '$username ($email)',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 11,
                            color: AppUtils.DarkColor.withOpacity(0.7),
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Date created: $date',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                            fontSize: 11,
                            color: AppUtils.DarkColor.withOpacity(0.9),
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                height: 35,
                width: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppUtils.SecondaryGray.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/screens/detail_screens/invoice_detail.dart';
import 'package:emoneytransfer/screens/widgets/notification_icon.dart';

class ClientInvoices extends StatefulWidget {
  const ClientInvoices({super.key});

  @override
  State<ClientInvoices> createState() => _ClientInvoicesState();
}

class _ClientInvoicesState extends State<ClientInvoices> {
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
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left,
                    color: AppUtils.White,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "Client Invoices",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
            NotificationIcon(context: context)
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        // margin: const EdgeInsets.only(bottom: ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              invoiceCard(context, 'Paracetamol', '3000', 'Success',
                  '12 cards', '12/02/2024'),
              invoiceCard(context, 'Cotrim', '5000', 'Failed', '10 cards',
                  '12/02/2024'),
              invoiceCard(context, 'Mabendazole', '10000', 'Success',
                  '20 cards', '12/02/2024'),
              invoiceCard(context, 'Cold Cap', '6000', 'Success',
                  '50 cards', '12/02/2024'),
              invoiceCard(context, 'Paracetamol', '3000', 'Failed',
                  '12 cards', '12/02/2024'),
              invoiceCard(context, 'Cold Cap', '6000', 'Success',
                  '50 cards', '12/02/2024'),
              invoiceCard(context, 'Paracetamol', '3000', 'Failed',
                  '12 cards', '12/02/2024'),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget invoiceCard(BuildContext context, String productName, String price, String status,
      String quantity, String date) {
    Color statusColor() {
      if (status == 'Success') {
        return AppUtils.GreenColor;
      } else {
        return AppUtils.RedColor;
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InvoiceDetails(),
          ),
        );
      },
      child: Container(
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
              height: 60,
              width: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/img-requests-recieved-request1 (1).png'),
                    fit: BoxFit.fill),
                // shape: BoxShape.circle,
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
                    productName,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          // fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'XAF $price ($quantity)',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 11,
                          color: AppUtils.DarkColor.withOpacity(0.7),
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // spacing: 8,
                    // runAlignment: WrapAlignment.center,
                    children: [
                      IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.8,
                                color: AppUtils.DarkColor.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: statusColor(),
                                size: 8,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                status,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 11,
                                      color:
                                          AppUtils.DarkColor.withOpacity(0.9),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IntrinsicWidth(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: AppUtils.SecondaryGray,
                            size: 5,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            date,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  fontSize: 11,
                                  color: AppUtils.DarkColor.withOpacity(0.9),
                                ),
                          ),
                        ],
                      )),
                    ],
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:elcrypto/helper/app_utils.dart';

Widget transactionCard(BuildContext context, String transactionType,
    String price, String status, String date) {
  return Container(
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
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionType,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      // fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'XAF $price ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
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
                            color: transactionStatusColor(status),
                            size: 8,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            status,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 11,
                                  color: AppUtils.DarkColor.withOpacity(0.9),
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
  );
}

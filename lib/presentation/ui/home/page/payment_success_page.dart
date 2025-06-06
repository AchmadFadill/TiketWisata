import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/core.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Payment Reciept',
          style: TextStyle(color: AppColors.white),
          ),
          leading: GestureDetector(
            onTap: ()=> context.pop(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.back.image(color: AppColors.white),  
            )
          ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.receiptCard.provider(),
                alignment: Alignment.topCenter,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Column(
                children: [
                  const Text(
                    'PAYMENT RECEIPT',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SpaceHeight(16.0),
                  QrImageView(
                    data:'payment-receipt', 
                    version: QrVersions.auto,

                  ),
                  const SpaceHeight(16.0),
                  const Text('Scan QR Code to Confirm Payment'),
                  const SpaceHeight(16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tagihan'),
                      Text(120000.currencyFormatRp),
                    ],
                  ),
                  const SpaceHeight(40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Metode Pembayaran'),
                      Text('QRIS')
                    ],
                  ),
                  const SpaceHeight(8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Waktu'),
                      Text(DateTime.now().toFormattedDate()),
                    ],
                  ),
                  const SpaceHeight(8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status'),
                      Text('Lunas')
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 20),
        child: Button.filled(
          onPressed:(){} ,
          label: 'Cetak Transaksi',
          borderRadius: 10.0,
        ),
      ),
    );
  }
}
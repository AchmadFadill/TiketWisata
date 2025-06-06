import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class DeleteTicketDialog extends StatelessWidget {
  const DeleteTicketDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize:MainAxisSize.min ,
        children: [
          Text(
            'Hapus Data',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
                    const SpaceHeight(12.0),
          Text(
            'Yakin Mau Menghapus data Ini?',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17.0,
              color: AppColors.black,
            ),
          ),
          const SpaceHeight(20.0),
          Row(
            children: [
              Flexible(
                child: Button.filled(
                  onPressed: () => context.pop(), 
                  label: 'Batalkan',
                  borderRadius: 8.0,
                  color: AppColors.buttonCancel,
                  textColor: AppColors.grey,
                  height: 44.0,
                  fontSize: 14,
                ),
                ),
                const SpaceWidth(12.0),
                Flexible(
                child: Button.filled(
                  onPressed: () => context.pop(), 
                  label: 'Hapus',
                  borderRadius: 8.0,
                  height: 44.0,
                  fontSize: 14,
                ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
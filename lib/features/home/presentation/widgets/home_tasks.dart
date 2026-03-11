import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = 20.0;
    final items = [
      TaskItem(
        name: 'Tasks',
        icon: Icon(Icons.task_alt, size: iconSize),
      ),
      TaskItem(
        name: 'Giveaway',
        icon: Icon(Icons.redeem_outlined, size: iconSize),
        onPressed: (context) => context.pushNamed(RNames.giveaway),
      ),
      TaskItem(
        name: 'Leaderboard',
        icon: Icon(Icons.account_balance_wallet_outlined, size: iconSize),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ).copyWith(bottom: AppSpacing.sm),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 15,
        childAspectRatio: 2.5,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final task = items[index];
        return TaskTile(task: task, index: index);
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.index});
  final TaskItem task;
  final int index;

  @override
  Widget build(BuildContext context) {
    Color? getColor(int index) {
      switch (index) {
        case 0:
          return const Color.fromARGB(255, 243, 249, 243);

        default:
          return AppColors.lightBlue.withValues(alpha: 0.15);
      }
    }

    return Tappable.faded(
      onTap: () => task.onPressed?.call(context),
      child: AnimatedContainer(
        duration: 200.ms,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: getColor(index),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.brightGrey,
          //     blurRadius: 2,
          //     offset: Offset(2, 1),
          //     spreadRadius: 2,
          //     blurStyle: BlurStyle.outer,
          //   ),
          // ],
        ),

        child: Row(
          spacing: AppSpacing.md,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            task.icon,
            Flexible(
              child: Text(
                task.name,
                maxLines: 1,
                // overflow: TextOverflow.ellipsis,
                style: poppinsTextStyle(
                  fontSize: 12,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem {
  final String name;
  final Widget icon;
  final void Function(BuildContext context)? onPressed;

  const TaskItem({required this.name, required this.icon, this.onPressed});
}

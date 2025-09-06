part of 'cooldown_cubit.dart';
@immutable
class CooldownState extends Equatable {
  final Map<String, Duration> cooldowns;
  const CooldownState(this.cooldowns);
  
  @override
  List<Object?> get props => [cooldowns];
}

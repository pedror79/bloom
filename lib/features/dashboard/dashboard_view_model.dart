import '../../core/engine/projection_engine.dart';
import '../../core/mappers/user_profile_mapper.dart';
import '../../core/models/projection_result.dart';
import '../../models/user_profile.dart';

class DashboardViewModel {
  final ProjectionResult projection;

  const DashboardViewModel._({
    required this.projection,
  });

  factory DashboardViewModel.fromProfile(
    UserProfile profile, {
    ProjectionEngine engine = const ProjectionEngine(),
  }) {
    final user = UserProfileMapper.toBloomUser(profile);

    return DashboardViewModel._(
      projection: engine.calculate(user),
    );
  }

  int get targetAge => projection.targetAge;

  int get targetYear => projection.targetYear;

  int get yearsRemaining => projection.yearsRemaining;

  double get progress => projection.progress;

  double get fireNumber => projection.fireNumber;

  double get projectedPortfolio => projection.projectedPortfolio;

  double get requiredMonthlyInvestment =>
      projection.requiredMonthlyInvestment;

  bool get onTrack => projection.onTrack;
}
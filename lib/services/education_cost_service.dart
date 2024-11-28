import '../models/education_cost.dart';

class EducationCostService {
  static Future<List<EducationCost>> getEducationCosts() async {
    
    return [
      EducationCost(
        educationLevel: 'SD',
        averageCost: 1500000,
        currency: 'IDR',
        uniformCost: 300000,
        bookCost: 500000,
        extracurricularCost: 200000,
      ),
      EducationCost(
        educationLevel: 'SMP',
        averageCost: 2000000,
        currency: 'IDR',
        uniformCost: 400000,
        bookCost: 600000,
        extracurricularCost: 300000,
      ),
      EducationCost(
        educationLevel: 'SMA',
        averageCost: 3000000,
        currency: 'IDR',
        uniformCost: 500000,
        bookCost: 800000,
        extracurricularCost: 400000,
      ),
    ];
  }
}

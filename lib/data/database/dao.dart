import 'package:elmuslim_app/domain/models/adhkar/custom_adhkar_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class CustomAdhkarDao {
  @Query("SELECT * FROM CustomAdhkarEntity")
  Future<List<CustomAdhkarEntity>> getAllCustomAdhkar();

  @Query("SELECT * FROM CustomAdhkarEntity WHERE id = :id")
  Future<CustomAdhkarEntity?> getDhikrById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDhikr(CustomAdhkarEntity dhikr);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateDhikr(CustomAdhkarEntity dhikr);

  @Query("DELETE FROM CustomAdhkarEntity WHERE id = :id")
  Future<void> delDhikrById(int id);

  @delete
  Future<void> deleteAll(List<CustomAdhkarEntity> list);
}
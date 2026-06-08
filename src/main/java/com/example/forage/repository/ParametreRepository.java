package com.example.forage.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.forage.models.Parametre;

@Repository
public interface ParametreRepository extends JpaRepository<Parametre, Integer> {
    List<Parametre> OrderByStatus1();
    @Query("SELECT p FROM Parametre p ORDER BY p.status1.id, p.status2.id, p.duree")
    List<Parametre> findAllSortedByStatusAndDuree();
}

package com.example.forage.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.forage.models.Parametre;

@Repository
public interface ParametreRepository extends JpaRepository<Parametre, Integer> {
    List<Parametre> OrderByStatus1();
}

package com.example.forage.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.forage.models.Parametre;

@Repository
public interface ParametreRepository extends JpaRepository<Parametre, Integer> {
    
}

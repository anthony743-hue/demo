package com.example.forage.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.forage.models.Devis;

@Repository
public interface DevisRepository extends JpaRepository<Devis,Long> {
    
}

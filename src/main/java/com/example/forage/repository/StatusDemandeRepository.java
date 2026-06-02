package com.example.forage.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.forage.models.Demande;
import com.example.forage.models.StatusDemande;

@Repository
public interface StatusDemandeRepository extends JpaRepository<StatusDemande, Integer> {
    List<StatusDemande> findByDemande(Demande demande);
}

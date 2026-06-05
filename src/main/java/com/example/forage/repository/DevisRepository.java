package com.example.forage.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.forage.models.Devis;
import java.util.Optional;


@Repository
public interface DevisRepository extends JpaRepository<Devis,Long> {
    Optional<Devis> findById(Long id);
}

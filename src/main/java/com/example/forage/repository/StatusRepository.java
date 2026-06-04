package com.example.forage.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.forage.models.Status;
import java.util.List;


@Repository
public interface StatusRepository extends JpaRepository<Status, Integer> {
    List<Status> findByDesignationContaining(String designation);

    Status findDistinctBySigleLike(String sigle);

    List<Status> findByDesignationNotContaining(String designation);
}

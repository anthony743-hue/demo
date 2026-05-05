package com.example.forage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.forage.models.Demande;
import com.example.forage.repository.DemandeRepository;

@Service
public class DemandeService {
    @Autowired
    private DemandeRepository repo;

    public void insert(Demande d){
        repo.save(d);
    }
}

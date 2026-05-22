package com.example.forage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.forage.models.StatusDemande;
import com.example.forage.repository.StatusDemandeRepository;

@Service
public class StatusDemandeService {
    @Autowired
    private StatusDemandeRepository repo;

    public void insert(StatusDemande std){
        repo.save(std);
    }

    public List<StatusDemande> getByDemande(String ref){
        return repo.findByDemande(ref);
    }

    public StatusDemande findById(Integer id){
        return repo.findById(id).orElseThrow();
    }
}

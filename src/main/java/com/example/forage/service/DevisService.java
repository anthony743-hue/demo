package com.example.forage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.example.forage.models.Devis;
import com.example.forage.models.StatusDemande;
import com.example.forage.repository.DevisRepository;
import java.util.List;

@Service
public class DevisService {
    @Autowired
    private DevisRepository repo;

    @Transactional(propagation = Propagation.REQUIRED)
    public void insert(Devis devis, StatusDemande std, StatusDemandeService statusDemandeService, DemandeService demandeService, StatusService statusService){
        statusDemandeService.insert(std, demandeService, statusService);
        repo.save(devis);
    }

    public List<Devis> findAll(){
        return repo.findAll();
    }

    public Devis findById(Long id){
        return repo.findById(id).get();
    }
}

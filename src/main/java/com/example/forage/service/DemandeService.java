package com.example.forage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.forage.models.Demande;
import com.example.forage.repository.DemandeRepository;

@Service
public class DemandeService {
    @Autowired
    private DemandeRepository repo;

    @Transactional
    public void insert(Demande d){
        repo.save(d);
    }

    public void remove(Integer id){
        repo.deleteById(id);
    }

    @Transactional
    public void update(Demande demande){
        Demande newDemande = findById(demande.getId());
        newDemande.setCommune(demande.getCommune());
        newDemande.setClient(demande.getClient());
        newDemande.setReference(demande.getReference());
        repo.save(newDemande);
    }

    public List<Demande> getAll(){
        return repo.findAll();
    }

    public Demande findById(Integer id){
        return repo.findById(id).orElseThrow();
    }

    public Demande findByReference(String reference) throws Exception {
        return repo.findByReference(reference).get();
    }
}

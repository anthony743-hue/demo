package com.example.forage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.forage.models.Devis;
import com.example.forage.repository.DevisRepository;
import java.util.List;

@Service
public class DevisService {
    @Autowired
    private DevisRepository repo;

    public void insert(Devis devis){
        repo.save(devis);
    }

    public List<Devis> findAll(){
        return repo.findAll();
    }
}

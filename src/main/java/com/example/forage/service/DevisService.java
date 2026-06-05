package com.example.forage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.forage.models.Devis;
import com.example.forage.repository.DevisRepository;
import java.util.List;

@Service
public class DevisService {
    @Autowired
    private DevisRepository repo;

    @Transactional
    public void insert(Devis devis){
        repo.save(devis);
    }

    public List<Devis> findAll(){
        return repo.findAll();
    }

    public Devis findById(Long id){
        return repo.findById(id).orElseThrow();
    }
}

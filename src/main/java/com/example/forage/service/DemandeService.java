package com.example.forage.service;

import java.util.List;

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

    public void remove(Integer id){
        repo.deleteById(id);
    }

    public List<Demande> getAll(){
        return repo.findAll();
    }

    public Demande findById(Integer id){
        return repo.findById(id).orElseThrow();
    }
}

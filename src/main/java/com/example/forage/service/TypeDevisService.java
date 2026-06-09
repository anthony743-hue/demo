package com.example.forage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.forage.models.TypeDevis;
import com.example.forage.repository.TypeDevisRepository;

@Service
public class TypeDevisService {
    @Autowired
    private TypeDevisRepository repo;

    public List<TypeDevis> findAll(){
        return repo.findAll();
    }

    public TypeDevis findById(TypeDevis d){
        return repo.findById(d.getId()).get();
    }
}

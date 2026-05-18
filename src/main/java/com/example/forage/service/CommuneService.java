package com.example.forage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.forage.repository.CommuneRepository;
import com.example.forage.models.Commune;

@Service
public class CommuneService {
    @Autowired
    private CommuneRepository repo;

    public List<Commune> getAll(){
        return repo.findAll();
    }
}

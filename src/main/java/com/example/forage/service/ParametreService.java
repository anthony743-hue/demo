package com.example.forage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.forage.models.Parametre;
import com.example.forage.repository.ParametreRepository;

@Service
public class ParametreService {
    @Autowired
    private ParametreRepository repo;

    public List<Parametre> getAll(){
        return repo.findAll();
    }
}

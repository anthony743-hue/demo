package com.example.forage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.forage.models.Client;
import com.example.forage.repository.ClientRepository;

@Service
public class ClientService {
    @Autowired
    private ClientRepository repo;
    public List<Client> findAll(){
        return repo.findAll();
    }
}

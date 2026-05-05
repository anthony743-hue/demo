package com.example.forage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.forage.models.Status;
import com.example.forage.repository.StatusRepository;

@Service
public class StatusService {
    @Autowired
    private StatusRepository repo;

    public List<Status> findAll(){
        return repo.findAll();
    }
}

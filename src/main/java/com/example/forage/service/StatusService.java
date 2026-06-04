package com.example.forage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public Map<Integer, Status> findAsMap(){
        List<Status> ls = findAll();
        Map<Integer, Status> map = new HashMap<>();
        for(Status s : ls){
            map.put(s.getId(), s);
        }
        return map;
    }

    public List<Status> findByDesignationContaining(String s){
        return repo.findByDesignationContaining(s);
    }

    public Status findDistinctBySigleLike(String s){
        return repo.findDistinctBySigleLike(s);
    }

    public List<Status> findByDesignationNotContaining(String s){
        return repo.findByDesignationNotContaining(s);
    }
}

package com.example.forage.service;

import java.util.List;
import java.util.Vector;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.example.forage.models.Demande;
import com.example.forage.models.StatusDemande;
import com.example.forage.repository.StatusDemandeRepository;

import jakarta.transaction.Transactional;

@Service
public class StatusDemandeService {
    @Autowired
    private StatusDemandeRepository repo;

    @Transactional
    public void insert(StatusDemande std){
        repo.save(std);
    }

    public void insert(StatusDemande std, Demande d) throws Exception {
        StatusDemande stdBeforeUpdate = new Vector<>(getByDemande(d)).lastElement();
        if (d.getStatus().getId() >= std.getStatus().getId()) {
            throw new Excepti
        }
        if (std.getDaty().isBefore(stdBeforeUpdate.getDaty()) || std.getDaty().isEqual(stdBeforeUpdate.getDaty())) {
            return ResponseEntity.status(HttpStatus.ACCEPTED)
                    .body("Envoie impossible, veuillez definir une date anterieur au dernier status : "
                            + stdBeforeUpdate.getDaty().toString());
        }
        
    }

    public List<StatusDemande> getByDemande(Demande d){
        return repo.findByDemande(d);
    }

    public StatusDemande findById(Integer id){
        return repo.findById(id).orElseThrow();
    }
}

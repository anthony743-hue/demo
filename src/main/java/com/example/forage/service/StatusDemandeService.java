package com.example.forage.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.example.forage.models.Demande;
import com.example.forage.models.Parametre;
import com.example.forage.models.Status;
import com.example.forage.models.StatusDemande;
import com.example.forage.repository.StatusDemandeRepository;

@Service
public class StatusDemandeService {
    @Autowired
    private StatusDemandeRepository repo;

    @Transactional
    public void save(StatusDemande std) {
        repo.save(std);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void insert(StatusDemande std, DemandeService demandeService) {
        Demande d = demandeService.findById(std.getDemande().getId());

        StatusDemande stdBeforeUpdate = getLast(d);
        Status st = std.getStatus();

        if (d.getStatus().getId() >= st.getId()) {
            throw new RuntimeException(
                    "Envoie impossible, veuillez entrer definir un Statut Superieur a la precedente");
        }
        if (stdBeforeUpdate != null) {
            if (std.getDaty().isBefore(stdBeforeUpdate.getDaty()) || std.getDaty().isEqual(stdBeforeUpdate.getDaty())) {
                throw new RuntimeException("Envoie impossible, veuillez definir une date anterieur au dernier status : "
                        + stdBeforeUpdate.getDaty().toString());
            }

            if(st.getDesignation().toLowerCase().matches("devis\\s+forage\\s+.*")){
                String[] part = st.getDesignation().split(" ");
                if(part[part.length - 1] != null){
                    
                }    
            }
            
            Long duration = stdBeforeUpdate.getDiff(std);
            System.out.println("Duration : " + duration);
            std.setDt(duration);
        }

        d.setStatus(std.getStatus());
        std.setDemande(d);

        demandeService.insert(d);
        save(std);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void update(StatusDemande std) {
        List<StatusDemande> ls = getByDemande(std.getDemande());
        StatusDemande stdBeforeUpdate = findById(std.getId());
        if (stdBeforeUpdate.equals(std)) {
            throw new RuntimeException("Mise a jour invalide, veuillez modifier certaines informations");
        }

        if (stdBeforeUpdate.getDaty() != null && std.getDaty() != null &&
                !stdBeforeUpdate.getDaty().isEqual(std.getDaty())) {
            int idx = 0;
            StatusDemande nextStd = null, previousStd = null;
            for (int i = 0; i < ls.size(); i++) {
                if (ls.get(i).getId() == std.getId()) {
                    idx = i;
                    break;
                }
            }
            Long duration = 0L;
            if (idx > 0) {
                previousStd = ls.get(idx - 1);
                if (previousStd.getDaty() != null && previousStd.getDaty().isBefore(std.getDaty())) {
                    duration = previousStd.getDiff(std);
                    std.setDt(duration);
                }
            }
            if (idx < ls.size() - 1) {
                nextStd = ls.get(idx + 1);
                if (nextStd.getDaty() != null && nextStd.getDaty().isAfter(std.getDaty())) {
                    duration = std.getDiff(nextStd);
                    nextStd.setDt(duration);
                    save(nextStd);
                }
            }
            System.out.println("Duration : " + duration);
        }
        save(std);
    }

    public List<StatusDemande> getByDemande(Demande d) {
        return repo.findByDemande(d);
    }

    public StatusDemande findById(Integer id) {
        return repo.findById(id).orElseThrow();
    }

    public StatusDemande getLast(Demande d) {
        return new Vector<>(getByDemande(d)).lastElement();
    }

    public List<Parametre> getAlertByRef(List<StatusDemande> listStatus, List<Parametre> listParametres,
            List<Integer> keep, int targetId) {
        List<Parametre> retour = new ArrayList<>();
        if (keep == null) {
            keep = new ArrayList<>();
        }

        StatusDemande std = null, previousStd = null, nextStd = null;
        int i = 0, j1 = 0, j2 = 0, j = 0, idx = -1;
        for (i = 0; i < listStatus.size(); i++) {
            std = listStatus.get(i);
            if (std.getDemande() != null && std.getDemande().getId() == targetId) {
                keep.add(i);
            }
        }

        Parametre temp = null, t = null;
        Status st1 = null, st2 = null;
        int n = keep.size();
        Long s = 0L;
        for (i = 0; i < listParametres.size(); i++) {
            temp = listParametres.get(i);
            st1 = temp.getStatus1();
            st2 = temp.getStatus2();
            j1 = 0;
            j2 = 1;

            while (j2 < n && j1 < j2) {
                previousStd = listStatus.get(keep.get(j1));
                nextStd = listStatus.get(keep.get(j2));

                if (!previousStd.getStatus().equals(st1)) {
                    j1++;
                }
                if (!nextStd.getStatus().equals(st2)) {
                    j2++;
                }
                if (previousStd.getStatus().equals(st1) && nextStd.getStatus().equals(st2)) {
                    break;
                }
            }

            if (j2 < n) {
                s = 0L;
                for (j = j1; j <= j2; j++) {
                    std = listStatus.get(keep.get(j));
                    if(std.getDt() != null){
                        s += std.getDt();
                    }
                }

                for (j = 0; j < retour.size(); j++) {
                    t = retour.get(j);
                    if (t.getStatus1().equals(st1) && t.getStatus2().equals(st2)) {
                        idx = j;
                    }
                }

                if (s > temp.getDuree()) {
                    if (idx != -1) {
                        t = retour.get(idx);
                        if(s > t.getDuree()){
                            t.setAlerte(temp.getAlerte());
                            t.setDuree(s);
                        }
                    } else {
                        t = new Parametre();
                        t.setAlerte(temp.getAlerte());
                        t.setDuree(s);
                        t.setStatus1(st1);
                        t.setStatus2(st2);
                        retour.add(t);
                    }
                }
                idx = -1;
            }
        }
        return retour;
    }

    public List<Parametre> getAlertList(DemandeService demandeService, ParametreService parametreService) {
        List<Parametre> ls = new ArrayList<>(), temp = null;
        List<Demande> listeDemandes = demandeService.getAll();
        List<Parametre> listParametres = parametreService.getAll();
        List<StatusDemande> listStatus = getAll();
        List<Integer> keep = null;

        for (Demande d : listeDemandes) {
            temp = getAlertByRef(listStatus, listParametres, keep, d.getId());
            ls.addAll(temp);
            keep = null;
        }

        return ls;
    }

    public List<StatusDemande> getAll() {
        return repo.findAll();
    }
}

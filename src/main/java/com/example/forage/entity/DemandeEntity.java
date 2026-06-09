package com.example.forage.entity;


import java.util.List;

import com.example.forage.models.Demande;
import com.example.forage.models.Parametre;

public class DemandeEntity{
    private Demande demande;
    public Demande getDemande() {
        return demande;
    }
    private Long totalTravaille = 0L;
    private List<Parametre> listeAlerte;
    public List<Parametre> getListeAlerte() {
        return listeAlerte;
    }
    public void setListeAlerte(List<Parametre> listeAlerte) {
        this.listeAlerte = listeAlerte;
    }
    public DemandeEntity(Demande d) throws Exception {
        setDemande(d);
    }
    public void setDemande(Demande dmd) throws Exception {
        if(dmd == null){
            throw new Exception("La demande doit etre initialise");
        }
        this.demande = dmd;
    }
    public Long getTotalTravaille() {
        return totalTravaille;
    }
    public void setTotalTravaille(Long totalTravaille) {
        this.totalTravaille = totalTravaille;
    }
}
package com.example.forage.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;

@Entity
@SequenceGenerator(name = "devis_detail_seq", sequenceName = "devis_detail_SEQ")
public class DevisDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "devis_detail_seq")
    private Long id;

    @Column(nullable = false, length = 30)
    private String libelle;
    private Long qte;
    private Long Pu;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idDevis", nullable = false, referencedColumnName = "id")
    private Devis devis;

    public Devis getDevis() {
        return devis;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setDevis(Devis devis) {
        this.devis = devis;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public Long getQte() {
        return qte;
    }

    public void setQte(Long qte) throws Exception {
        if (qte <= 0) {
            throw new Exception("Veuillez donner une valeur positive pour la quantite");
        }
        this.qte = qte;
    }

    public Long getPu() {
        return Pu;
    }

    public void setPu(Long pu) throws Exception {
        if (pu <= 0) {
            throw new Exception("Veuillez donner une valeur positive pour le prix unitaire");
        }
        this.Pu = pu;
    }

    public void setPu(String s) throws Exception{
        setPu(Long.parseLong(s));
    }
}

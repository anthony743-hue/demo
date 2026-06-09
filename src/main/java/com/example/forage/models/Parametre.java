package com.example.forage.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.GenerationType;

@Entity
public class Parametre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @ManyToOne
    @JoinColumn(name = "idStatus1", nullable = false)
    private Status status1;

    @ManyToOne
    @JoinColumn(name = "idStatus2", nullable = false)
    private Status status2;
    private Long duree;
    @Column(name = "duree_fin")
    private Long dureeFin;

    public Long getDureeFin() {
        return dureeFin;
    }

    public void setDureeFin(Long dureeFin) {
        this.dureeFin = dureeFin;
    }

    private String alerte;

    public Status getStatus1() {
        return status1;
    }

    public void setStatus1(Status status1) {
        this.status1 = status1;
    }

    public Status getStatus2() {
        return status2;
    }

    public void setStatus2(Status status2) {
        this.status2 = status2;
    }

    public Long getDuree() {
        return duree;
    }

    public void setDuree(Long duree) {
        this.duree = duree;
    }

    public String getAlerte() {
        return alerte;
    }

    public void setAlerte(String alerte) {
        this.alerte = alerte;
    }
}

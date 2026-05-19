package com.example.forage.models;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.CascadeType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.SequenceGenerator;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;

@Entity
public class Devis {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "dev_seq")
    @SequenceGenerator(name = "dev_seq",sequenceName = "devis_SEQ")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "IdDmd", nullable = false)
    private Demande dmd;

    private LocalDate createAt;

    private String observation;

    @OneToMany(mappedBy = "devis", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DevisDetail> details;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Demande getDmd() {
        return dmd;
    }

    public void setDmd(Demande dmd) {
        this.dmd = dmd;
    }
    
    public List<DevisDetail> getDetails() {
        return details;
    }

    public void setDetails(List<DevisDetail> details) {
        this.details = details;
    }

    public LocalDate getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDate createAt) {
        this.createAt = createAt;
    }

    public void setCreateAt(String s){
        if( s == null ){
            setCreateAt(LocalDate.now());
        } else{
            setCreateAt(LocalDate.parse(s));
        }
    }

    public void addDetail(DevisDetail detail) {
        details.add(detail);
        detail.setDevis(this);
    }
}

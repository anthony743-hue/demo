package com.example.forage.models;

import jakarta.persistence.*;

@Entity
@Table(name = "Demande")
public class Demande {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(nullable = false, length = 30)
    private String region;
    
    @Column(nullable = false, length = 30)
    private String district;
    
    @Column(nullable = false, length = 30)
    private String commune;
    
    @Column(nullable = false, length = 30)
    private String fokontany;
    
    @Column(nullable = false, length = 50)
    private String nomClient;
    
    @ManyToOne
    @JoinColumn(name = "idStatus", nullable = false)
    private Status status;
    
    // Constructors
    public Demande() {}
    
    public Demande(String region, String district, String commune, String fokontany, 
                   String nomClient, Status status) {
        this.region = region;
        this.district = district;
        this.commune = commune;
        this.fokontany = fokontany;
        this.nomClient = nomClient;
        this.status = status;
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getRegion() {
        return region;
    }
    
    public void setRegion(String region) {
        this.region = region;
    }
    
    public String getDistrict() {
        return district;
    }
    
    public void setDistrict(String district) {
        this.district = district;
    }
    
    public String getCommune() {
        return commune;
    }
    
    public void setCommune(String commune) {
        this.commune = commune;
    }
    
    public String getFokontany() {
        return fokontany;
    }
    
    public void setFokontany(String fokontany) {
        this.fokontany = fokontany;
    }
    
    public String getNomClient() {
        return nomClient;
    }
    
    public void setNomClient(String nomClient) {
        this.nomClient = nomClient;
    }
    
    public Status getStatus() {
        return status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }
}

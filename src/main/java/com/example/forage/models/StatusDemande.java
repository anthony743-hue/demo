package com.example.forage.models;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "status_Demande")
public class StatusDemande {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "idstatus", nullable = false)
    private Status status;
    
    @ManyToOne
    @JoinColumn(name = "iddemande", nullable = false)
    private Demande demande;
    
    @Column(nullable = false)
    private LocalDateTime daty;
    
    // Constructors
    public StatusDemande() {}

    public StatusDemande(Demande d, LocalDateTime datyTime){
        setStatus(d.getStatus());
        setDemande(d);
        setDaty(datyTime);
    }

    public StatusDemande(Status status, Demande demande, LocalDateTime daty) {
        this.status = status;
        this.demande = demande;
        this.daty = daty;
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Status getStatus() {
        return status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }
    
    public Demande getDemande() {
        return demande;
    }
    
    public void setDemande(Demande demande) {
        this.demande = demande;
    }
    
    public LocalDateTime getDaty() {
        return daty;
    }
    
    public void setDaty(LocalDateTime daty) {
        this.daty = daty;
    }
}

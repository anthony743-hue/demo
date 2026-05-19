package com.example.forage.models;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "status_Demande")
public class StatusDemande {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "idStatus", nullable = false)
    private Status status;
    
    @ManyToOne
    @JoinColumn(name = "idDemande", nullable = false)
    private Demande demande;
    
    @Column(nullable = false)
    private LocalDateTime daty;

    @Column(length = 50)
    private String observation;
    
    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

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

    public void setDaty(String s){
        if( s == null ){
            setDaty(LocalDateTime.now());
        } else{
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            setDaty(LocalDateTime.parse(s, dtf));
        }
    }
}

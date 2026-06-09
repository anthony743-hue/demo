package com.example.forage.models;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.*;

@Entity
@Table(name = "Demande")
public class Demande {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "idClient", nullable = false)
    private Client client;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idstatus")
    private Status status;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idCommune", nullable = false)
    private Commune commune;

    private String reference;

    private LocalDateTime createAt;

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public void setCreateAt(String s) {
        if (s == null) {
            setCreateAt(LocalDateTime.now());
        } else {
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm[:ss][.SSSSSS]");
            setCreateAt(LocalDateTime.parse(s, dtf));
        }
    }


  public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public Commune getCommune() {
        return commune;
    }

    public void setCommune(Commune commune) {
        this.commune = commune;
    }

    // Constructors
    public Demande() {}

    public String getLocalisation(){
        return commune.toString();
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public void setId(String s){
        setId(Integer.parseInt(s));
    }

    public Status getStatus() {
        return status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }
}

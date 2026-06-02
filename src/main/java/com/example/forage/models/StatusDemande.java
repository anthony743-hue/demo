package com.example.forage.models;

import jakarta.persistence.*;

import java.time.LocalDate;
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
    
    private Long DT;

    public Long getDT() {
        return DT;
    }

    public void setDT(Long dT) {
        DT = dT;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    @Override
    public boolean equals(Object o){
        if( o instanceof StatusDemande s){
            return id == s.id && daty.isEqual(s.getDaty())
            && observation.equals(s.getObservation()) && status.getId() == (s.getStatus().getId()) && 
            demande.getId() == s.getDemande().getId();
        }
        Long a = 0;
        return false;
    }

    public Long getDiff(StatusDemande other){
        Long a1 = getDiffMinutes(true);
        Long a2 = other.getDiffMinutes(false);

        Long w1 = getDiffInDayWeek();
        Long w2 = other.getDiffInDayWeek();        
        return 0L;
    }

    private Long getDiffMinutes(boolean before){
        long a1 = before ? 57600 : 28800;
        long a2 = daty.getHour() * 3600 + daty.getMinute() * 60 + daty.getSecond();
        return Math.abs(a1 - a2) / 60;
    }   

    private Long getDiffInWeek(StatusDemande std){
        
        return 0L;
    }

    private Long getDiffInDayWeek(){
        long second_day = 28800;
        return (5 - (long) (daty.getDayOfWeek().getValue())) * second_day;
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

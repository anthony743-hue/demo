package com.example.forage.models;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

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
    
    private Long dt;

    public Long getDT() {
        return dt;
    }

    public void setDT(Long dT) {
        this.dt = dT;
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
        return false;
    }

    public Long getDiff(StatusDemande other){
        Long a1 = getDiffMinutes(true);
        Long a2 = other.getDiffMinutes(false);

        Long diffWeek =  getDiffInWeek(other);
        Long w1 = 0L;
        Long w2 = 0L;
        if(diffWeek > 0){
            w1 = getDiffInDayWeek();
            w2 = other.getDiffInDayWeek();
        }
        
        System.out.println(String.format("Jour S1 %d S2 %d", daty.getDayOfWeek().getValue(),other.getDaty().getDayOfWeek().getValue()));
        System.out.println(String.format("A1 %d A2 %d w1 %d w2 %d  W3 %d", a1,a2,w1,w2,getDiffInWeek(other)));
        return a1 + a2 + w1 + w2 + diffWeek;
    }

    private Long getDiffMinutes(boolean before){
        long a1 = before ? 960 : 480;
        long a2 = daty.getHour() * 60 + daty.getMinute();
        long diff = before ? a1 - a2 : a2 - a1;
        return Math.max(Math.min(diff,960),0);
    }   

    private Long getDiffInWeek(StatusDemande std){
        long diffInDay = daty.until(std.getDaty(), ChronoUnit.DAYS);
        long diff = 0L;
        if( diffInDay > 7 ){
            diff = daty.until(std.getDaty(), ChronoUnit.WEEKS) * 2400;
        }
        return diff;
    }

    private Long getDiffInDayWeek(){
        long minutes_day = 480;
        return Math.max((5 - (long) (daty.getDayOfWeek().getValue())),0) * minutes_day;
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
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm[:ss][.SSSSSS]");
            setDaty(LocalDateTime.parse(s, dtf));
        }
    }
}

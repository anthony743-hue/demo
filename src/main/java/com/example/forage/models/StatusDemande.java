package com.example.forage.models;

import jakarta.persistence.*;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "status_Demande")
public class StatusDemande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
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

    private static final LocalDate LUNDI_REF = LocalDate.of(1900, 1, 1); // un lundi

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
    public boolean equals(Object o) {
        if (o instanceof StatusDemande s) {
            boolean a = id == s.id && daty.isEqual(s.getDaty());
            boolean b = status.getId() == (s.getStatus().getId()) &&
                    demande.getId() == s.getDemande().getId();
            boolean c = observation != null && s.getObservation() != null && observation.equals(s.getObservation());
            return a && b && c;
        }
        return false;
    }

    public Long getDiff(StatusDemande other) {
        LocalDateTime debut = ajusterDebut(this.daty);
        LocalDateTime fin = ajusterFin(other.getDaty());

        if (debut.isAfter(fin)) {
            return 0L;
        }

        LocalDate dateDebut = debut.toLocalDate();
        LocalDate dateFin = fin.toLocalDate();

        // Même jour
        if (dateDebut.equals(dateFin)) {
            return Duration.between(debut, fin).toMinutes();
        }

        // Minutes du premier jour (de l'heure ajustée à 16:00)
        long minPremierJour = Duration.between(debut.toLocalTime(), LocalTime.of(16, 0)).toMinutes();
        // Minutes du dernier jour (de 8:00 à l'heure ajustée)
        long minDernierJour = Duration.between(LocalTime.of(8, 0), fin.toLocalTime()).toMinutes();

        // Jours ouvrés complets entre dateDebut (exclu) et dateFin (exclu)
        long joursComplets = 0L;
        if (dateDebut.plusDays(1).isBefore(dateFin)) {
            long joursOuvres = joursOuvresJusquau(dateFin.minusDays(1)) - joursOuvresJusquau(dateDebut);
            joursComplets = joursOuvres * 480; // 8h = 480 min
        }

        return minPremierJour + minDernierJour + joursComplets;
    }

    // --- Ajustements sans boucle ---

    /**
     * Ramène la date au prochain moment travaillé (>= ldt), sans boucle.
     */
    private LocalDateTime ajusterDebut(LocalDateTime ldt) {
        LocalDate date = ldt.toLocalDate();
        LocalTime time = ldt.toLocalTime();
        int dow = date.getDayOfWeek().getValue(); // 1=lundi … 7=dimanche

        if (dow >= 6) { // samedi ou dimanche
            date = date.plusDays(dow == 6 ? 2 : 1); // samedi +2, dimanche +1 -> lundi suivant
            return LocalDateTime.of(date, LocalTime.of(8, 0));
        }

        // jour de semaine
        if (time.isBefore(LocalTime.of(8, 0))) {
            return LocalDateTime.of(date, LocalTime.of(8, 0));
        } else if (time.isAfter(LocalTime.of(16, 0))) {
            // prochain jour ouvré après aujourd'hui
            date = date.plusDays(dow == 5 ? 3 : 1); // vendredi -> +3 (lundi), autre -> +1
            return LocalDateTime.of(date, LocalTime.of(8, 0));
        }
        return ldt; // déjà dans la plage
    }

    /**
     * Ramène la date au dernier moment travaillé (<= ldt), sans boucle.
     */
    private LocalDateTime ajusterFin(LocalDateTime ldt) {
        LocalDate date = ldt.toLocalDate();
        LocalTime time = ldt.toLocalTime();
        int dow = date.getDayOfWeek().getValue();

        if (dow >= 6) { // samedi ou dimanche
            date = date.minusDays(dow == 6 ? 1 : 2); // samedi -1 -> vendredi, dimanche -2 -> vendredi
            return LocalDateTime.of(date, LocalTime.of(16, 0));
        }

        // jour de semaine
        if (time.isAfter(LocalTime.of(16, 0))) {
            return LocalDateTime.of(date, LocalTime.of(16, 0));
        } else if (time.isBefore(LocalTime.of(8, 0))) {
            // jour ouvré précédent
            date = date.minusDays(dow == 1 ? 3 : 1); // lundi -> -3 (vendredi), autre -> -1
            return LocalDateTime.of(date, LocalTime.of(16, 0));
        }
        return ldt;
    }

    // --- Calcul du nombre de jours ouvrés (lun-ven) jusqu’à une date (incluse) ---

    /**
     * Renvoie le nombre de jours ouvrés entre le lundi de référence (LUNDI_REF)
     * et la date donnée, inclusivement. Formule pure, sans itération.
     */
    private long joursOuvresJusquau(LocalDate date) {
        long joursDepuisRef = ChronoUnit.DAYS.between(LUNDI_REF, date);
        long semaines = joursDepuisRef / 7;
        long reste = joursDepuisRef % 7; // 0 = lundi … 6 = dimanche
        return semaines * 5 + Math.min(reste + 1, 5);
    }

    // public Long getDiff(StatusDemande other){
    // Long a1 = getDiffMinutes(true);
    // Long a2 = other.getDiffMinutes(false);

    // Long diffWeek = getDiffInWeek(other);
    // Long w1 = 0L;
    // Long w2 = 0L;
    // if(diffWeek > 0){
    // w1 = getDiffInDayWeek();
    // w2 = other.getDiffInDayWeek();
    // }

    // System.out.println(String.format("Jour S1 %d S2 %d",
    // daty.getDayOfWeek().getValue(),other.getDaty().getDayOfWeek().getValue()));
    // System.out.println(String.format("A1 %d A2 %d w1 %d w2 %d W3 %d",
    // a1,a2,w1,w2,getDiffInWeek(other)));
    // return a1 + a2 + w1 + w2 + diffWeek;
    // }

    // private Long getDiffMinutes(boolean before){
    // long a1 = before ? 960 : 480;
    // long a2 = daty.getHour() * 60 + daty.getMinute();
    // long diff = before ? a1 - a2 : a2 - a1;
    // return Math.max(Math.min(diff,960),0);
    // }

    // private Long getDiffInWeek(StatusDemande std){
    // long diffInDay = daty.until(std.getDaty(), ChronoUnit.DAYS);
    // long diff = 0L;
    // if( diffInDay > 7 ){
    // diff = daty.until(std.getDaty(), ChronoUnit.WEEKS) * 2400;
    // }
    // return diff;
    // }

    // private Long getDiffInDayWeek(){
    // long minutes_day = 480;
    // return Math.max((5 - (long) (daty.getDayOfWeek().getValue())),0) *
    // minutes_day;
    // }

    // Constructors
    public StatusDemande() {
    }

    public StatusDemande(Demande d, LocalDateTime datyTime) {
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

    public void setDaty(String s) {
        if (s == null) {
            setDaty(LocalDateTime.now());
        } else {
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm[:ss][.SSSSSS]");
            setDaty(LocalDateTime.parse(s, dtf));
        }
    }
}

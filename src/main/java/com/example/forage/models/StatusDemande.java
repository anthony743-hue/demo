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

    public Long getDt() {
        return dt;
    }

    public void setDt(Long dt) {
        this.dt = dt;
    }

    private static final LocalDate LUNDI_REF = LocalDate.of(1900, 1, 1); // un lundi

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof StatusDemande s) {
            boolean a = id == s.id && daty != null && s.getDaty() != null && daty.isEqual(s.getDaty());
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

        // if (debut.isAfter(fin)) {
        //     return 0L;
        // }

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

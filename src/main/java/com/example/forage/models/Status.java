package com.example.forage.models;

import jakarta.persistence.*;

@Entity
@Table(name = "Status")
public class Status {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(unique = true, nullable = false, length = 30)
    private String designation;
    
    // Constructors
    public Status() {}
    
    public Status(String designation) {
        this.designation = designation;
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getDesignation() {
        return designation;
    }
    
    public void setDesignation(String designation) {
        this.designation = designation;
    }
}

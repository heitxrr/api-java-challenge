package com.motoflow.motoflow.model;


import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "setor")
public class Setor implements Serializable {

    @Id
    @Column(name = "id_setor")
    private Long id;

    @Column(name = "nm_setor", nullable = false)
    private String nome;

    // Getters e Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}

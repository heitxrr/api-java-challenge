package com.motoflow.motoflow.model;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonAlias;
import java.io.Serializable;

@Entity
@Table(name = "modelo")
public class Modelo implements Serializable {

    @Id
    @Column(name = "id_modelo")
    private Long id;

    @Column(name = "nm_modelo", nullable = false)
    @JsonProperty("nome")
    @JsonAlias({"nm_modelo"})
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
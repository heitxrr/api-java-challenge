package com.motoflow.motoflow.model;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "operador")
public class Operador implements Serializable {

    @Id
    @Column(name = "id_operador")
    private Long id;

    @Column(name = "nm_operador", nullable = false)
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

    // ...existing code...
}

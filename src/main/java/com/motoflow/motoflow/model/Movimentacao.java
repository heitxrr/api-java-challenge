package com.motoflow.motoflow.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "movimentacao")
public class Movimentacao implements Serializable {
    @Transient
    private String placa; // Para receber a placa no JSON

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "movimentacao_seq")
    @SequenceGenerator(name = "movimentacao_seq", sequenceName = "SEQ_MOVIMENTACAO", allocationSize = 1)
    @Column(name = "id_mov")
    private Long id;

    @Column(name = "dt_mov", nullable = false)
    private LocalDateTime dataMovimentacao;

    @ManyToOne
    @JoinColumn(name = "id_moto", nullable = false)
    private Moto moto;

    @ManyToOne
    @JoinColumn(name = "id_setor", nullable = false)
    private Setor setor;

    @ManyToOne
    @JoinColumn(name = "id_operador_origem", nullable = false)
    private Operador operadorOrigem;

    @ManyToOne
    @JoinColumn(name = "id_operador_destino")
    private Operador operadorDestino;

    // Getters e Setters
    public String getPlaca() {
        return placa;
    }
    public void setPlaca(String placa) {
        this.placa = placa;
    }
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getDataMovimentacao() {
        return dataMovimentacao;
    }

    public void setDataMovimentacao(LocalDateTime dataMovimentacao) {
        this.dataMovimentacao = dataMovimentacao;
    }

    public Moto getMoto() {
        return moto;
    }

    public void setMoto(Moto moto) {
        this.moto = moto;
    }

    public Setor getSetor() {
        return setor;
    }

    public void setSetor(Setor setor) {
        this.setor = setor;
    }

    public Operador getOperadorOrigem() {
        return operadorOrigem;
    }

    public void setOperadorOrigem(Operador operadorOrigem) {
        this.operadorOrigem = operadorOrigem;
    }

    public Operador getOperadorDestino() {
        return operadorDestino;
    }

    public void setOperadorDestino(Operador operadorDestino) {
        this.operadorDestino = operadorDestino;
    }
}
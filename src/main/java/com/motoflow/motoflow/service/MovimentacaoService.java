package com.motoflow.motoflow.service;

import com.motoflow.motoflow.model.Movimentacao;
import com.motoflow.motoflow.repository.MovimentacaoRepository;
import com.motoflow.motoflow.repository.MotoRepository;
import com.motoflow.motoflow.model.Moto;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MovimentacaoService {

    private final MovimentacaoRepository movimentacaoRepository;
    private final MotoRepository motoRepository;

    public MovimentacaoService(MovimentacaoRepository movimentacaoRepository, MotoRepository motoRepository) {
        this.movimentacaoRepository = movimentacaoRepository;
        this.motoRepository = motoRepository;
    }

    public List<Movimentacao> findAll() {
        return movimentacaoRepository.findAll();
    }

    public Optional<Movimentacao> findById(Long id) {
        return movimentacaoRepository.findById(id);
    }

    public Movimentacao save(Movimentacao movimentacao) {
        // Sempre buscar a moto pela placa recebida, ignorando qualquer objeto moto vindo no JSON
        if (movimentacao.getPlaca() != null && !movimentacao.getPlaca().isEmpty()) {
            Moto moto = motoRepository.findByPlaca(movimentacao.getPlaca());
            if (moto == null) {
                throw new IllegalArgumentException("Moto com placa " + movimentacao.getPlaca() + " não encontrada.");
            }
            movimentacao.setMoto(moto);
        } else if (movimentacao.getMoto() != null && movimentacao.getMoto().getId() != null) {
            // fallback: se vier só o id da moto
            Moto moto = motoRepository.findById(movimentacao.getMoto().getId()).orElse(null);
            if (moto == null) {
                throw new IllegalArgumentException("Moto com id " + movimentacao.getMoto().getId() + " não encontrada.");
            }
            movimentacao.setMoto(moto);
        } else {
            throw new IllegalArgumentException("É necessário informar a placa ou o id da moto.");
        }
        if (movimentacao.getDataMovimentacao() == null) {
            movimentacao.setDataMovimentacao(java.time.LocalDateTime.now());
        }
        return movimentacaoRepository.save(movimentacao);
    }

    public void delete(Long id) {
        movimentacaoRepository.deleteById(id);
    }
}
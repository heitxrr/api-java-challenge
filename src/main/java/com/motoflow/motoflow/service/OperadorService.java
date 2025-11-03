package com.motoflow.motoflow.service;

import com.motoflow.motoflow.model.Operador;
import com.motoflow.motoflow.repository.OperadorRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OperadorService {

    private final OperadorRepository operadorRepository;

    public OperadorService(OperadorRepository operadorRepository) {
        this.operadorRepository = operadorRepository;
    }

    public List<Operador> findAll() {
        return operadorRepository.findAll();
    }

    public Optional<Operador> findById(Long id) {
        return operadorRepository.findById(id);
    }

    public Operador save(Operador operador) {
        return operadorRepository.save(operador);
    }

    public void delete(Long id) {
        operadorRepository.deleteById(id);
    }
}

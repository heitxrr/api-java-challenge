package com.motoflow.motoflow.service;

import com.motoflow.motoflow.model.Modelo;
import com.motoflow.motoflow.repository.ModeloRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ModeloService {

    private final ModeloRepository modeloRepository;

    public ModeloService(ModeloRepository modeloRepository) {
        this.modeloRepository = modeloRepository;
    }

    public List<Modelo> findAll() {
        return modeloRepository.findAll();
    }

    public Optional<Modelo> findById(Long id) {
        return modeloRepository.findById(id);
    }

    public Modelo save(Modelo modelo) {
        return modeloRepository.save(modelo);
    }

    public void delete(Long id) {
        modeloRepository.deleteById(id);
    }
}

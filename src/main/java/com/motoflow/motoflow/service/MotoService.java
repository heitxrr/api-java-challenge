
package com.motoflow.motoflow.service;

import com.motoflow.motoflow.model.Moto;
import com.motoflow.motoflow.repository.MotoRepository;
import com.motoflow.motoflow.model.Modelo;
import com.motoflow.motoflow.repository.ModeloRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MotoService {

    private final MotoRepository motoRepository;
    private final ModeloRepository modeloRepository;

    public MotoService(MotoRepository motoRepository, ModeloRepository modeloRepository) {
        this.motoRepository = motoRepository;
        this.modeloRepository = modeloRepository;
    }

    public List<Moto> findAll() {
        return motoRepository.findAll();
    }

    public Optional<Moto> findById(Long id) {
        return motoRepository.findById(id);
    }

    public Moto save(Moto moto) {
        Modelo modelo = moto.getModelo();
        if (modelo == null || modelo.getNome() == null || modelo.getNome().trim().isEmpty()) {
            throw new IllegalArgumentException("O campo 'nome' do modelo é obrigatório e não pode ser nulo ou vazio.");
        }
        if (modelo.getId() == null || !modeloRepository.existsById(modelo.getId())) {
            modelo = modeloRepository.save(modelo);
            moto.setModelo(modelo);
        }
        return motoRepository.save(moto);
    }

    public void delete(Long id) {
        motoRepository.deleteById(id);
    }

    public List<Moto> findMotosBySetor(Long idSetor) {
        return motoRepository.findMotosBySetor(idSetor);
    }
}

package com.motoflow.motoflow.controller;

import com.motoflow.motoflow.model.Modelo;
import com.motoflow.motoflow.service.ModeloService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/modelos")
public class ModeloController {

    private final ModeloService modeloService;

    public ModeloController(ModeloService modeloService) {
        this.modeloService = modeloService;
    }

    @GetMapping
    public List<Modelo> getAll() {
        return modeloService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Modelo> getById(@PathVariable Long id) {
        return modeloService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Modelo create(@RequestBody Modelo modelo) {
        return modeloService.save(modelo);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Modelo> update(@PathVariable Long id, @RequestBody Modelo modelo) {
        return modeloService.findById(id)
                .map(existing -> {
                    modelo.setId(id);
                    return ResponseEntity.ok(modeloService.save(modelo));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (modeloService.findById(id).isPresent()) {
            modeloService.delete(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}

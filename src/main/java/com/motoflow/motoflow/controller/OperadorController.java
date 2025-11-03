package com.motoflow.motoflow.controller;

import com.motoflow.motoflow.model.Operador;
import com.motoflow.motoflow.service.OperadorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/operadores")
public class OperadorController {

    private final OperadorService operadorService;

    public OperadorController(OperadorService operadorService) {
        this.operadorService = operadorService;
    }

    @GetMapping
    public List<Operador> getAll() {
        return operadorService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Operador> getById(@PathVariable Long id) {
        return operadorService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Operador create(@RequestBody Operador operador) {
        return operadorService.save(operador);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Operador> update(@PathVariable Long id, @RequestBody Operador operador) {
        return operadorService.findById(id)
                .map(existing -> {
                    operador.setId(id);
                    return ResponseEntity.ok(operadorService.save(operador));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (operadorService.findById(id).isPresent()) {
            operadorService.delete(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}

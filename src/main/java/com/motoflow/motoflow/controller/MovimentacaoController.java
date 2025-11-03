package com.motoflow.motoflow.controller;

import com.motoflow.motoflow.model.Movimentacao;
import com.motoflow.motoflow.service.MovimentacaoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/movimentacoes")
public class MovimentacaoController {

    private final MovimentacaoService movimentacaoService;

    public MovimentacaoController(MovimentacaoService movimentacaoService) {
        this.movimentacaoService = movimentacaoService;
    }

    @GetMapping
    public List<Movimentacao> getAll() {
        return movimentacaoService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Movimentacao> getById(@PathVariable Long id) {
        return movimentacaoService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Movimentacao create(@RequestBody Movimentacao movimentacao) {
        return movimentacaoService.save(movimentacao);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Movimentacao> update(@PathVariable Long id, @RequestBody Movimentacao movimentacao) {
        return movimentacaoService.findById(id)
                .map(existing -> {
                    movimentacao.setId(id);
                    return ResponseEntity.ok(movimentacaoService.save(movimentacao));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (movimentacaoService.findById(id).isPresent()) {
            movimentacaoService.delete(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}